import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../core/utils/logger.dart';

/// Tour API 4.0 DataSource
/// 한국관광공사 Tour API와 통신하는 데이터 소스
class TourAPIDataSource {
  final Dio _dio;
  static const String _baseUrl = 'http://apis.data.go.kr/B551011/KorService2';
  late final String _serviceKey;
  late final bool _useDummyData; // 개발용 더미 데이터 사용 여부

  TourAPIDataSource({Dio? dio, bool? useDummyData}) 
      : _dio = dio ?? Dio(),
        _useDummyData = useDummyData ?? false {
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
      if (contentTypeId != null) params['contentTypeId'] = contentTypeId;
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
      
      if (contentTypeId != null) params['contentTypeId'] = contentTypeId;

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
      
      if (contentTypeId != null) params['contentTypeId'] = contentTypeId;
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

  /// 공통 정보 조회 (상세 1)
  Future<Map<String, dynamic>> getDetailCommon({
    required String contentId,
    String? contentTypeId,
    bool defaultYN = true,
    bool firstImageYN = true,
    bool areacodeYN = true,
    bool catcodeYN = true,
    bool addrinfoYN = true,
    bool mapinfoYN = true,
    bool overviewYN = true,
  }) async {
    try {
      final params = _getCommonParams();
      params['contentId'] = contentId;
      if (contentTypeId != null) params['contentTypeId'] = contentTypeId;
      
      params['defaultYN'] = defaultYN ? 'Y' : 'N';
      params['firstImageYN'] = firstImageYN ? 'Y' : 'N';
      params['areacodeYN'] = areacodeYN ? 'Y' : 'N';
      params['catcodeYN'] = catcodeYN ? 'Y' : 'N';
      params['addrinfoYN'] = addrinfoYN ? 'Y' : 'N';
      params['mapinfoYN'] = mapinfoYN ? 'Y' : 'N';
      params['overviewYN'] = overviewYN ? 'Y' : 'N';

      final response = await _dio.get('/detailCommon2', queryParameters: params);
      final items = _parseResponse(response);
      return items.isNotEmpty ? items.first : {};
    } catch (e) {
      Log.e('Failed to fetch detail common', error: e);
      rethrow;
    }
  }

  /// 소개 정보 조회 (상세 2)
  Future<Map<String, dynamic>> getDetailIntro({
    required String contentId,
    required String contentTypeId,
  }) async {
    try {
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
          
          if (code != '0000' && code != '00') {
            throw TourAPIException(code: code, message: msg);
          }
        }
        
        // JSON이 아닌 XML 응답은 빈 리스트 반환
        Log.w('Tour API returned XML instead of JSON. Check service key encoding.');
        return [];
      }
      
      // 문자열인 경우 JSON 파싱
      if (data is String) {
        data = json.decode(data);
      }
      
      // 오류 체크
      if (data['response']?['header']?['resultCode'] != '0000' &&
          data['response']?['header']?['resultCode'] != '00') {
        final errorMsg = data['response']?['header']?['resultMsg'] ?? 'Unknown error';
        throw TourAPIException(
          code: data['response']?['header']?['resultCode'] ?? 'UNKNOWN',
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
        Log.d('Response preview: ${(response.data as String).substring(0, 200.clamp(0, (response.data as String).length))}');
      }
      throw TourAPIException(code: 'PARSE_ERROR', message: 'Failed to parse API response');
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