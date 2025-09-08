import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/entities/tour_restaurant.dart';
import '../domain/entities/tour_shopping.dart';
import '../domain/entities/tour_stay.dart';

part 'travel_info_state.freezed.dart';

enum TravelCategory {
  all('전체'),
  restaurant('맛집'),
  accommodation('숙박'),
  shopping('쇼핑'),
  transport('교통');

  final String label;
  const TravelCategory(this.label);
}

enum SortBy {
  distance('거리순'),
  name('이름순'),
  popular('인기순');

  final String label;
  const SortBy(this.label);
}

@freezed
class TravelFilter with _$TravelFilter {
  const factory TravelFilter({
    String? areaCode,
    String? sigunguCode,
    String? foodType,      // 음식 종류 (한식/중식/일식 등)
    String? shopType,      // 쇼핑 종류 (백화점/아울렛/전통시장 등)
    @Default(false) bool hasParking,
    @Default(false) bool goodStay,  // 굿스테이 여부
    @Default(false) bool hanOk,     // 한옥 여부
    @Default(SortBy.distance) SortBy sortBy,
    double? maxDistance,   // 최대 거리 (km)
  }) = _TravelFilter;
}

@freezed
class TravelInfoState with _$TravelInfoState {
  const factory TravelInfoState({
    // 카테고리별 데이터
    @Default([]) List<TourRestaurant> restaurants,
    @Default([]) List<TourStay> accommodations,
    @Default([]) List<TourShopping> shopping,
    
    // 로딩 상태
    @Default(false) bool isLoadingRestaurants,
    @Default(false) bool isLoadingAccommodations,
    @Default(false) bool isLoadingShopping,
    
    // 에러 상태
    String? restaurantsError,
    String? accommodationsError,
    String? shoppingError,
    
    // UI 상태
    @Default(TravelCategory.all) TravelCategory selectedCategory,
    @Default(TravelFilter()) TravelFilter filter,
    
    // 페이징
    @Default(1) int restaurantsPage,
    @Default(1) int accommodationsPage,
    @Default(1) int shoppingPage,
    @Default(false) bool hasMoreRestaurants,
    @Default(false) bool hasMoreAccommodations,
    @Default(false) bool hasMoreShopping,
    
    // 위치 정보
    double? currentLat,
    double? currentLng,
  }) = _TravelInfoState;
}