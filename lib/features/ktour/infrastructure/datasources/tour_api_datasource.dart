import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/tour_course.dart';
import '../../domain/entities/course_step.dart';

/// Tour API 4.0 DataSource
/// 한국관광공사 Tour API와 통신하는 데이터 소스
class TourAPIDataSource {
  final Dio _dio;
  static const String _baseUrl = 'http://apis.data.go.kr/B551011/KorService2';
  late final String _serviceKey;
  late final bool _useDummyData; // 개발용 더미 데이터 사용 여부

  TourAPIDataSource({Dio? dio, bool? useDummyData}) 
      : _dio = dio ?? Dio() {
    _useDummyData = useDummyData ?? false;
    _serviceKey = dotenv.env['TOUR_API_SERVICE_KEY'] ?? '';
    
    // 서비스 키가 없거나 유효하지 않은 경우 더미 데이터 모드 활성화
    if (_serviceKey.isEmpty || _serviceKey.length < 50) {
      _useDummyData = true;
      Log.w('Tour API service key not found or invalid. Using dummy data mode.');
    } else {
      // 서비스 키 디버깅 정보
      Log.d('Tour API Service Key loaded: ${_serviceKey.length} characters');
      Log.d('Service Key is URL encoded: ${_serviceKey.contains('%')}');
      
      // 서비스 키가 이미 URL 인코딩되어 있는지 확인
      if (_serviceKey.contains('%')) {
        // 이미 인코딩된 경우 디코딩
        try {
          final decoded = Uri.decodeComponent(_serviceKey);
          Log.d('Decoded service key length: ${decoded.length}');
        } catch (e) {
          Log.w('Failed to decode service key: $e');
        }
      }
    }
    
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      listFormat: ListFormat.multi, // 파라미터 인코딩 형식
    );
    
