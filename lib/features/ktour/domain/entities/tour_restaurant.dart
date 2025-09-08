import 'package:freezed_annotation/freezed_annotation.dart';

part 'tour_restaurant.freezed.dart';
part 'tour_restaurant.g.dart';

/// 음식점 엔티티
@freezed
class TourRestaurant with _$TourRestaurant {
  const factory TourRestaurant({
    required String contentId,
    required String contentTypeId,
    required String title,
    String? address1,
    String? address2,
    String? areaCode,
    String? sigunguCode,
    String? cat1,
    String? cat2,
    String? cat3,
    String? firstImage,
    String? firstImage2,
    double? mapX,
    double? mapY,
    String? tel,
    String? zipCode,
    
    // 음식점 특화 필드
    String? firstMenu,        // 대표 메뉴
    String? treatMenu,        // 취급 메뉴
    String? openTime,         // 영업시간
    String? openDateFood,     // 개업일
    String? restDate,         // 휴무일
    String? parking,          // 주차 정보
    String? kidsFacility,     // 어린이 놀이방
    String? smoking,          // 금연/흡연
    String? packing,          // 포장 가능
    String? infoCenter,       // 문의 및 안내
    String? scaleFoodPlace,   // 규모
    String? seatFood,         // 좌석수
    String? reservationFood,  // 예약 안내
    String? discountInfo,     // 할인 정보
    String? creditCard,       // 신용카드 가능
    String? lcnsNo,          // 인허가번호
    
    // 추가 메타 정보
    double? distance,         // 현재 위치로부터의 거리
    @Default(false) bool isBookmarked,  // 북마크 여부
    String? createdTime,
    String? modifiedTime,
  }) = _TourRestaurant;

  factory TourRestaurant.fromJson(Map<String, dynamic> json) =>
      _$TourRestaurantFromJson(json);

  /// API 응답에서 객체 생성
  factory TourRestaurant.fromApiResponse(Map<String, dynamic> data) {
    return TourRestaurant(
      contentId: data['contentid']?.toString() ?? '',
      contentTypeId: data['contenttypeid']?.toString() ?? '39',
      title: data['title'] ?? '',
      address1: data['addr1'],
      address2: data['addr2'],
      areaCode: data['areacode'],
      sigunguCode: data['sigungucode'],
      cat1: data['cat1'],
      cat2: data['cat2'],
      cat3: data['cat3'],
      firstImage: data['firstimage'],
      firstImage2: data['firstimage2'],
      mapX: _parseDouble(data['mapx']),
      mapY: _parseDouble(data['mapy']),
      tel: data['tel'],
      zipCode: data['zipcode'],
      firstMenu: data['firstmenu'],
      treatMenu: data['treatmenu'],
      openTime: data['opentimefood'],
      openDateFood: data['opendatefood'],
      restDate: data['restdatefood'],
      parking: data['parkingfood'],
      kidsFacility: data['kidsfacility'],
      smoking: data['smoking'],
      packing: data['packing'],
      infoCenter: data['infocenter'],
      scaleFoodPlace: data['scale'],
      seatFood: data['seat'],
      reservationFood: data['reservationfood'],
      discountInfo: data['discountinfofood'],
      creditCard: data['chkcreditcardfood'],
      lcnsNo: data['lcnsno'],
      distance: _parseDouble(data['dist']),
      createdTime: data['createdtime'],
      modifiedTime: data['modifiedtime'],
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}