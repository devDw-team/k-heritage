import 'package:freezed_annotation/freezed_annotation.dart';

part 'tour_shopping.freezed.dart';
part 'tour_shopping.g.dart';

/// 쇼핑 엔티티
@freezed
class TourShopping with _$TourShopping {
  const factory TourShopping({
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
    
    // 쇼핑 특화 필드
    String? openTime,         // 영업시간
    String? openDate,         // 개업일
    String? restDate,         // 휴무일
    String? saleItem,         // 판매 품목
    String? saleItemCost,     // 가격 정보
    String? fairDay,          // 장날 (전통시장)
    String? shopGuide,        // 매장 안내
    String? parking,          // 주차 정보
    String? restroom,         // 화장실
    String? infoCenter,       // 문의 및 안내
    String? scale,            // 규모
    String? babyCarriage,     // 유모차 대여
    String? petPossible,      // 애완동물 동반
    String? creditCard,       // 신용카드 가능
    String? culturalCenter,   // 문화센터
    
    // 추가 메타 정보
    double? distance,         // 현재 위치로부터의 거리
    @Default(false) bool isBookmarked,  // 북마크 여부
    String? createdTime,
    String? modifiedTime,
  }) = _TourShopping;

  factory TourShopping.fromJson(Map<String, dynamic> json) =>
      _$TourShoppingFromJson(json);

  /// API 응답에서 객체 생성
  factory TourShopping.fromApiResponse(Map<String, dynamic> data) {
    return TourShopping(
      contentId: data['contentid']?.toString() ?? '',
      contentTypeId: data['contenttypeid']?.toString() ?? '38',
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
      openTime: data['opentime'],
      openDate: data['opendate'],
      restDate: data['restdate'],
      saleItem: data['saleitem'],
      saleItemCost: data['saleitemcost'],
      fairDay: data['fairday'],
      shopGuide: data['shopguide'],
      parking: data['parking'],
      restroom: data['restroom'],
      infoCenter: data['infocenter'],
      scale: data['scale'],
      babyCarriage: data['chkbabycarriage'],
      petPossible: data['chkpet'],
      creditCard: data['chkcreditcard'],
      culturalCenter: data['culturecenter'],
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