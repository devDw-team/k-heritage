import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/logger.dart';
import '../../common/services/location_service.dart';
import '../domain/entities/tour_stay.dart';
import '../domain/repositories/ktour_repository.dart';
import '../infrastructure/datasources/tour_api_datasource.dart';
import '../infrastructure/repositories/ktour_repository_impl.dart';
import 'ktour_state.dart';

/// K-TOUR Repository Provider
final ktourRepositoryProvider = Provider<KTourRepository>((ref) {
  return KTourRepositoryImpl(
    tourAPI: TourAPIDataSource(),
    prefs: ref.watch(sharedPreferencesProvider).requireValue,
  );
});

/// SharedPreferences Provider
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// K-TOUR Controller Provider
final ktourControllerProvider = StateNotifierProvider<KTourController, KTourState>((ref) {
  // SharedPreferences가 로드될 때까지 기다림
  final prefsAsync = ref.watch(sharedPreferencesProvider);
  
  // SharedPreferences가 아직 로드되지 않았으면 기본 상태 반환
  if (!prefsAsync.hasValue) {
    return KTourController.loading();
  }
  
  return KTourController(
    repository: ref.watch(ktourRepositoryProvider),
    locationService: ref.watch(locationServiceProvider),
  );
});

/// K-TOUR Controller
class KTourController extends StateNotifier<KTourState> {
  final KTourRepository? _repository;
  final LocationService? _locationService;
  
  KTourController({
    required KTourRepository repository,
    required LocationService locationService,
  })  : _repository = repository,
        _locationService = locationService,
        super(const KTourState()) {
    _initialize();
  }
  
  // Loading 상태를 위한 팩토리 생성자
  KTourController.loading()
      : _repository = null,
        _locationService = null,
        super(const KTourState(isInitializing: true));
  
  /// 초기화
  Future<void> _initialize() async {
    if (_repository == null || _locationService == null) return;
    
    state = state.copyWith(isInitializing: true);
    
    try {
      // API 연결 테스트 (디버깅용)
      Log.i('Testing Tour API connection...');
      final tourAPI = TourAPIDataSource();
      final isConnected = await tourAPI.testConnection();
      Log.i('Tour API connection test result: $isConnected');
      
      // 위치 정보 가져오기
      await _updateCurrentLocation();
      
      // 초기 데이터 로드 (병렬 처리)
      await Future.wait([
        loadPopularAttractions(),
        loadOngoingFestivals(),
        if (state.hasLocation) loadNearbyAttractions(),
      ]);
    } catch (e) {
      Log.e('Failed to initialize K-TOUR', error: e);
    } finally {
      state = state.copyWith(
        isInitializing: false,
        lastUpdated: DateTime.now(),
      );
    }
  }
  
  /// 새로고침
  Future<void> refresh() async {
    if (_repository == null || _locationService == null) return;
    
    await _updateCurrentLocation();
    await Future.wait([
      loadPopularAttractions(),
      loadOngoingFestivals(),
      if (state.hasLocation) loadNearbyAttractions(),
    ]);
    state = state.copyWith(lastUpdated: DateTime.now());
  }
  
  /// 현재 위치 업데이트
  Future<void> _updateCurrentLocation() async {
    if (_locationService == null) return;
    
    try {
      final position = await _locationService!.getCurrentPosition();
      if (position != null) {
        state = state.copyWith(
          currentLatitude: position.latitude,
          currentLongitude: position.longitude,
        );
      }
    } catch (e) {
      Log.w('Failed to get current location', error: e);
    }
  }
  