    // 요청/응답 로깅 인터셉터 추가
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        Log.d('Request: ${options.method} ${options.uri}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        Log.d('Response: ${response.statusCode} ${response.requestOptions.uri}');
        final contentType = response.headers.value('content-type');
        Log.d('Content-Type: $contentType');
        if (response.data is String) {
          final preview = (response.data as String).substring(0, 200.clamp(0, (response.data as String).length));
          Log.d('Response preview: $preview');
        }
        handler.next(response);
      },
      onError: (error, handler) {
        Log.e('Request failed: ${error.message}', error: error);
        handler.next(error);
      },
    ));
  }

  /// 공통 쿼리 파라미터 생성
  Map<String, dynamic> _getCommonParams({
    int pageNo = 1,
    int numOfRows = 20,
    bool asJson = true,
  }) {
    // 서비스 키가 이미 URL 인코딩되어 있다면 디코딩
    String serviceKey = _serviceKey;
    if (_serviceKey.contains('%')) {
      try {
        serviceKey = Uri.decodeComponent(_serviceKey);
      } catch (e) {
        // 디코딩 실패 시 원본 사용
        serviceKey = _serviceKey;
      }
    }
    
    return {
      'serviceKey': serviceKey,  // Dio가 자동으로 인코딩 처리
      'MobileOS': 'ETC',
      'MobileApp': 'KHeritageExplorer',
      'pageNo': pageNo.toString(),
      'numOfRows': numOfRows.toString(),
      if (asJson) '_type': 'json',
    };
  }

  /// API 연결 테스트
  Future<bool> testConnection() async {
    try {
      Log.i('Testing Tour API connection...');
      final params = _getCommonParams(numOfRows: 1);
      
      // 가장 간단한 API 호출: 지역 코드 조회
      final response = await _dio.get('/areaCode2', queryParameters: params);
      
      // 응답 확인
      if (response.data != null) {
        Log.i('Tour API connection test successful');
        final items = _parseResponse(response);
        Log.d('Test response items count: ${items.length}');
        return true;
      }
      return false;
    } catch (e) {
      Log.e('Tour API connection test failed', error: e);
      return false;
    }
  }

  /// 지역 코드 조회
  Future<List<Map<String, dynamic>>> getAreaCodes({
    String? areaCode,
  }) async {
    try {
      final params = _getCommonParams(numOfRows: 50);
      if (areaCode != null) params['areaCode'] = areaCode;

      final response = await _dio.get('/areaCode2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to fetch area codes', error: e);
      rethrow;
    }
  }

  /// 서비스 분류 코드 조회
  Future<List<Map<String, dynamic>>> getCategoryCodes({
    String? cat1,
    String? cat2,
    String? cat3,
  }) async {
    try {
      final params = _getCommonParams(numOfRows: 100);
      if (cat1 != null) params['cat1'] = cat1;
      if (cat2 != null) params['cat2'] = cat2;
      if (cat3 != null) params['cat3'] = cat3;

      final response = await _dio.get('/categoryCode2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to fetch category codes', error: e);
      rethrow;
    }
  }

  /// 지역 기반 관광 정보 조회
  Future<List<Map<String, dynamic>>> getAreaBasedList({
    String? areaCode,
    String? sigunguCode,
    String? contentTypeId,
    String? cat1,
    String? cat2,
    String? cat3,
    String? arrange = 'C', // A=제목순, C=수정일순, D=생성일순
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final params = _getCommonParams(pageNo: pageNo, numOfRows: numOfRows);
      params['arrange'] = arrange;
      
      if (areaCode != null) params['areaCode'] = areaCode;
      if (sigunguCode != null) params['sigunguCode'] = sigunguCode;
      
      // contentTypeId 검증
      if (contentTypeId != null && contentTypeId.isNotEmpty && contentTypeId != '0') {
        final typeId = int.tryParse(contentTypeId);
        if (typeId != null && typeId > 0) {
          params['contentTypeId'] = contentTypeId;
        }
      }
      if (cat1 != null) params['cat1'] = cat1;
      if (cat2 != null) params['cat2'] = cat2;
      if (cat3 != null) params['cat3'] = cat3;

      final response = await _dio.get('/areaBasedList2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to fetch area based list', error: e);
      rethrow;
    }
  }

  /// 위치 기반 관광 정보 조회
  Future<List<Map<String, dynamic>>> getLocationBasedList({
    required double mapX,
    required double mapY,
    required int radius, // 미터 단위, 최대 20000
    String? contentTypeId,
    String? arrange = 'E', // E=거리순
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final params = _getCommonParams(pageNo: pageNo, numOfRows: numOfRows);
      params['mapX'] = mapX.toString();
      params['mapY'] = mapY.toString();
      params['radius'] = radius.toString();
      params['arrange'] = arrange;
      
      // contentTypeId 검증
      if (contentTypeId != null && contentTypeId.isNotEmpty && contentTypeId != '0') {
        final typeId = int.tryParse(contentTypeId);
        if (typeId != null && typeId > 0) {
          params['contentTypeId'] = contentTypeId;
        }
      }

      final response = await _dio.get('/locationBasedList2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to fetch location based list', error: e);
      rethrow;
    }
  }

  /// 키워드 검색
  Future<List<Map<String, dynamic>>> searchByKeyword({
    required String keyword,
    String? contentTypeId,
    String? areaCode,
    String? sigunguCode,
    String? arrange = 'C',
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final params = _getCommonParams(pageNo: pageNo, numOfRows: numOfRows);
      params['keyword'] = keyword;
      params['arrange'] = arrange;
      
      // contentTypeId 검증
      if (contentTypeId != null && contentTypeId.isNotEmpty && contentTypeId != '0') {
        final typeId = int.tryParse(contentTypeId);
        if (typeId != null && typeId > 0) {
          params['contentTypeId'] = contentTypeId;
        }
      }
      if (areaCode != null) params['areaCode'] = areaCode;
      if (sigunguCode != null) params['sigunguCode'] = sigunguCode;

      final response = await _dio.get('/searchKeyword2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to search by keyword', error: e);
      rethrow;
    }
  }

  /// 행사/축제 정보 조회
  Future<List<Map<String, dynamic>>> searchFestival({
    required String eventStartDate, // YYYYMMDD
    String? eventEndDate, // YYYYMMDD
    String? areaCode,
    String? sigunguCode,
    String? arrange = 'O', // O=제목순, P=생성일순, Q=수정일순, R=시작일순
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final params = _getCommonParams(pageNo: pageNo, numOfRows: numOfRows);
      params['eventStartDate'] = eventStartDate;
      if (eventEndDate != null) params['eventEndDate'] = eventEndDate;
      params['arrange'] = arrange;
      
      if (areaCode != null) params['areaCode'] = areaCode;
      if (sigunguCode != null) params['sigunguCode'] = sigunguCode;

      final response = await _dio.get('/searchFestival2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to search festivals', error: e);
      rethrow;
    }
  }

  /// 숙박 정보 조회
  Future<List<Map<String, dynamic>>> searchStay({
    String? areaCode,
    String? sigunguCode,
    String? hanOk, // 한옥 여부 (Y/N)
    String? goodStay, // 굿스테이 여부 (Y/N)
    String? arrange = 'C',
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      final params = _getCommonParams(pageNo: pageNo, numOfRows: numOfRows);
      params['arrange'] = arrange;
      
      if (areaCode != null) params['areaCode'] = areaCode;
      if (sigunguCode != null) params['sigunguCode'] = sigunguCode;
      if (hanOk != null) params['hanOk'] = hanOk;
      if (goodStay != null) params['goodStay'] = goodStay;

      final response = await _dio.get('/searchStay2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to search stays', error: e);
      rethrow;
    }
  }

  /// 맛집 정보 조회
  Future<List<Map<String, dynamic>>> searchRestaurants({
    String? areaCode,
    String? sigunguCode,
    String? keyword,
    double? mapX,
    double? mapY,
    int? radius,
    String? cat3, // 세부 분류 (한식/중식/일식 등)
    String? arrange = 'C',
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      // 위치 기반 검색
      if (mapX != null && mapY != null) {
        return await getLocationBasedList(
          mapX: mapX,
          mapY: mapY,
          radius: radius ?? 5000,
          contentTypeId: '39', // 음식점
          arrange: 'E', // 거리순
          pageNo: pageNo,
          numOfRows: numOfRows,
        );
      }
      
      // 지역 기반 검색
      return await getAreaBasedList(
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        contentTypeId: '39', // 음식점
        cat3: cat3,
        arrange: arrange,
        pageNo: pageNo,
        numOfRows: numOfRows,
      );
    } catch (e) {
      Log.e('Failed to search restaurants', error: e);
      rethrow;
    }
  }

  /// 쇼핑 정보 조회
  Future<List<Map<String, dynamic>>> searchShopping({
    String? areaCode,
    String? sigunguCode,
    String? keyword,
    double? mapX,
    double? mapY,
    int? radius,
    String? cat3, // 세부 분류 (백화점/아울렛/전통시장 등)
    String? arrange = 'C',
    int pageNo = 1,
    int numOfRows = 20,
  }) async {
    try {
      // 위치 기반 검색
      if (mapX != null && mapY != null) {
        return await getLocationBasedList(
          mapX: mapX,
          mapY: mapY,
          radius: radius ?? 5000,
          contentTypeId: '38', // 쇼핑
          arrange: 'E', // 거리순
          pageNo: pageNo,
          numOfRows: numOfRows,
        );
      }
      
      // 지역 기반 검색
      return await getAreaBasedList(
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        contentTypeId: '38', // 쇼핑
        cat3: cat3,
        arrange: arrange,
        pageNo: pageNo,
        numOfRows: numOfRows,
      );
    } catch (e) {
      Log.e('Failed to search shopping', error: e);
      rethrow;
    }
  }

  /// 공통 정보 조회 (상세 1)
  Future<Map<String, dynamic>> getDetailCommon({
    required String contentId,
  }) async {
    try {
      // 디버그 로그
      Log.d('=== Detail Common Request START ===');
      Log.d('Input contentId: "$contentId"');
      
      // 기본 파라미터 설정 - 최소 필수 파라미터만 사용
      final params = _getCommonParams();
      params['contentId'] = contentId;
      
      // detailCommon2 API 사용
      // 필수 파라미터만 사용: serviceKey, MobileOS, MobileApp, _type, contentId
      String endpoint = '/detailCommon2';
      
      // 최종 파라미터 확인 (서비스 키 제외)
      Log.d('Final endpoint: $endpoint');
      Log.d('Final params (no key): ${params.entries.where((e) => e.key != 'serviceKey').map((e) => '${e.key}=${e.value}').join('&')}');
      
      // API 호출
      final response = await _dio.get(endpoint, queryParameters: params);
      final items = _parseResponse(response);
      
      Log.d('Response items count: ${items.length}');
      if (items.isNotEmpty) {
        final item = items.first;
        Log.d('First item has contentTypeId: ${item['contenttypeid']}');
      }
      
      return items.isNotEmpty ? items.first : {};
    } catch (e) {
      Log.e('Failed to fetch detail common for contentId: $contentId', error: e);
      if (e is TourAPIException) {
        Log.e('TourAPIException - Code: ${e.code}, Message: ${e.message}');
      }
      rethrow;
    }
  }

  /// 소개 정보 조회 (상세 2)
  Future<Map<String, dynamic>> getDetailIntro({
    required String contentId,
    required String contentTypeId,
  }) async {
    try {
      // contentTypeId 검증
      if (contentTypeId.isEmpty || contentTypeId == '0') {
        Log.w('getDetailIntro called with invalid contentTypeId: "$contentTypeId"');
        return {};
      }
      
      // 숫자로 변환해서 유효한지 확인
      final typeId = int.tryParse(contentTypeId);
      if (typeId == null || typeId <= 0) {
        Log.w('getDetailIntro - Invalid contentTypeId value: "$contentTypeId"');
        return {};
      }
      
      final params = _getCommonParams();
      params['contentId'] = contentId;
      params['contentTypeId'] = contentTypeId;

      final response = await _dio.get('/detailIntro2', queryParameters: params);
      final items = _parseResponse(response);
      return items.isNotEmpty ? items.first : {};
    } catch (e) {
      Log.e('Failed to fetch detail intro', error: e);
      rethrow;
    }
  }

  /// 반복 정보 조회 (상세 3)
  Future<List<Map<String, dynamic>>> getDetailInfo({
    required String contentId,
    required String contentTypeId,
  }) async {
    try {
      // contentTypeId 검증
      if (contentTypeId.isEmpty || contentTypeId == '0') {
        Log.w('getDetailInfo called with invalid contentTypeId: "$contentTypeId"');
        return [];
      }
      
      // 숫자로 변환해서 유효한지 확인
      final typeId = int.tryParse(contentTypeId);
      if (typeId == null || typeId <= 0) {
        Log.w('getDetailInfo - Invalid contentTypeId value: "$contentTypeId"');
        return [];
      }
      
      final params = _getCommonParams(numOfRows: 100);
      params['contentId'] = contentId;
      params['contentTypeId'] = contentTypeId;

      final response = await _dio.get('/detailInfo2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to fetch detail info', error: e);
      rethrow;
    }
  }

  /// 이미지 정보 조회 (상세 4)
  Future<List<Map<String, dynamic>>> getDetailImages({
    required String contentId,
    bool imageYN = true,
    bool subImageYN = true,
  }) async {
    try {
      final params = _getCommonParams(numOfRows: 100);
      params['contentId'] = contentId;
      params['imageYN'] = imageYN ? 'Y' : 'N';
      params['subImageYN'] = subImageYN ? 'Y' : 'N';

      final response = await _dio.get('/detailImage2', queryParameters: params);
      return _parseResponse(response);
    } catch (e) {
      Log.e('Failed to fetch detail images', error: e);
      rethrow;
    }
  }

  /// 반려동물 동반 여행 정보 조회
  Future<Map<String, dynamic>> getDetailPetTour({
    required String contentId,
  }) async {
    try {
      final params = _getCommonParams();
      params['contentId'] = contentId;

      final response = await _dio.get('/detailPetTour2', queryParameters: params);
      final items = _parseResponse(response);
      return items.isNotEmpty ? items.first : {};
    } catch (e) {
      Log.e('Failed to fetch pet tour info', error: e);
      rethrow;
    }
  }

  /// 여행코스 목록 조회
  Future<List<TourCourse>> getTourCourses({
    String? areaCode,
    String? sigunguCode,
    int pageNo = 1,
    int numOfRows = 20,
    String arrange = 'P', // P: 인기순
  }) async {
    if (_useDummyData) {
      return _getDummyTourCourses();
    }

    try {
      final params = _getCommonParams(pageNo: pageNo, numOfRows: numOfRows);
      params['contentTypeId'] = TourContentType.tourCourse.toString();
      params['arrange'] = arrange;

      if (areaCode != null && areaCode.isNotEmpty) {
        params['areaCode'] = areaCode;
      }
      if (sigunguCode != null && sigunguCode.isNotEmpty) {
        params['sigunguCode'] = sigunguCode;
      }

      final response = await _dio.get('/areaBasedList2', queryParameters: params);
      final items = _parseResponse(response);

      return items.map((item) => _parseTourCourse(item)).toList();
    } catch (e) {
      Log.e('Failed to get tour courses', error: e);
      if (e is TourAPIException) rethrow;
      throw TourAPIException(
        code: 'FETCH_ERROR',
        message: 'Failed to fetch tour courses: $e',
      );
    }
  }

  /// 여행코스 상세 정보 조회
  Future<TourCourse> getCourseDetail(String contentId) async {
    if (_useDummyData) {
      return _getDummyCourseDetail(contentId);
    }

    try {
      // 기본 정보 조회
      // detailCommon2 API - 최소 필수 파라미터만 사용
      final commonParams = _getCommonParams();
      commonParams['contentId'] = contentId;
      // overviewYN 파라미터 제거 - API가 지원하지 않음

      final commonResponse = await _dio.get('/detailCommon2', queryParameters: commonParams);
      final commonItems = _parseResponse(commonResponse);
      if (commonItems.isEmpty) {
        throw TourAPIException(
          code: 'NOT_FOUND',
          message: 'Course not found: $contentId',
        );
      }

      final course = _parseTourCourse(commonItems.first);

      // 코스 단계 정보 조회
      // detailInfo2 API는 contentTypeId가 필수
      final detailParams = _getCommonParams();
      detailParams['contentId'] = contentId;
      detailParams['contentTypeId'] = '25';  // 여행코스 타입 ID (25)

      final detailResponse = await _dio.get('/detailInfo2', queryParameters: detailParams);
      final detailItems = _parseResponse(detailResponse);
      
      final steps = parseCourseSteps(detailItems);
      final totalDistance = calculateCourseDistance(steps);
      final totalDuration = calculateCourseDuration(steps);

      return course.copyWith(
        steps: steps,
        totalDistance: totalDistance,
        totalDuration: totalDuration,
      );
    } catch (e) {
      Log.e('Failed to get course detail', error: e);
      if (e is TourAPIException) rethrow;
      throw TourAPIException(
        code: 'FETCH_ERROR',
        message: 'Failed to fetch course detail: $e',
      );
    }
  }

  /// 코스 단계별 정보 파싱
  List<CourseStep> parseCourseSteps(List<Map<String, dynamic>> items) {
    final steps = <CourseStep>[];
    
    for (final item in items) {
      final infoname = item['infoname'] ?? '';
      
      // 코스 단계 정보만 파싱 (subcontentid가 있는 항목)
      if (infoname.contains('코스') && item['subcontentid'] != null) {
        steps.add(CourseStep(
          subcontentid: item['subcontentid'] ?? '',
          subname: item['subname'] ?? '',
          subdetailimg: item['subdetailimg'],
          subdetailoverview: item['subdetailoverview'],
          subnum: int.tryParse(item['subnum']?.toString() ?? ''),
        ));
      }
    }

    // subnum으로 정렬
    steps.sort((a, b) => (a.subnum ?? 0).compareTo(b.subnum ?? 0));
    
    return steps;
  }

  /// 코스 총 거리 계산
  double calculateCourseDistance(List<CourseStep> steps) {
    double totalDistance = 0;
    for (final step in steps) {
      totalDistance += step.distance ?? 0;
    }
    return totalDistance;
  }

  /// 코스 총 소요시간 계산
  int calculateCourseDuration(List<CourseStep> steps) {
    int totalDuration = 0;
    for (final step in steps) {
      totalDuration += step.duration ?? 0;
    }
    return totalDuration;
  }

  /// TourCourse 파싱
  TourCourse _parseTourCourse(Map<String, dynamic> item) {
    return TourCourse(
      contentid: item['contentid'] ?? '',
      contenttypeid: item['contenttypeid'] ?? TourContentType.tourCourse.toString(),
      title: item['title'] ?? '',
      firstimage: item['firstimage'],
      firstimage2: item['firstimage2'],
      addr1: item['addr1'],
      addr2: item['addr2'],
      areacode: item['areacode'],
      sigungucode: item['sigungucode'],
      cat1: item['cat1'],
      cat2: item['cat2'],
      cat3: item['cat3'],
      mapx: double.tryParse(item['mapx']?.toString() ?? ''),
      mapy: double.tryParse(item['mapy']?.toString() ?? ''),
      overview: item['overview'],
      tel: item['tel'],
      zipcode: item['zipcode'],
      createdtime: item['createdtime'] != null 
        ? DateTime.tryParse(item['createdtime'].toString())
        : null,
      modifiedtime: item['modifiedtime'] != null
        ? DateTime.tryParse(item['modifiedtime'].toString())
        : null,
      readcount: int.tryParse(item['readcount']?.toString() ?? ''),
    );
  }

  /// 더미 여행코스 목록
  List<TourCourse> _getDummyTourCourses() {
    return [
      const TourCourse(
        contentid: '2549463',
        contenttypeid: '25',
        title: '서울 고궁 나들이 코스',
        firstimage: 'https://tong.visitkorea.or.kr/cms/resource/21/2549421_image2_1.jpg',
        addr1: '서울특별시 종로구',
        overview: '경복궁, 창덕궁, 창경궁을 둘러보는 서울의 대표 고궁 투어 코스입니다.',
        totalDistance: 8.5,
        totalDuration: 360,
        theme: '역사문화',
        difficulty: '쉬움',
      ),
      const TourCourse(
        contentid: '2549464',
        contenttypeid: '25',
        title: '북촌 한옥마을 문화 탐방',
        firstimage: 'https://tong.visitkorea.or.kr/cms/resource/22/2549422_image2_1.jpg',
        addr1: '서울특별시 종로구 북촌로',
        overview: '전통 한옥과 현대 문화가 어우러진 북촌 일대를 탐방하는 코스입니다.',
        totalDistance: 3.2,
        totalDuration: 180,
        theme: '문화예술',
        difficulty: '보통',
      ),
    ];
  }

  /// 더미 코스 상세 정보
  TourCourse _getDummyCourseDetail(String contentId) {
    return TourCourse(
      contentid: contentId,
      contenttypeid: '25',
      title: '서울 고궁 나들이 코스',
      firstimage: 'https://tong.visitkorea.or.kr/cms/resource/21/2549421_image2_1.jpg',
      addr1: '서울특별시 종로구',
      overview: '경복궁, 창덕궁, 창경궁을 둘러보는 서울의 대표 고궁 투어 코스입니다.',
      totalDistance: 8.5,
      totalDuration: 360,
      theme: '역사문화',
      difficulty: '쉬움',
      steps: [
        const CourseStep(
          subcontentid: '1',
          subname: '경복궁',
          subdetailimg: 'https://tong.visitkorea.or.kr/cms/resource/21/2549421_image2_1.jpg',
          subdetailoverview: '조선왕조의 법궁으로 600년 역사를 간직한 궁궐',
          subnum: 1,
          distance: 0,
          duration: 120,
        ),
        const CourseStep(
          subcontentid: '2',
          subname: '창덕궁',
          subdetailimg: 'https://tong.visitkorea.or.kr/cms/resource/22/2549422_image2_1.jpg',
          subdetailoverview: '유네스코 세계문화유산으로 지정된 아름다운 궁궐',
          subnum: 2,
          distance: 2.5,
          duration: 90,
        ),
        const CourseStep(
          subcontentid: '3',
          subname: '창경궁',
          subdetailimg: 'https://tong.visitkorea.or.kr/cms/resource/23/2549423_image2_1.jpg',
          subdetailoverview: '동쪽 궁궐로 불리는 조선시대 별궁',
          subnum: 3,
          distance: 1.8,
          duration: 90,
        ),
      ],
    );
  }

  /// 응답 파싱
  List<Map<String, dynamic>> _parseResponse(Response response) {
    try {
      dynamic data = response.data;
      
      // XML 응답인 경우 에러 처리 (API가 JSON을 반환하지 않는 경우)
      if (data is String && data.trim().startsWith('<')) {
        // XML 응답을 간단히 파싱하여 에러 확인
        if (data.contains('<resultCode>') && data.contains('<resultMsg>')) {
          final codeMatch = RegExp(r'<resultCode>(\d+)</resultCode>').firstMatch(data);
          final msgMatch = RegExp(r'<resultMsg>([^<]+)</resultMsg>').firstMatch(data);
          
          final code = codeMatch?.group(1) ?? 'UNKNOWN';
          final msg = msgMatch?.group(1) ?? 'Unknown error';
          
          Log.e('Tour API XML Error - Code: $code, Message: $msg');
          
          if (code != '0000' && code != '00') {
            throw TourAPIException(code: code, message: msg);
          }
        }
        
        // JSON이 아닌 XML 응답은 에러로 처리
        Log.e('Tour API returned XML instead of JSON. Check _type parameter.');
        Log.d('XML Response preview: ${data.substring(0, 500.clamp(0, data.length))}');
        throw TourAPIException(code: 'FORMAT_ERROR', message: 'API returned XML instead of JSON');
      }
      
      // 문자열인 경우 JSON 파싱
      if (data is String) {
        data = json.decode(data);
      }
      
      // response 구조 확인
      if (data['response'] == null) {
        Log.e('Invalid JSON structure - no response field');
        Log.d('JSON data: ${json.encode(data)}');
        throw TourAPIException(code: 'INVALID_RESPONSE', message: 'Invalid API response structure');
      }
      
      // 오류 체크
      final resultCode = data['response']?['header']?['resultCode'];
      if (resultCode != '0000' && resultCode != '00') {
        final errorMsg = data['response']?['header']?['resultMsg'] ?? 'Unknown error';
        Log.e('Tour API Error - Code: $resultCode, Message: $errorMsg');
        throw TourAPIException(
          code: resultCode ?? 'UNKNOWN',
          message: errorMsg,
        );
      }

      // 데이터 추출
      final items = data['response']?['body']?['items']?['item'];
      if (items == null) return [];
      
      // 단일 항목인 경우 리스트로 변환
      if (items is Map) return [Map<String, dynamic>.from(items)];
      
      // 리스트인 경우
      return List<Map<String, dynamic>>.from(
        items.map((item) => Map<String, dynamic>.from(item))
      );
    } catch (e) {
      if (e is TourAPIException) rethrow;
      Log.e('Failed to parse response', error: e);
      Log.d('Response data type: ${response.data.runtimeType}');
      if (response.data is String) {
        final preview = (response.data as String).substring(0, 500.clamp(0, (response.data as String).length));
        Log.d('Response preview: $preview');
        // Check if this is an authentication error in XML format
        if ((response.data as String).contains('SERVICE_KEY_IS_NOT_REGISTERED_ERROR')) {
          throw TourAPIException(code: 'AUTH_ERROR', message: 'Service key is not registered');
        }
      }
      throw TourAPIException(code: 'PARSE_ERROR', message: 'Failed to parse API response: ${e.toString()}');
    }
  }
}

