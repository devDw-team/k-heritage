import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/tour_attraction.dart';
import '../../domain/entities/tour_festival.dart';
import '../../domain/entities/tour_stay.dart';
import '../../domain/repositories/ktour_repository.dart';
import '../datasources/tour_api_datasource.dart';

/// K-TOUR Repository 구현
class KTourRepositoryImpl implements KTourRepository {
  final TourAPIDataSource _tourAPI;
  final SharedPreferences _prefs;
  
  // 캐시 키 접두사
  static const String _cacheKeyPrefix = 'ktour_cache_';
  static const String _bookmarkKeyPrefix = 'ktour_bookmark_';
  static const Duration _cacheExpiry = Duration(hours: 24);
  
  KTourRepositoryImpl({
    required TourAPIDataSource tourAPI,
    required SharedPreferences prefs,
  })  : _tourAPI = tourAPI,
        _prefs = prefs;
  
  @override
  Future<List<TourAttraction>> getAttractionsByArea({
    String? areaCode,
    String? sigunguCode,
    int? contentTypeId,
    String? cat1,
    String? cat2,
    String? cat3,
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final cacheKey = _buildCacheKey('area_attractions', {
        'area': areaCode,
        'sigungu': sigunguCode,
        'type': contentTypeId,
        'cat1': cat1,
        'cat2': cat2,
        'cat3': cat3,
        'page': pageNo,
      });
      
      // 캐시 확인
      final cached = _getCachedList<TourAttraction>(cacheKey);
      if (cached != null) return cached;
      
      // API 호출
      final response = await _tourAPI.getAreaBasedList(
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        contentTypeId: contentTypeId?.toString(),
        cat1: cat1,
        cat2: cat2,
        cat3: cat3,
        pageNo: pageNo,
        numOfRows: numOfRows,
      );
      
      // 변환
      final attractions = response
          .map((data) => TourAttraction.fromApiResponse(data))
          .toList();
      
      // 북마크 상태 업데이트
      await _updateBookmarkStatus(attractions);
      
      // 캐시 저장
      _cacheList(cacheKey, attractions);
      
      return attractions;
    } catch (e) {
      Log.e('Failed to get attractions by area', error: e);
      rethrow;
    }
  }
  
  @override
  Future<List<TourAttraction>> getNearbyAttractions({
    required double latitude,
    required double longitude,
    int radius = 5000,
    int? contentTypeId,
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final cacheKey = _buildCacheKey('nearby_attractions', {
        'lat': latitude.toStringAsFixed(4),
        'lon': longitude.toStringAsFixed(4),
        'radius': radius,
        'type': contentTypeId,
        'page': pageNo,
      });
      
      // 캐시 확인
      final cached = _getCachedList<TourAttraction>(cacheKey);
      if (cached != null) return cached;
      
      // API 호출
      final response = await _tourAPI.getLocationBasedList(
        mapX: longitude,
        mapY: latitude,
        radius: radius,
        contentTypeId: contentTypeId?.toString(),
        pageNo: pageNo,
        numOfRows: numOfRows,
      );
      
      // 변환
      final attractions = response
          .map((data) => TourAttraction.fromApiResponse(data))
          .toList();
      
      // 북마크 상태 업데이트
      await _updateBookmarkStatus(attractions);
      
      // 거리순 정렬
      attractions.sort((a, b) {
        final distA = a.distance ?? double.infinity;
        final distB = b.distance ?? double.infinity;
        return distA.compareTo(distB);
      });
      
      // 캐시 저장
      _cacheList(cacheKey, attractions);
      
      return attractions;
    } catch (e) {
      Log.e('Failed to get nearby attractions', error: e);
      rethrow;
    }
  }
  