  /// 인기 관광지 로드
  Future<void> loadPopularAttractions() async {
    if (_repository == null) return;
    
    state = state.copyWith(
      isLoadingPopular: true,
      popularError: null,
    );
    
    try {
      // 서울 지역 관광지 (임시로 인기 관광지로 사용)
      final attractions = await _repository!.getAttractionsByArea(
        areaCode: '1', // 서울
        contentTypeId: TourContentType.attraction,
        numOfRows: 10,
      );
      
      state = state.copyWith(
        popularAttractions: attractions,
        isLoadingPopular: false,
      );
    } catch (e) {
      Log.e('Failed to load popular attractions', error: e);
      state = state.copyWith(
        isLoadingPopular: false,
        popularError: '인기 관광지를 불러올 수 없습니다',
      );
    }
  }
  
  /// 진행중인 축제 로드
  Future<void> loadOngoingFestivals() async {
    if (_repository == null) return;
    
    state = state.copyWith(
      isLoadingFestivals: true,
      festivalsError: null,
    );
    
    try {
      final festivals = await _repository!.getOngoingFestivals(
        numOfRows: 10,
      );
      
      state = state.copyWith(
        ongoingFestivals: festivals,
        isLoadingFestivals: false,
      );
    } catch (e) {
      Log.e('Failed to load ongoing festivals', error: e);
      state = state.copyWith(
        isLoadingFestivals: false,
        festivalsError: '진행중인 축제를 불러올 수 없습니다',
      );
    }
  }
  
  /// 내 주변 관광지 로드
  Future<void> loadNearbyAttractions() async {
    if (_repository == null || !state.hasLocation) return;
    
    state = state.copyWith(
      isLoadingNearby: true,
      nearbyError: null,
    );
    
    try {
      final attractions = await _repository!.getNearbyAttractions(
        latitude: state.currentLatitude!,
        longitude: state.currentLongitude!,
        radius: 5000, // 5km
        numOfRows: 20,
      );
      
      state = state.copyWith(
        nearbyAttractions: attractions,
        isLoadingNearby: false,
      );
    } catch (e) {
      Log.e('Failed to load nearby attractions', error: e);
      state = state.copyWith(
        isLoadingNearby: false,
        nearbyError: '주변 관광지를 불러올 수 없습니다',
      );
    }
  }
  
  /// 추천 숙박 로드
  Future<void> loadRecommendedStays() async {
    if (_repository == null) return;
    
    state = state.copyWith(
      isLoadingStays: true,
      staysError: null,
    );
    
    try {
      List<TourStay> stays;
      
      if (state.hasLocation) {
        // 위치 기반 추천
        stays = await _repository!.getNearbyStays(
          latitude: state.currentLatitude!,
          longitude: state.currentLongitude!,
          radius: 10000, // 10km
          goodStay: true, // 굿스테이만
          numOfRows: 10,
        );
      } else {
        // 지역 기반 추천 (서울)
        stays = await _repository!.getStays(
          areaCode: '1',
          goodStay: true,
          numOfRows: 10,
        );
      }
      
      state = state.copyWith(
        recommendedStays: stays,
        isLoadingStays: false,
      );
    } catch (e) {
      Log.e('Failed to load recommended stays', error: e);
      state = state.copyWith(
        isLoadingStays: false,
        staysError: '추천 숙박을 불러올 수 없습니다',
      );
    }
  }
  
  /// 지역 선택
  void selectArea(String? areaCode, String? sigunguCode) {
    state = state.copyWith(
      selectedAreaCode: areaCode,
      selectedSigunguCode: sigunguCode,
    );
  }
  
  /// 검색 키워드 설정
  void setSearchKeyword(String? keyword) {
    state = state.copyWith(searchKeyword: keyword);
  }
  
  /// 북마크 토글
  Future<void> toggleBookmark(String contentId, String contentType) async {
    if (_repository == null) return;
    
    try {
      final bookmarkIds = await _repository!.getBookmarkIds();
      
      if (bookmarkIds.contains(contentId)) {
        await _repository!.removeBookmark(contentId: contentId);
      } else {
        await _repository!.addBookmark(
          contentId: contentId,
          contentType: contentType,
        );
      }
      
      // 상태 업데이트
      await refresh();
    } catch (e) {
      Log.e('Failed to toggle bookmark', error: e);
    }
  }
}