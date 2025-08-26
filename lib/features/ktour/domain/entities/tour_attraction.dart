import 'package:freezed_annotation/freezed_annotation.dart';

part 'tour_attraction.freezed.dart';
part 'tour_attraction.g.dart';

/// 관광지 정보 엔티티
@freezed
class TourAttraction with _$TourAttraction {
  const factory TourAttraction({
    required String contentId,       // Tour API 콘텐츠 ID
    required int contentTypeId,      // 콘텐츠 타입 (12: 관광지, 14: 문화시설 등)
    required String title,            // 관광지명
    String? address1,                 // 주소
    String? address2,                 // 상세 주소
    String? areaCode,                 // 지역 코드
    String? sigunguCode,              // 시군구 코드
    double? mapX,                     // 경도
    double? mapY,                     // 위도
    String? firstImage,               // 대표 이미지 원본
    String? firstImage2,              // 대표 이미지 썸네일
    String? tel,                      // 전화번호
    String? zipCode,                  // 우편번호
    
    // 분류 정보
    String? cat1,                     // 대분류
    String? cat2,                     // 중분류
    String? cat3,                     // 소분류
    
    // 상세 정보
    String? overview,                 // 개요
    String? homepage,                 // 홈페이지
    
    // 메타 정보
    String? createdTime,              // 생성일
    String? modifiedTime,             // 수정일
    int? mlevel,                      // 지도 레벨
    
    // 저작권
    String? cpyrhtDivCd,              // 저작권 유형
    
    // 추가 정보 (detailIntro2에서 가져올 정보들)
    String? openTime,                 // 운영 시간
    String? restDate,                 // 휴무일
    String? useFee,                   // 이용 요금
    String? spendTime,                // 관람 소요시간
    String? parking,                  // 주차 정보
    String? infocenter,               // 문의처
    String? disability,               // 장애인 편의시설
    String? stroller,                 // 유모차 대여
    String? pet,                      // 반려동물 동반
    String? creditcard,               // 신용카드 사용
    
    // 거리 정보 (위치 기반 검색 시)
    double? distance,                 // 거리 (km)
    
    // 북마크 여부
    @Default(false) bool isBookmarked,
    
    // 캐시 정보
    DateTime? cachedAt,
  }) = _TourAttraction;

  factory TourAttraction.fromJson(Map<String, dynamic> json) =>
      _$TourAttractionFromJson(json);
  
  const TourAttraction._();
  
  /// Tour API 응답에서 변환
  factory TourAttraction.fromApiResponse(Map<String, dynamic> data) {
    return TourAttraction(
      contentId: data['contentid']?.toString() ?? '',
      contentTypeId: int.tryParse(data['contenttypeid']?.toString() ?? '0') ?? 0,
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
      zipCode: data['zipcode'],
      cat1: data['cat1'],
      cat2: data['cat2'],
      cat3: data['cat3'],
      overview: _stripHtml(data['overview']),
      homepage: data['homepage'],
      createdTime: data['createdtime'],
      modifiedTime: data['modifiedtime'],
      mlevel: int.tryParse(data['mlevel']?.toString() ?? ''),
      cpyrhtDivCd: data['cpyrhtDivCd'],
      distance: data['dist'] != null 
        ? double.tryParse(data['dist'].toString())?.toDouble()
        : null,
    );
  }
  
  /// 콘텐츠 타입 이름
  String get contentTypeName {
    switch (contentTypeId) {
      case 12: return '관광지';
      case 14: return '문화시설';
      case 15: return '행사/공연/축제';
      case 25: return '여행코스';
      case 28: return '레포츠';
      case 32: return '숙박';
      case 38: return '쇼핑';
      case 39: return '음식점';
      default: return '기타';
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
  
  /// HTML 태그 제거
  static String? _stripHtml(String? html) {
    if (html == null) return null;
    return html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}