  @override
  Future<List<TourAttraction>> searchAttractions({
    required String keyword,
    String? areaCode,
    String? sigunguCode,
    int? contentTypeId,
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final response = await _tourAPI.searchByKeyword(
        keyword: keyword,
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        contentTypeId: contentTypeId?.toString(),
        pageNo: pageNo,
        numOfRows: numOfRows,
      );
      
      final attractions = response
          .map((data) => TourAttraction.fromApiResponse(data))
          .toList();
      
      await _updateBookmarkStatus(attractions);
      
      return attractions;
    } catch (e) {
      Log.e('Failed to search attractions', error: e);
      rethrow;
    }
  }
  
  @override
  Future<TourAttraction?> getAttractionDetail({
    required String contentId,
    int? contentTypeId,
  }) async {
    try {
      final cacheKey = _buildCacheKey('attraction_detail', {'id': contentId});
      
      // 캐시 확인
      final cached = _getCachedItem<TourAttraction>(cacheKey);
      if (cached != null) return cached;
      
      // 공통 정보 조회
      final commonData = await _tourAPI.getDetailCommon(
        contentId: contentId,
        contentTypeId: contentTypeId?.toString(),
      );
      
      if (commonData.isEmpty) return null;
      
      // 기본 정보 생성
      var attraction = TourAttraction.fromApiResponse(commonData);
      
      // 소개 정보 조회 (contentTypeId 필요)
      if (contentTypeId != null) {
        try {
          final introData = await _tourAPI.getDetailIntro(
            contentId: contentId,
            contentTypeId: contentTypeId.toString(),
          );
          
          // 소개 정보 병합
          attraction = attraction.copyWith(
            openTime: introData['usetime'],
            restDate: introData['restdate'],
            useFee: introData['usefee'],
            spendTime: introData['spendtime'],
            parking: introData['parking'],
            infocenter: introData['infocenter'],
            disability: introData['chkbabycarriage'],
            stroller: introData['chkbabycarriage'],
            pet: introData['chkpet'],
            creditcard: introData['chkcreditcard'],
          );
        } catch (e) {
          Log.w('Failed to get intro data', error: e);
        }
      }
      
      // 북마크 상태 확인
      final bookmarkIds = await getBookmarkIds();
      attraction = attraction.copyWith(
        isBookmarked: bookmarkIds.contains(contentId),
      );
      
      // 캐시 저장
      _cacheItem(cacheKey, attraction);
      
      return attraction;
    } catch (e) {
      Log.e('Failed to get attraction detail', error: e);
      rethrow;
    }
  }
  
  @override
  Future<List<TourFestival>> getFestivals({
    required DateTime startDate,
    DateTime? endDate,
    String? areaCode,
    String? sigunguCode,
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final dateFormat = DateFormat('yyyyMMdd');
      final cacheKey = _buildCacheKey('festivals', {
        'start': dateFormat.format(startDate),
        'end': endDate != null ? dateFormat.format(endDate) : null,
        'area': areaCode,
        'sigungu': sigunguCode,
        'page': pageNo,
      });
      
      // 캐시 확인
      final cached = _getCachedList<TourFestival>(cacheKey);
      if (cached != null) return cached;
      
      // API 호출
      final response = await _tourAPI.searchFestival(
        eventStartDate: dateFormat.format(startDate),
        eventEndDate: endDate != null ? dateFormat.format(endDate) : null,
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        pageNo: pageNo,
        numOfRows: numOfRows,
      );
      
      // 변환
      final festivals = response
          .map((data) => TourFestival.fromApiResponse(data))
          .toList();
      
      // 북마크 상태 업데이트
      await _updateBookmarkStatusForFestivals(festivals);
      
      // 캐시 저장
      _cacheList(cacheKey, festivals);
      
      return festivals;
    } catch (e) {
      Log.e('Failed to get festivals', error: e);
      rethrow;
    }
  }
  
