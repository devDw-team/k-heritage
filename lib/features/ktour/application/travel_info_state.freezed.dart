// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'travel_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TravelFilter {
  String? get areaCode => throw _privateConstructorUsedError;
  String? get sigunguCode => throw _privateConstructorUsedError;
  String? get foodType =>
      throw _privateConstructorUsedError; // 음식 종류 (한식/중식/일식 등)
  String? get shopType =>
      throw _privateConstructorUsedError; // 쇼핑 종류 (백화점/아울렛/전통시장 등)
  bool get hasParking => throw _privateConstructorUsedError;
  bool get goodStay => throw _privateConstructorUsedError; // 굿스테이 여부
  bool get hanOk => throw _privateConstructorUsedError; // 한옥 여부
  SortBy get sortBy => throw _privateConstructorUsedError;
  double? get maxDistance => throw _privateConstructorUsedError;

  /// Create a copy of TravelFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TravelFilterCopyWith<TravelFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TravelFilterCopyWith<$Res> {
  factory $TravelFilterCopyWith(
          TravelFilter value, $Res Function(TravelFilter) then) =
      _$TravelFilterCopyWithImpl<$Res, TravelFilter>;
  @useResult
  $Res call(
      {String? areaCode,
      String? sigunguCode,
      String? foodType,
      String? shopType,
      bool hasParking,
      bool goodStay,
      bool hanOk,
      SortBy sortBy,
      double? maxDistance});
}