/// Tour API 예외 클래스
class TourAPIException implements Exception {
  final String code;
  final String message;

  TourAPIException({required this.code, required this.message});

  @override
  String toString() => 'TourAPIException($code): $message';
  
  /// 사용자 친화적 메시지 반환
  String get userMessage {
    switch (code) {
      case '03':
        return '관광 정보를 찾을 수 없습니다';
      case '22':
        return '요청 제한을 초과했습니다. 잠시 후 다시 시도해주세요';
      case '30':
        return '서비스 키가 등록되지 않았습니다';
      case '31':
        return '서비스 키가 만료되었습니다';
      case '32':
        return '등록되지 않은 IP입니다';
      default:
        return '관광 정보를 불러올 수 없습니다';
    }
  }
}

/// 콘텐츠 타입 상수
class TourContentType {
  static const int attraction = 12;      // 관광지
  static const int culturalFacility = 14; // 문화시설
  static const int festival = 15;         // 행사/공연/축제
  static const int tourCourse = 25;       // 여행코스
  static const int leisure = 28;          // 레포츠
  static const int accommodation = 32;    // 숙박
  static const int shopping = 38;         // 쇼핑
  static const int restaurant = 39;       // 음식점
  
  static String getName(int code) {
    switch (code) {
      case attraction: return '관광지';
      case culturalFacility: return '문화시설';
      case festival: return '행사/공연/축제';
      case tourCourse: return '여행코스';
      case leisure: return '레포츠';
      case accommodation: return '숙박';
      case shopping: return '쇼핑';
      case restaurant: return '음식점';
      default: return '기타';
    }
  }
}

/// 지역 코드 매핑 (문화재청 → Tour API)
class AreaCodeMapper {
  static const Map<String, String> heritageToTour = {
    '11': '1',   // 서울
    '21': '6',   // 부산
    '22': '4',   // 대구
    '23': '2',   // 인천
    '24': '5',   // 광주
    '25': '3',   // 대전
    '26': '7',   // 울산
    '31': '31',  // 경기
    '32': '32',  // 강원
    '33': '33',  // 충북
    '34': '34',  // 충남
    '35': '37',  // 전북
    '36': '38',  // 전남
    '37': '35',  // 경북
    '38': '36',  // 경남
    '39': '39',  // 제주
    '45': '8',   // 세종
  };
  
  static String? convertToTourAPI(String heritageCode) {
    return heritageToTour[heritageCode];
  }
}

/// Tour API DataSource 프로바이더
final tourAPIDataSourceProvider = Provider<TourAPIDataSource>((ref) {
  final dio = Dio();
  return TourAPIDataSource(dio: dio);
});