  @override
  Future<List<TourFestival>> getOngoingFestivals({
    String? areaCode,
    String? sigunguCode,
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    final now = DateTime.now();
    return getFestivals(
      startDate: now,
      endDate: now,
      areaCode: areaCode,
      sigunguCode: sigunguCode,
      pageNo: pageNo,
      numOfRows: numOfRows,
    );
  }
  
  @override
  Future<List<TourFestival>> getUpcomingFestivals({
    String? areaCode,
    String? sigunguCode,
    int daysAhead = 30,
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    final now = DateTime.now();
    final future = now.add(Duration(days: daysAhead));
    
    return getFestivals(
      startDate: now,
      endDate: future,
      areaCode: areaCode,
      sigunguCode: sigunguCode,
      pageNo: pageNo,
      numOfRows: numOfRows,
    );
  }
  
  @override
  Future<TourFestival?> getFestivalDetail({
    required String contentId,
  }) async {
    try {
      final cacheKey = _buildCacheKey('festival_detail', {'id': contentId});
      
      // 캐시 확인
      final cached = _getCachedItem<TourFestival>(cacheKey);
      if (cached != null) return cached;
      
      // 공통 정보 조회
      final commonData = await _tourAPI.getDetailCommon(
        contentId: contentId,
        contentTypeId: TourContentType.festival.toString(),
      );
      
      if (commonData.isEmpty) return null;
      
      // 기본 정보 생성
      var festival = TourFestival.fromApiResponse(commonData);
      
      // 북마크 상태 확인
      final bookmarkIds = await getBookmarkIds();
      festival = festival.copyWith(
        isBookmarked: bookmarkIds.contains(contentId),
      );
      
      // 캐시 저장
      _cacheItem(cacheKey, festival);
      
      return festival;
    } catch (e) {
      Log.e('Failed to get festival detail', error: e);
      rethrow;
    }
  }
  
  @override
  Future<List<TourStay>> getStays({
    String? areaCode,
    String? sigunguCode,
    bool? hanOk,
    bool? goodStay,
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final cacheKey = _buildCacheKey('stays', {
        'area': areaCode,
        'sigungu': sigunguCode,
        'hanok': hanOk,
        'goodstay': goodStay,
        'page': pageNo,
      });
      
      // 캐시 확인
      final cached = _getCachedList<TourStay>(cacheKey);
      if (cached != null) return cached;
      
      // API 호출
      final response = await _tourAPI.searchStay(
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        hanOk: hanOk == true ? 'Y' : null,
        goodStay: goodStay == true ? 'Y' : null,
        pageNo: pageNo,
        numOfRows: numOfRows,
      );
      
      // 변환
      final stays = response
          .map((data) => TourStay.fromApiResponse(data))
          .toList();
      
      // 북마크 상태 업데이트
      await _updateBookmarkStatusForStays(stays);
      
      // 캐시 저장
      _cacheList(cacheKey, stays);
      
      return stays;
    } catch (e) {
      Log.e('Failed to get stays', error: e);
      rethrow;
    }
  }
  
  @override
  Future<List<TourStay>> getNearbyStays({
    required double latitude,
    required double longitude,
    int radius = 5000,
    bool? hanOk,
    bool? goodStay,
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final cacheKey = _buildCacheKey('nearby_stays', {
        'lat': latitude.toStringAsFixed(4),
        'lon': longitude.toStringAsFixed(4),
        'radius': radius,
        'hanok': hanOk,
        'goodstay': goodStay,
        'page': pageNo,
      });
      
      // 캐시 확인
      final cached = _getCachedList<TourStay>(cacheKey);
      if (cached != null) return cached;
      
      // API 호출 (숙박 contentTypeId = 32)
      final response = await _tourAPI.getLocationBasedList(
        mapX: longitude,
        mapY: latitude,
        radius: radius,
        contentTypeId: TourContentType.accommodation.toString(),
        pageNo: pageNo,
        numOfRows: numOfRows,
      );
      
      // 변환
      var stays = response
          .map((data) => TourStay.fromApiResponse(data))
          .toList();
      
      // 한옥/굿스테이 필터링 (필요시)
      if (hanOk == true) {
        stays = stays.where((s) => s.hanOk == true).toList();
      }
      if (goodStay == true) {
        stays = stays.where((s) => s.goodStay == true).toList();
      }
      
      // 북마크 상태 업데이트
      await _updateBookmarkStatusForStays(stays);
      
      // 거리순 정렬
      stays.sort((a, b) {
        final distA = a.distance ?? double.infinity;
        final distB = b.distance ?? double.infinity;
        return distA.compareTo(distB);
      });
      
      // 캐시 저장
      _cacheList(cacheKey, stays);
      
      return stays;
    } catch (e) {
      Log.e('Failed to get nearby stays', error: e);
      rethrow;
    }
  }
  
  @override
  Future<TourStay?> getStayDetail({
    required String contentId,
  }) async {
    try {
      final cacheKey = _buildCacheKey('stay_detail', {'id': contentId});
      
      // 캐시 확인
      final cached = _getCachedItem<TourStay>(cacheKey);
      if (cached != null) return cached;
      
      // 공통 정보 조회
      final commonData = await _tourAPI.getDetailCommon(
        contentId: contentId,
        contentTypeId: TourContentType.accommodation.toString(),
      );
      
      if (commonData.isEmpty) return null;
      
      // 기본 정보 생성
      var stay = TourStay.fromApiResponse(commonData);
      
      // 소개 정보 조회
      try {
        final introData = await _tourAPI.getDetailIntro(
          contentId: contentId,
          contentTypeId: TourContentType.accommodation.toString(),
        );
        
        // 소개 정보 병합
        stay = stay.copyWith(
          checkInTime: introData['checkintime'],
          checkOutTime: introData['checkouttime'],
          roomType: introData['roomtype'],
          roomCount: int.tryParse(introData['roomcount']?.toString() ?? ''),
          parking: introData['parkinglodging'],
          reservationUrl: introData['reservationurl'],
          reservationTel: introData['reservationlodging'],
          accomCount: introData['accomcountlodging'],
          foodPlace: introData['foodplace'],
          pickup: introData['pickup'],
          cooking: introData['chkcooking'],
          barbecue: introData['barbecue'],
          fitness: introData['fitness'],
          sauna: introData['sauna'],
          publicBath: introData['publicbath'],
          publicPc: introData['publicpc'],
          seminar: introData['seminar'],
          sports: introData['sports'],
          refundPolicy: introData['refundregulation'],
        );
      } catch (e) {
        Log.w('Failed to get stay intro data', error: e);
      }
      
      // 북마크 상태 확인
      final bookmarkIds = await getBookmarkIds();
      stay = stay.copyWith(
        isBookmarked: bookmarkIds.contains(contentId),
      );
      
      // 캐시 저장
      _cacheItem(cacheKey, stay);
      
      return stay;
    } catch (e) {
      Log.e('Failed to get stay detail', error: e);
      rethrow;
    }
  }
  
  @override
  Future<List<AreaCode>> getAreaCodes({String? parentCode}) async {
    try {
      final response = await _tourAPI.getAreaCodes(areaCode: parentCode);
      return response.map((data) => AreaCode.fromJson(data)).toList();
    } catch (e) {
      Log.e('Failed to get area codes', error: e);
      rethrow;
    }
  }
  
  @override
  Future<List<CategoryCode>> getCategoryCodes({
    String? cat1,
    String? cat2,
  }) async {
    try {
      final response = await _tourAPI.getCategoryCodes(
        cat1: cat1,
        cat2: cat2,
      );
      return response.map((data) => CategoryCode.fromJson(data)).toList();
    } catch (e) {
      Log.e('Failed to get category codes', error: e);
      rethrow;
    }
  }
  
  @override
  Future<void> addBookmark({
    required String contentId,
    required String contentType,
  }) async {
    final key = '$_bookmarkKeyPrefix$contentId';
    await _prefs.setString(key, contentType);
  }
  
  @override
  Future<void> removeBookmark({required String contentId}) async {
    final key = '$_bookmarkKeyPrefix$contentId';
    await _prefs.remove(key);
  }
  
  @override
  Future<List<String>> getBookmarkIds() async {
    final keys = _prefs.getKeys();
    return keys
        .where((key) => key.startsWith(_bookmarkKeyPrefix))
        .map((key) => key.replaceFirst(_bookmarkKeyPrefix, ''))
        .toList();
  }
  
  @override
  Future<void> clearCache() async {
    final keys = _prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_cacheKeyPrefix)) {
        await _prefs.remove(key);
      }
    }
  }
  
  // ===== 헬퍼 메서드들 =====
  
  String _buildCacheKey(String type, Map<String, dynamic> params) {
    final sortedParams = params.entries
        .where((e) => e.value != null)
        .map((e) => '${e.key}:${e.value}')
        .toList()
      ..sort();
    return '$_cacheKeyPrefix${type}_${sortedParams.join('_')}';
  }
  
  List<T>? _getCachedList<T>(String key) {
    try {
      final cached = _prefs.getString(key);
      if (cached == null) return null;
      
      final data = Map<String, dynamic>.from({
        'items': cached,
        'timestamp': _prefs.getInt('${key}_timestamp'),
      });
      
      final timestamp = data['timestamp'] as int?;
      if (timestamp == null) return null;
      
      final cachedAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (DateTime.now().difference(cachedAt) > _cacheExpiry) {
        _prefs.remove(key);
        _prefs.remove('${key}_timestamp');
        return null;
      }
      
      // JSON 디코딩은 실제 구현시 필요
      // return (jsonDecode(data['items']) as List)
      //     .map((item) => _deserializeItem<T>(item))
      //     .toList();
      
      return null; // 임시
    } catch (e) {
      Log.w('Failed to get cached list', error: e);
      return null;
    }
  }
  
  T? _getCachedItem<T>(String key) {
    try {
      final cached = _prefs.getString(key);
      if (cached == null) return null;
      
      final timestamp = _prefs.getInt('${key}_timestamp');
      if (timestamp == null) return null;
      
      final cachedAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (DateTime.now().difference(cachedAt) > _cacheExpiry) {
        _prefs.remove(key);
        _prefs.remove('${key}_timestamp');
        return null;
      }
      
      // JSON 디코딩은 실제 구현시 필요
      // return _deserializeItem<T>(jsonDecode(cached));
      
      return null; // 임시
    } catch (e) {
      Log.w('Failed to get cached item', error: e);
      return null;
    }
  }
  
  void _cacheList<T>(String key, List<T> items) {
    try {
      // JSON 인코딩은 실제 구현시 필요
      // final json = jsonEncode(items.map((item) => _serializeItem(item)).toList());
      // _prefs.setString(key, json);
      _prefs.setInt('${key}_timestamp', DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      Log.w('Failed to cache list', error: e);
    }
  }
  
  void _cacheItem<T>(String key, T item) {
    try {
      // JSON 인코딩은 실제 구현시 필요
      // final json = jsonEncode(_serializeItem(item));
      // _prefs.setString(key, json);
      _prefs.setInt('${key}_timestamp', DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      Log.w('Failed to cache item', error: e);
    }
  }
  
  Future<void> _updateBookmarkStatus(List<TourAttraction> attractions) async {
    final bookmarkIds = await getBookmarkIds();
    for (var i = 0; i < attractions.length; i++) {
      if (bookmarkIds.contains(attractions[i].contentId)) {
        attractions[i] = attractions[i].copyWith(isBookmarked: true);
      }
    }
  }
  
  Future<void> _updateBookmarkStatusForFestivals(List<TourFestival> festivals) async {
    final bookmarkIds = await getBookmarkIds();
    for (var i = 0; i < festivals.length; i++) {
      if (bookmarkIds.contains(festivals[i].contentId)) {
        festivals[i] = festivals[i].copyWith(isBookmarked: true);
      }
    }
  }
  
  Future<void> _updateBookmarkStatusForStays(List<TourStay> stays) async {
    final bookmarkIds = await getBookmarkIds();
    for (var i = 0; i < stays.length; i++) {
      if (bookmarkIds.contains(stays[i].contentId)) {
        stays[i] = stays[i].copyWith(isBookmarked: true);
      }
    }
  }
}