/// @nodoc
class _$TravelFilterCopyWithImpl<$Res, $Val extends TravelFilter>
    implements $TravelFilterCopyWith<$Res> {
  _$TravelFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TravelFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areaCode = freezed,
    Object? sigunguCode = freezed,
    Object? foodType = freezed,
    Object? shopType = freezed,
    Object? hasParking = null,
    Object? goodStay = null,
    Object? hanOk = null,
    Object? sortBy = null,
    Object? maxDistance = freezed,
  }) {
    return _then(_value.copyWith(
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      sigunguCode: freezed == sigunguCode
          ? _value.sigunguCode
          : sigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      foodType: freezed == foodType
          ? _value.foodType
          : foodType // ignore: cast_nullable_to_non_nullable
              as String?,
      shopType: freezed == shopType
          ? _value.shopType
          : shopType // ignore: cast_nullable_to_non_nullable
              as String?,
      hasParking: null == hasParking
          ? _value.hasParking
          : hasParking // ignore: cast_nullable_to_non_nullable
              as bool,
      goodStay: null == goodStay
          ? _value.goodStay
          : goodStay // ignore: cast_nullable_to_non_nullable
              as bool,
      hanOk: null == hanOk
          ? _value.hanOk
          : hanOk // ignore: cast_nullable_to_non_nullable
              as bool,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SortBy,
      maxDistance: freezed == maxDistance
          ? _value.maxDistance
          : maxDistance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TravelFilterImplCopyWith<$Res>
    implements $TravelFilterCopyWith<$Res> {
  factory _$$TravelFilterImplCopyWith(
          _$TravelFilterImpl value, $Res Function(_$TravelFilterImpl) then) =
      __$$TravelFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? areaCode,
      String? sigunguCode,
      String? foodType,
      String? shopType,
      bool hasParking,
      bool goodStay,
      bool hanOk,
      SortBy sortBy,
      double? maxDistance});
}

/// @nodoc
class __$$TravelFilterImplCopyWithImpl<$Res>
    extends _$TravelFilterCopyWithImpl<$Res, _$TravelFilterImpl>
    implements _$$TravelFilterImplCopyWith<$Res> {
  __$$TravelFilterImplCopyWithImpl(
      _$TravelFilterImpl _value, $Res Function(_$TravelFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of TravelFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areaCode = freezed,
    Object? sigunguCode = freezed,
    Object? foodType = freezed,
    Object? shopType = freezed,
    Object? hasParking = null,
    Object? goodStay = null,
    Object? hanOk = null,
    Object? sortBy = null,
    Object? maxDistance = freezed,
  }) {
    return _then(_$TravelFilterImpl(
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      sigunguCode: freezed == sigunguCode
          ? _value.sigunguCode
          : sigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      foodType: freezed == foodType
          ? _value.foodType
          : foodType // ignore: cast_nullable_to_non_nullable
              as String?,
      shopType: freezed == shopType
          ? _value.shopType
          : shopType // ignore: cast_nullable_to_non_nullable
              as String?,
      hasParking: null == hasParking
          ? _value.hasParking
          : hasParking // ignore: cast_nullable_to_non_nullable
              as bool,
      goodStay: null == goodStay
          ? _value.goodStay
          : goodStay // ignore: cast_nullable_to_non_nullable
              as bool,
      hanOk: null == hanOk
          ? _value.hanOk
          : hanOk // ignore: cast_nullable_to_non_nullable
              as bool,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SortBy,
      maxDistance: freezed == maxDistance
          ? _value.maxDistance
          : maxDistance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$TravelFilterImpl implements _TravelFilter {
  const _$TravelFilterImpl(
      {this.areaCode,
      this.sigunguCode,
      this.foodType,
      this.shopType,
      this.hasParking = false,
      this.goodStay = false,
      this.hanOk = false,
      this.sortBy = SortBy.distance,
      this.maxDistance});

  @override
  final String? areaCode;
  @override
  final String? sigunguCode;
  @override
  final String? foodType;
// 음식 종류 (한식/중식/일식 등)
  @override
  final String? shopType;
// 쇼핑 종류 (백화점/아울렛/전통시장 등)
  @override
  @JsonKey()
  final bool hasParking;
  @override
  @JsonKey()
  final bool goodStay;
// 굿스테이 여부
  @override
  @JsonKey()
  final bool hanOk;
// 한옥 여부
  @override
  @JsonKey()
  final SortBy sortBy;
  @override
  final double? maxDistance;

  @override
  String toString() {
    return 'TravelFilter(areaCode: $areaCode, sigunguCode: $sigunguCode, foodType: $foodType, shopType: $shopType, hasParking: $hasParking, goodStay: $goodStay, hanOk: $hanOk, sortBy: $sortBy, maxDistance: $maxDistance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TravelFilterImpl &&
            (identical(other.areaCode, areaCode) ||
                other.areaCode == areaCode) &&
            (identical(other.sigunguCode, sigunguCode) ||
                other.sigunguCode == sigunguCode) &&
            (identical(other.foodType, foodType) ||
                other.foodType == foodType) &&
            (identical(other.shopType, shopType) ||
                other.shopType == shopType) &&
            (identical(other.hasParking, hasParking) ||
                other.hasParking == hasParking) &&
            (identical(other.goodStay, goodStay) ||
                other.goodStay == goodStay) &&
            (identical(other.hanOk, hanOk) || other.hanOk == hanOk) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.maxDistance, maxDistance) ||
                other.maxDistance == maxDistance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, areaCode, sigunguCode, foodType,
      shopType, hasParking, goodStay, hanOk, sortBy, maxDistance);

  /// Create a copy of TravelFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TravelFilterImplCopyWith<_$TravelFilterImpl> get copyWith =>
      __$$TravelFilterImplCopyWithImpl<_$TravelFilterImpl>(this, _$identity);
}

abstract class _TravelFilter implements TravelFilter {
  const factory _TravelFilter(
      {final String? areaCode,
      final String? sigunguCode,
      final String? foodType,
      final String? shopType,
      final bool hasParking,
      final bool goodStay,
      final bool hanOk,
      final SortBy sortBy,
      final double? maxDistance}) = _$TravelFilterImpl;

  @override
  String? get areaCode;
  @override
  String? get sigunguCode;
  @override
  String? get foodType; // 음식 종류 (한식/중식/일식 등)
  @override
  String? get shopType; // 쇼핑 종류 (백화점/아울렛/전통시장 등)
  @override
  bool get hasParking;
  @override
  bool get goodStay; // 굿스테이 여부
  @override
  bool get hanOk; // 한옥 여부
  @override
  SortBy get sortBy;
  @override
  double? get maxDistance;

  /// Create a copy of TravelFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TravelFilterImplCopyWith<_$TravelFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TravelInfoState {
// 카테고리별 데이터
  List<TourRestaurant> get restaurants => throw _privateConstructorUsedError;
  List<TourStay> get accommodations => throw _privateConstructorUsedError;
  List<TourShopping> get shopping =>
      throw _privateConstructorUsedError; // 로딩 상태
  bool get isLoadingRestaurants => throw _privateConstructorUsedError;
  bool get isLoadingAccommodations => throw _privateConstructorUsedError;
  bool get isLoadingShopping => throw _privateConstructorUsedError; // 에러 상태
  String? get restaurantsError => throw _privateConstructorUsedError;
  String? get accommodationsError => throw _privateConstructorUsedError;
  String? get shoppingError => throw _privateConstructorUsedError; // UI 상태
  TravelCategory get selectedCategory => throw _privateConstructorUsedError;
  TravelFilter get filter => throw _privateConstructorUsedError; // 페이징
  int get restaurantsPage => throw _privateConstructorUsedError;
  int get accommodationsPage => throw _privateConstructorUsedError;
  int get shoppingPage => throw _privateConstructorUsedError;
  bool get hasMoreRestaurants => throw _privateConstructorUsedError;
  bool get hasMoreAccommodations => throw _privateConstructorUsedError;
  bool get hasMoreShopping => throw _privateConstructorUsedError; // 위치 정보
  double? get currentLat => throw _privateConstructorUsedError;
  double? get currentLng => throw _privateConstructorUsedError;

  /// Create a copy of TravelInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TravelInfoStateCopyWith<TravelInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TravelInfoStateCopyWith<$Res> {
  factory $TravelInfoStateCopyWith(
          TravelInfoState value, $Res Function(TravelInfoState) then) =
      _$TravelInfoStateCopyWithImpl<$Res, TravelInfoState>;
  @useResult
  $Res call(
      {List<TourRestaurant> restaurants,
      List<TourStay> accommodations,
      List<TourShopping> shopping,
      bool isLoadingRestaurants,
      bool isLoadingAccommodations,
      bool isLoadingShopping,
      String? restaurantsError,
      String? accommodationsError,
      String? shoppingError,
      TravelCategory selectedCategory,
      TravelFilter filter,
      int restaurantsPage,
      int accommodationsPage,
      int shoppingPage,
      bool hasMoreRestaurants,
      bool hasMoreAccommodations,
      bool hasMoreShopping,
      double? currentLat,
      double? currentLng});

  $TravelFilterCopyWith<$Res> get filter;
}

/// @nodoc
class _$TravelInfoStateCopyWithImpl<$Res, $Val extends TravelInfoState>
    implements $TravelInfoStateCopyWith<$Res> {
  _$TravelInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TravelInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurants = null,
    Object? accommodations = null,
    Object? shopping = null,
    Object? isLoadingRestaurants = null,
    Object? isLoadingAccommodations = null,
    Object? isLoadingShopping = null,
    Object? restaurantsError = freezed,
    Object? accommodationsError = freezed,
    Object? shoppingError = freezed,
    Object? selectedCategory = null,
    Object? filter = null,
    Object? restaurantsPage = null,
    Object? accommodationsPage = null,
    Object? shoppingPage = null,
    Object? hasMoreRestaurants = null,
    Object? hasMoreAccommodations = null,
    Object? hasMoreShopping = null,
    Object? currentLat = freezed,
    Object? currentLng = freezed,
  }) {
    return _then(_value.copyWith(
      restaurants: null == restaurants
          ? _value.restaurants
          : restaurants // ignore: cast_nullable_to_non_nullable
              as List<TourRestaurant>,
      accommodations: null == accommodations
          ? _value.accommodations
          : accommodations // ignore: cast_nullable_to_non_nullable
              as List<TourStay>,
      shopping: null == shopping
          ? _value.shopping
          : shopping // ignore: cast_nullable_to_non_nullable
              as List<TourShopping>,
      isLoadingRestaurants: null == isLoadingRestaurants
          ? _value.isLoadingRestaurants
          : isLoadingRestaurants // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingAccommodations: null == isLoadingAccommodations
          ? _value.isLoadingAccommodations
          : isLoadingAccommodations // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingShopping: null == isLoadingShopping
          ? _value.isLoadingShopping
          : isLoadingShopping // ignore: cast_nullable_to_non_nullable
              as bool,
      restaurantsError: freezed == restaurantsError
          ? _value.restaurantsError
          : restaurantsError // ignore: cast_nullable_to_non_nullable
              as String?,
      accommodationsError: freezed == accommodationsError
          ? _value.accommodationsError
          : accommodationsError // ignore: cast_nullable_to_non_nullable
              as String?,
      shoppingError: freezed == shoppingError
          ? _value.shoppingError
          : shoppingError // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedCategory: null == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as TravelCategory,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TravelFilter,
      restaurantsPage: null == restaurantsPage
          ? _value.restaurantsPage
          : restaurantsPage // ignore: cast_nullable_to_non_nullable
              as int,
      accommodationsPage: null == accommodationsPage
          ? _value.accommodationsPage
          : accommodationsPage // ignore: cast_nullable_to_non_nullable
              as int,
      shoppingPage: null == shoppingPage
          ? _value.shoppingPage
          : shoppingPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreRestaurants: null == hasMoreRestaurants
          ? _value.hasMoreRestaurants
          : hasMoreRestaurants // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreAccommodations: null == hasMoreAccommodations
          ? _value.hasMoreAccommodations
          : hasMoreAccommodations // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreShopping: null == hasMoreShopping
          ? _value.hasMoreShopping
          : hasMoreShopping // ignore: cast_nullable_to_non_nullable
              as bool,
      currentLat: freezed == currentLat
          ? _value.currentLat
          : currentLat // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLng: freezed == currentLng
          ? _value.currentLng
          : currentLng // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of TravelInfoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TravelFilterCopyWith<$Res> get filter {
    return $TravelFilterCopyWith<$Res>(_value.filter, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TravelInfoStateImplCopyWith<$Res>
    implements $TravelInfoStateCopyWith<$Res> {
  factory _$$TravelInfoStateImplCopyWith(_$TravelInfoStateImpl value,
          $Res Function(_$TravelInfoStateImpl) then) =
      __$$TravelInfoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TourRestaurant> restaurants,
      List<TourStay> accommodations,
      List<TourShopping> shopping,
      bool isLoadingRestaurants,
      bool isLoadingAccommodations,
      bool isLoadingShopping,
      String? restaurantsError,
      String? accommodationsError,
      String? shoppingError,
      TravelCategory selectedCategory,
      TravelFilter filter,
      int restaurantsPage,
      int accommodationsPage,
      int shoppingPage,
      bool hasMoreRestaurants,
      bool hasMoreAccommodations,
      bool hasMoreShopping,
      double? currentLat,
      double? currentLng});

  @override
  $TravelFilterCopyWith<$Res> get filter;
}

/// @nodoc
class __$$TravelInfoStateImplCopyWithImpl<$Res>
    extends _$TravelInfoStateCopyWithImpl<$Res, _$TravelInfoStateImpl>
    implements _$$TravelInfoStateImplCopyWith<$Res> {
  __$$TravelInfoStateImplCopyWithImpl(
      _$TravelInfoStateImpl _value, $Res Function(_$TravelInfoStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TravelInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurants = null,
    Object? accommodations = null,
    Object? shopping = null,
    Object? isLoadingRestaurants = null,
    Object? isLoadingAccommodations = null,
    Object? isLoadingShopping = null,
    Object? restaurantsError = freezed,
    Object? accommodationsError = freezed,
    Object? shoppingError = freezed,
    Object? selectedCategory = null,
    Object? filter = null,
    Object? restaurantsPage = null,
    Object? accommodationsPage = null,
    Object? shoppingPage = null,
    Object? hasMoreRestaurants = null,
    Object? hasMoreAccommodations = null,
    Object? hasMoreShopping = null,
    Object? currentLat = freezed,
    Object? currentLng = freezed,
  }) {
    return _then(_$TravelInfoStateImpl(
      restaurants: null == restaurants
          ? _value._restaurants
          : restaurants // ignore: cast_nullable_to_non_nullable
              as List<TourRestaurant>,
      accommodations: null == accommodations
          ? _value._accommodations
          : accommodations // ignore: cast_nullable_to_non_nullable
              as List<TourStay>,
      shopping: null == shopping
          ? _value._shopping
          : shopping // ignore: cast_nullable_to_non_nullable
              as List<TourShopping>,
      isLoadingRestaurants: null == isLoadingRestaurants
          ? _value.isLoadingRestaurants
          : isLoadingRestaurants // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingAccommodations: null == isLoadingAccommodations
          ? _value.isLoadingAccommodations
          : isLoadingAccommodations // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingShopping: null == isLoadingShopping
          ? _value.isLoadingShopping
          : isLoadingShopping // ignore: cast_nullable_to_non_nullable
              as bool,
      restaurantsError: freezed == restaurantsError
          ? _value.restaurantsError
          : restaurantsError // ignore: cast_nullable_to_non_nullable
              as String?,
      accommodationsError: freezed == accommodationsError
          ? _value.accommodationsError
          : accommodationsError // ignore: cast_nullable_to_non_nullable
              as String?,
      shoppingError: freezed == shoppingError
          ? _value.shoppingError
          : shoppingError // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedCategory: null == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as TravelCategory,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TravelFilter,
      restaurantsPage: null == restaurantsPage
          ? _value.restaurantsPage
          : restaurantsPage // ignore: cast_nullable_to_non_nullable
              as int,
      accommodationsPage: null == accommodationsPage
          ? _value.accommodationsPage
          : accommodationsPage // ignore: cast_nullable_to_non_nullable
              as int,
      shoppingPage: null == shoppingPage
          ? _value.shoppingPage
          : shoppingPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreRestaurants: null == hasMoreRestaurants
          ? _value.hasMoreRestaurants
          : hasMoreRestaurants // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreAccommodations: null == hasMoreAccommodations
          ? _value.hasMoreAccommodations
          : hasMoreAccommodations // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreShopping: null == hasMoreShopping
          ? _value.hasMoreShopping
          : hasMoreShopping // ignore: cast_nullable_to_non_nullable
              as bool,
      currentLat: freezed == currentLat
          ? _value.currentLat
          : currentLat // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLng: freezed == currentLng
          ? _value.currentLng
          : currentLng // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$TravelInfoStateImpl implements _TravelInfoState {
  const _$TravelInfoStateImpl(
      {final List<TourRestaurant> restaurants = const [],
      final List<TourStay> accommodations = const [],
      final List<TourShopping> shopping = const [],
      this.isLoadingRestaurants = false,
      this.isLoadingAccommodations = false,
      this.isLoadingShopping = false,
      this.restaurantsError,
      this.accommodationsError,
      this.shoppingError,
      this.selectedCategory = TravelCategory.all,
      this.filter = const TravelFilter(),
      this.restaurantsPage = 1,
      this.accommodationsPage = 1,
      this.shoppingPage = 1,
      this.hasMoreRestaurants = false,
      this.hasMoreAccommodations = false,
      this.hasMoreShopping = false,
      this.currentLat,
      this.currentLng})
      : _restaurants = restaurants,
        _accommodations = accommodations,
        _shopping = shopping;

// 카테고리별 데이터
  final List<TourRestaurant> _restaurants;
// 카테고리별 데이터
  @override
  @JsonKey()
  List<TourRestaurant> get restaurants {
    if (_restaurants is EqualUnmodifiableListView) return _restaurants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_restaurants);
  }

  final List<TourStay> _accommodations;
  @override
  @JsonKey()
  List<TourStay> get accommodations {
    if (_accommodations is EqualUnmodifiableListView) return _accommodations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accommodations);
  }

  final List<TourShopping> _shopping;
  @override
  @JsonKey()
  List<TourShopping> get shopping {
    if (_shopping is EqualUnmodifiableListView) return _shopping;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shopping);
  }

// 로딩 상태
  @override
  @JsonKey()
  final bool isLoadingRestaurants;
  @override
  @JsonKey()
  final bool isLoadingAccommodations;
  @override
  @JsonKey()
  final bool isLoadingShopping;
// 에러 상태
  @override
  final String? restaurantsError;
  @override
  final String? accommodationsError;
  @override
  final String? shoppingError;
// UI 상태
  @override
  @JsonKey()
  final TravelCategory selectedCategory;
  @override
  @JsonKey()
  final TravelFilter filter;
// 페이징
  @override
  @JsonKey()
  final int restaurantsPage;
  @override
  @JsonKey()
  final int accommodationsPage;
  @override
  @JsonKey()
  final int shoppingPage;
  @override
  @JsonKey()
  final bool hasMoreRestaurants;
  @override
  @JsonKey()
  final bool hasMoreAccommodations;
  @override
  @JsonKey()
  final bool hasMoreShopping;
// 위치 정보
  @override
  final double? currentLat;
  @override
  final double? currentLng;

  @override
  String toString() {
    return 'TravelInfoState(restaurants: $restaurants, accommodations: $accommodations, shopping: $shopping, isLoadingRestaurants: $isLoadingRestaurants, isLoadingAccommodations: $isLoadingAccommodations, isLoadingShopping: $isLoadingShopping, restaurantsError: $restaurantsError, accommodationsError: $accommodationsError, shoppingError: $shoppingError, selectedCategory: $selectedCategory, filter: $filter, restaurantsPage: $restaurantsPage, accommodationsPage: $accommodationsPage, shoppingPage: $shoppingPage, hasMoreRestaurants: $hasMoreRestaurants, hasMoreAccommodations: $hasMoreAccommodations, hasMoreShopping: $hasMoreShopping, currentLat: $currentLat, currentLng: $currentLng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TravelInfoStateImpl &&
            const DeepCollectionEquality()
                .equals(other._restaurants, _restaurants) &&
            const DeepCollectionEquality()
                .equals(other._accommodations, _accommodations) &&
            const DeepCollectionEquality().equals(other._shopping, _shopping) &&
            (identical(other.isLoadingRestaurants, isLoadingRestaurants) ||
                other.isLoadingRestaurants == isLoadingRestaurants) &&
            (identical(
                    other.isLoadingAccommodations, isLoadingAccommodations) ||
                other.isLoadingAccommodations == isLoadingAccommodations) &&
            (identical(other.isLoadingShopping, isLoadingShopping) ||
                other.isLoadingShopping == isLoadingShopping) &&
            (identical(other.restaurantsError, restaurantsError) ||
                other.restaurantsError == restaurantsError) &&
            (identical(other.accommodationsError, accommodationsError) ||
                other.accommodationsError == accommodationsError) &&
            (identical(other.shoppingError, shoppingError) ||
                other.shoppingError == shoppingError) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.restaurantsPage, restaurantsPage) ||
                other.restaurantsPage == restaurantsPage) &&
            (identical(other.accommodationsPage, accommodationsPage) ||
                other.accommodationsPage == accommodationsPage) &&
            (identical(other.shoppingPage, shoppingPage) ||
                other.shoppingPage == shoppingPage) &&
            (identical(other.hasMoreRestaurants, hasMoreRestaurants) ||
                other.hasMoreRestaurants == hasMoreRestaurants) &&
            (identical(other.hasMoreAccommodations, hasMoreAccommodations) ||
                other.hasMoreAccommodations == hasMoreAccommodations) &&
            (identical(other.hasMoreShopping, hasMoreShopping) ||
                other.hasMoreShopping == hasMoreShopping) &&
            (identical(other.currentLat, currentLat) ||
                other.currentLat == currentLat) &&
            (identical(other.currentLng, currentLng) ||
                other.currentLng == currentLng));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(_restaurants),
        const DeepCollectionEquality().hash(_accommodations),
        const DeepCollectionEquality().hash(_shopping),
        isLoadingRestaurants,
        isLoadingAccommodations,
        isLoadingShopping,
        restaurantsError,
        accommodationsError,
        shoppingError,
        selectedCategory,
        filter,
        restaurantsPage,
        accommodationsPage,
        shoppingPage,
        hasMoreRestaurants,
        hasMoreAccommodations,
        hasMoreShopping,
        currentLat,
        currentLng
      ]);

  /// Create a copy of TravelInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TravelInfoStateImplCopyWith<_$TravelInfoStateImpl> get copyWith =>
      __$$TravelInfoStateImplCopyWithImpl<_$TravelInfoStateImpl>(
          this, _$identity);
}

abstract class _TravelInfoState implements TravelInfoState {
  const factory _TravelInfoState(
      {final List<TourRestaurant> restaurants,
      final List<TourStay> accommodations,
      final List<TourShopping> shopping,
      final bool isLoadingRestaurants,
      final bool isLoadingAccommodations,
      final bool isLoadingShopping,
      final String? restaurantsError,
      final String? accommodationsError,
      final String? shoppingError,
      final TravelCategory selectedCategory,
      final TravelFilter filter,
      final int restaurantsPage,
      final int accommodationsPage,
      final int shoppingPage,
      final bool hasMoreRestaurants,
      final bool hasMoreAccommodations,
      final bool hasMoreShopping,
      final double? currentLat,
      final double? currentLng}) = _$TravelInfoStateImpl;

// 카테고리별 데이터
  @override
  List<TourRestaurant> get restaurants;
  @override
  List<TourStay> get accommodations;
  @override
  List<TourShopping> get shopping; // 로딩 상태
  @override
  bool get isLoadingRestaurants;
  @override
  bool get isLoadingAccommodations;
  @override
  bool get isLoadingShopping; // 에러 상태
  @override
  String? get restaurantsError;
  @override
  String? get accommodationsError;
  @override
  String? get shoppingError; // UI 상태
  @override
  TravelCategory get selectedCategory;
  @override
  TravelFilter get filter; // 페이징
  @override
  int get restaurantsPage;
  @override
  int get accommodationsPage;
  @override
  int get shoppingPage;
  @override
  bool get hasMoreRestaurants;
  @override
  bool get hasMoreAccommodations;
  @override
  bool get hasMoreShopping; // 위치 정보
  @override
  double? get currentLat;
  @override
  double? get currentLng;

  /// Create a copy of TravelInfoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TravelInfoStateImplCopyWith<_$TravelInfoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
