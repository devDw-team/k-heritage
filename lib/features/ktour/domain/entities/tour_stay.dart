import 'package:freezed_annotation/freezed_annotation.dart';

part 'tour_stay.freezed.dart';
part 'tour_stay.g.dart';

/// 숙박 정보 엔티티
@freezed
class TourStay with _$TourStay {
  const factory TourStay({
    required String contentId,       // Tour API 콘텐츠 ID
    required String title,            // 숙박시설명
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
    String? homepage,                 // 홈페이지
    String? overview,                 // 개요
    
    // 숙박 상세 정보
    String? checkInTime,              // 체크인 시간
    String? checkOutTime,             // 체크아웃 시간
    String? roomType,                 // 객실 유형
    int? roomCount,                   // 객실 수
    String? parking,                  // 주차 정보
    String? reservationUrl,           // 예약 URL
    String? reservationTel,           // 예약 전화번호
    String? accomCount,               // 수용 가능 인원
    String? foodPlace,                // 식음료장
    String? pickup,                   // 픽업 서비스
    String? cooking,                  // 객실 내 취사
    String? barbecue,                 // 바비큐
    String? fitness,                  // 휘트니스센터
    String? sauna,                    // 사우나
    String? publicBath,               // 공용샤워실
    String? publicPc,                 // 공용PC실
    String? seminar,                  // 세미나실
    String? sports,                   // 스포츠시설
    String? refundPolicy,             // 환불 규정
    
    // 특별 속성
    bool? hanOk,                      // 한옥 여부
    bool? goodStay,                   // 굿스테이 여부
    
    // 분류 정보
    String? cat1,                     // 대분류
    String? cat2,                     // 중분류
    String? cat3,                     // 소분류
    
    // 메타 정보
    String? createdTime,              // 생성일
    String? modifiedTime,             // 수정일
    String? cpyrhtDivCd,              // 저작권 유형
    int? mlevel,                      // 지도 레벨
    
    // 거리 정보 (위치 기반 검색 시)
    double? distance,                 // 거리 (km)
    
    // 북마크 여부
    @Default(false) bool isBookmarked,
    
    // 캐시 정보
    DateTime? cachedAt,
  }) = _TourStay;

  factory TourStay.fromJson(Map<String, dynamic> json) =>
      _$TourStayFromJson(json);
  
  const TourStay._();
  
  /// Tour API 응답에서 변환
  factory TourStay.fromApiResponse(Map<String, dynamic> data) {
    return TourStay(
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
      zipCode: data['zipcode'],
      homepage: data['homepage'],
      overview: _stripHtml(data['overview']),
      hanOk: data['hanok'] == 'Y',
      goodStay: data['goodstay'] == '1',
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
  
  /// 숙박 유형
  String get accommodationType {
    if (hanOk == true) return '한옥';
    
    // cat3 코드로 유형 판별
    if (cat3 != null) {
      if (cat3!.startsWith('B02010100')) return '관광호텔';
      if (cat3!.startsWith('B02010500')) return '콘도미니엄';
      if (cat3!.startsWith('B02010600')) return '유스호스텔';
      if (cat3!.startsWith('B02010700')) return '펜션';
      if (cat3!.startsWith('B02010900')) return '모텔';
      if (cat3!.startsWith('B02011000')) return '민박';
      if (cat3!.startsWith('B02011100')) return '게스트하우스';
      if (cat3!.startsWith('B02011200')) return '홈스테이';
      if (cat3!.startsWith('B02011300')) return '서비스드레지던스';
      if (cat3!.startsWith('B02011600')) return '한옥스테이';
    }
    
    return '숙박';
  }
  
  /// 특별 배지들
  List<String> get badges {
    final list = <String>[];
    if (hanOk == true) list.add('한옥');
    if (goodStay == true) list.add('굿스테이');
    if (parking?.isNotEmpty == true) list.add('주차가능');
    if (pickup?.isNotEmpty == true) list.add('픽업가능');
    if (cooking?.isNotEmpty == true) list.add('취사가능');
    return list;
  }
  
  /// 체크인/체크아웃 표시
  String? get checkTimeDisplay {
    if (checkInTime == null && checkOutTime == null) return null;
    
    final parts = <String>[];
    if (checkInTime != null) parts.add('체크인: $checkInTime');
    if (checkOutTime != null) parts.add('체크아웃: $checkOutTime');
    return parts.join(' / ');
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
  
  /// 예약 가능 여부
  bool get isReservable => 
    reservationUrl?.isNotEmpty == true || reservationTel?.isNotEmpty == true;
  
  /// HTML 태그 제거
  static String? _stripHtml(String? html) {
    if (html == null) return null;
    return html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}