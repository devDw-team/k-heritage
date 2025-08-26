import 'package:freezed_annotation/freezed_annotation.dart';

part 'tour_festival.freezed.dart';
part 'tour_festival.g.dart';

/// 행사/축제 정보 엔티티
@freezed
class TourFestival with _$TourFestival {
  const factory TourFestival({
    required String contentId,       // Tour API 콘텐츠 ID
    required String title,            // 행사명
    String? address1,                 // 주소
    String? address2,                 // 상세 주소
    String? areaCode,                 // 지역 코드
    String? sigunguCode,              // 시군구 코드
    double? mapX,                     // 경도
    double? mapY,                     // 위도
    String? firstImage,               // 대표 이미지 원본
    String? firstImage2,              // 대표 이미지 썸네일
    String? tel,                      // 전화번호
    String? eventStartDate,           // 행사 시작일 (YYYYMMDD)
    String? eventEndDate,             // 행사 종료일 (YYYYMMDD)
    String? eventPlace,               // 행사 장소
    String? playTime,                 // 공연 시간
    String? sponsor1,                 // 주최자
    String? sponsor1Tel,              // 주최자 연락처
    String? sponsor2,                 // 주관사
    String? sponsor2Tel,              // 주관사 연락처
    String? useFee,                   // 이용 요금
    String? homepage,                 // 홈페이지
    String? overview,                 // 개요
    String? cat1,                     // 대분류
    String? cat2,                     // 중분류
    String? cat3,                     // 소분류
    String? cpyrhtDivCd,              // 저작권 유형
    String? createdTime,              // 생성일
    String? modifiedTime,             // 수정일
    int? mlevel,                      // 지도 레벨
    
    // 거리 정보 (위치 기반 검색 시)
    double? distance,                 // 거리 (km)
    
    // 북마크 여부
    @Default(false) bool isBookmarked,
    
    // 캐시 정보
    DateTime? cachedAt,
  }) = _TourFestival;

  factory TourFestival.fromJson(Map<String, dynamic> json) =>
      _$TourFestivalFromJson(json);
  
  const TourFestival._();
  
  /// Tour API 응답에서 변환
  factory TourFestival.fromApiResponse(Map<String, dynamic> data) {
    return TourFestival(
      contentId: data['contentid']?.toString() ?? '',
      title: data['title'] ?? '',
      address1: data['addr1'],
      address2: data['addr2'],
      areaCode: data['areacode'],
      sigunguCode: data['sigungucode'],
      mapX: double.tryParse(data['mapx']?.toString() ?? ''),
      mapY: double.tryParse(data['mapy']?.toString() ?? ''),
      firstImage: data['firstimage'],
      firstImage2: data['firstimage2'],
      tel: data['tel'],
      eventStartDate: data['eventstartdate'],
      eventEndDate: data['eventenddate'],
      eventPlace: data['eventplace'],
      playTime: data['playtime'],
      sponsor1: data['sponsor1'],
      sponsor1Tel: data['sponsor1tel'],
      sponsor2: data['sponsor2'],
      sponsor2Tel: data['sponsor2tel'],
      useFee: data['usefee'],
      homepage: data['homepage'],
      overview: _stripHtml(data['overview']),
      cat1: data['cat1'],
      cat2: data['cat2'],
      cat3: data['cat3'],
      cpyrhtDivCd: data['cpyrhtDivCd'],
      createdTime: data['createdtime'],
      modifiedTime: data['modifiedtime'],
      mlevel: int.tryParse(data['mlevel']?.toString() ?? ''),
      distance: data['dist'] != null 
        ? double.tryParse(data['dist'].toString())
        : null,
    );
  }
  
  /// 행사 상태
  FestivalStatus get status {
    if (eventStartDate == null || eventEndDate == null) {
      return FestivalStatus.unknown;
    }
    
    final now = DateTime.now();
    final start = _parseDate(eventStartDate!);
    final end = _parseDate(eventEndDate!);
    
    if (start == null || end == null) {
      return FestivalStatus.unknown;
    }
    
    if (now.isBefore(start)) {
      return FestivalStatus.upcoming;
    } else if (now.isAfter(end)) {
      return FestivalStatus.ended;
    } else {
      return FestivalStatus.ongoing;
    }
  }
  
  /// 행사 기간 표시
  String get periodDisplay {
    if (eventStartDate == null || eventEndDate == null) return '';
    
    final start = _formatDate(eventStartDate!);
    final end = _formatDate(eventEndDate!);
    
    if (start == null || end == null) return '';
    
    return '$start ~ $end';
  }
  
  /// 행사 D-Day 계산
  int? get dDay {
    if (eventStartDate == null) return null;
    
    final now = DateTime.now();
    final start = _parseDate(eventStartDate!);
    
    if (start == null) return null;
    
    return start.difference(now).inDays;
  }
  
  /// D-Day 표시 문자열
  String? get dDayDisplay {
    final days = dDay;
    if (days == null) return null;
    
    if (days > 0) {
      return 'D-$days';
    } else if (days == 0) {
      return 'D-Day';
    } else {
      return '진행중';
    }
  }
  
  /// 거리 표시 문자열
  String? get distanceDisplay {
    if (distance == null) return null;
    if (distance! < 1) {
      return '${(distance! * 1000).toInt()}m';
    } else {
      return '${distance!.toStringAsFixed(1)}km';
    }
  }
  
  /// 주소 전체
  String get fullAddress {
    final parts = <String>[];
    if (address1 != null && address1!.isNotEmpty) parts.add(address1!);
    if (address2 != null && address2!.isNotEmpty) parts.add(address2!);
    return parts.join(' ');
  }
  
  /// 좌표 유효성 체크
  bool get hasValidCoordinates => mapX != null && mapY != null;
  
  /// 이미지 유효성 체크
  bool get hasImage => firstImage != null && firstImage!.isNotEmpty;
  
  /// 날짜 파싱 (YYYYMMDD -> DateTime)
  static DateTime? _parseDate(String dateStr) {
    if (dateStr.length != 8) return null;
    
    try {
      final year = int.parse(dateStr.substring(0, 4));
      final month = int.parse(dateStr.substring(4, 6));
      final day = int.parse(dateStr.substring(6, 8));
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }
  
  /// 날짜 포맷팅 (YYYYMMDD -> YYYY.MM.DD)
  static String? _formatDate(String dateStr) {
    if (dateStr.length != 8) return null;
    return '${dateStr.substring(0, 4)}.${dateStr.substring(4, 6)}.${dateStr.substring(6, 8)}';
  }
  
  /// HTML 태그 제거
  static String? _stripHtml(String? html) {
    if (html == null) return null;
    return html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}

/// 축제 상태
enum FestivalStatus {
  upcoming,   // 예정
  ongoing,    // 진행중
  ended,      // 종료
  unknown,    // 알 수 없음
}

extension FestivalStatusExt on FestivalStatus {
  String get displayName {
    switch (this) {
      case FestivalStatus.upcoming:
        return '예정';
      case FestivalStatus.ongoing:
        return '진행중';
      case FestivalStatus.ended:
        return '종료';
      case FestivalStatus.unknown:
        return '미정';
    }
  }
}