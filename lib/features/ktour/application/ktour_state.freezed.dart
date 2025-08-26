// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ktour_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KTourState {
// 인기 관광지
  List<TourAttraction> get popularAttractions =>
      throw _privateConstructorUsedError;
  bool get isLoadingPopular => throw _privateConstructorUsedError;
  String? get popularError => throw _privateConstructorUsedError; // 진행중인 축제
  List<TourFestival> get ongoingFestivals => throw _privateConstructorUsedError;
  bool get isLoadingFestivals => throw _privateConstructorUsedError;
  String? get festivalsError => throw _privateConstructorUsedError; // 내 주변 관광지
  List<TourAttraction> get nearbyAttractions =>
      throw _privateConstructorUsedError;
  bool get isLoadingNearby => throw _privateConstructorUsedError;
  String? get nearbyError => throw _privateConstructorUsedError; // 추천 숙박
  List<TourStay> get recommendedStays => throw _privateConstructorUsedError;
  bool get isLoadingStays => throw _privateConstructorUsedError;
  String? get staysError => throw _privateConstructorUsedError; // 현재 위치
  double? get currentLatitude => throw _privateConstructorUsedError;
  double? get currentLongitude =>
      throw _privateConstructorUsedError; // 선택된 지역 코드
  String? get selectedAreaCode => throw _privateConstructorUsedError;
  String? get selectedSigunguCode =>
      throw _privateConstructorUsedError; // 검색 키워드
  String? get searchKeyword => throw _privateConstructorUsedError; // 로딩 상태
  bool get isInitializing => throw _privateConstructorUsedError; // 마지막 업데이트 시간
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Create a copy of KTourState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KTourStateCopyWith<KTourState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KTourStateCopyWith<$Res> {
  factory $KTourStateCopyWith(
          KTourState value, $Res Function(KTourState) then) =
      _$KTourStateCopyWithImpl<$Res, KTourState>;
  @useResult
  $Res call(
      {List<TourAttraction> popularAttractions,
      bool isLoadingPopular,
      String? popularError,
      List<TourFestival> ongoingFestivals,
      bool isLoadingFestivals,
      String? festivalsError,
      List<TourAttraction> nearbyAttractions,
      bool isLoadingNearby,
      String? nearbyError,
      List<TourStay> recommendedStays,
      bool isLoadingStays,
      String? staysError,
      double? currentLatitude,
      double? currentLongitude,
      String? selectedAreaCode,
      String? selectedSigunguCode,
      String? searchKeyword,
      bool isInitializing,
      DateTime? lastUpdated});
}

/// @nodoc
class _$KTourStateCopyWithImpl<$Res, $Val extends KTourState>
    implements $KTourStateCopyWith<$Res> {
  _$KTourStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KTourState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? popularAttractions = null,
    Object? isLoadingPopular = null,
    Object? popularError = freezed,
    Object? ongoingFestivals = null,
    Object? isLoadingFestivals = null,
    Object? festivalsError = freezed,
    Object? nearbyAttractions = null,
    Object? isLoadingNearby = null,
    Object? nearbyError = freezed,
    Object? recommendedStays = null,
    Object? isLoadingStays = null,
    Object? staysError = freezed,
    Object? currentLatitude = freezed,
    Object? currentLongitude = freezed,
    Object? selectedAreaCode = freezed,
    Object? selectedSigunguCode = freezed,
    Object? searchKeyword = freezed,
    Object? isInitializing = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      popularAttractions: null == popularAttractions
          ? _value.popularAttractions
          : popularAttractions // ignore: cast_nullable_to_non_nullable
              as List<TourAttraction>,
      isLoadingPopular: null == isLoadingPopular
          ? _value.isLoadingPopular
          : isLoadingPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      popularError: freezed == popularError
          ? _value.popularError
          : popularError // ignore: cast_nullable_to_non_nullable
              as String?,
      ongoingFestivals: null == ongoingFestivals
          ? _value.ongoingFestivals
          : ongoingFestivals // ignore: cast_nullable_to_non_nullable
              as List<TourFestival>,
      isLoadingFestivals: null == isLoadingFestivals
          ? _value.isLoadingFestivals
          : isLoadingFestivals // ignore: cast_nullable_to_non_nullable
              as bool,
      festivalsError: freezed == festivalsError
          ? _value.festivalsError
          : festivalsError // ignore: cast_nullable_to_non_nullable
              as String?,
      nearbyAttractions: null == nearbyAttractions
          ? _value.nearbyAttractions
          : nearbyAttractions // ignore: cast_nullable_to_non_nullable
              as List<TourAttraction>,
      isLoadingNearby: null == isLoadingNearby
          ? _value.isLoadingNearby
          : isLoadingNearby // ignore: cast_nullable_to_non_nullable
              as bool,
      nearbyError: freezed == nearbyError
          ? _value.nearbyError
          : nearbyError // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendedStays: null == recommendedStays
          ? _value.recommendedStays
          : recommendedStays // ignore: cast_nullable_to_non_nullable
              as List<TourStay>,
      isLoadingStays: null == isLoadingStays
          ? _value.isLoadingStays
          : isLoadingStays // ignore: cast_nullable_to_non_nullable
              as bool,
      staysError: freezed == staysError
          ? _value.staysError
          : staysError // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLatitude: freezed == currentLatitude
          ? _value.currentLatitude
          : currentLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLongitude: freezed == currentLongitude
          ? _value.currentLongitude
          : currentLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      selectedAreaCode: freezed == selectedAreaCode
          ? _value.selectedAreaCode
          : selectedAreaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSigunguCode: freezed == selectedSigunguCode
          ? _value.selectedSigunguCode
          : selectedSigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      searchKeyword: freezed == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String?,
      isInitializing: null == isInitializing
          ? _value.isInitializing
          : isInitializing // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KTourStateImplCopyWith<$Res>
    implements $KTourStateCopyWith<$Res> {
  factory _$$KTourStateImplCopyWith(
          _$KTourStateImpl value, $Res Function(_$KTourStateImpl) then) =
      __$$KTourStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TourAttraction> popularAttractions,
      bool isLoadingPopular,
      String? popularError,
      List<TourFestival> ongoingFestivals,
      bool isLoadingFestivals,
      String? festivalsError,
      List<TourAttraction> nearbyAttractions,
      bool isLoadingNearby,
      String? nearbyError,
      List<TourStay> recommendedStays,
      bool isLoadingStays,
      String? staysError,
      double? currentLatitude,
      double? currentLongitude,
      String? selectedAreaCode,
      String? selectedSigunguCode,
      String? searchKeyword,
      bool isInitializing,
      DateTime? lastUpdated});
}

/// @nodoc
class __$$KTourStateImplCopyWithImpl<$Res>
    extends _$KTourStateCopyWithImpl<$Res, _$KTourStateImpl>
    implements _$$KTourStateImplCopyWith<$Res> {
  __$$KTourStateImplCopyWithImpl(
      _$KTourStateImpl _value, $Res Function(_$KTourStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of KTourState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? popularAttractions = null,
    Object? isLoadingPopular = null,
    Object? popularError = freezed,
    Object? ongoingFestivals = null,
    Object? isLoadingFestivals = null,
    Object? festivalsError = freezed,
    Object? nearbyAttractions = null,
    Object? isLoadingNearby = null,
    Object? nearbyError = freezed,
    Object? recommendedStays = null,
    Object? isLoadingStays = null,
    Object? staysError = freezed,
    Object? currentLatitude = freezed,
    Object? currentLongitude = freezed,
    Object? selectedAreaCode = freezed,
    Object? selectedSigunguCode = freezed,
    Object? searchKeyword = freezed,
    Object? isInitializing = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$KTourStateImpl(
      popularAttractions: null == popularAttractions
          ? _value._popularAttractions
          : popularAttractions // ignore: cast_nullable_to_non_nullable
              as List<TourAttraction>,
      isLoadingPopular: null == isLoadingPopular
          ? _value.isLoadingPopular
          : isLoadingPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      popularError: freezed == popularError
          ? _value.popularError
          : popularError // ignore: cast_nullable_to_non_nullable
              as String?,
      ongoingFestivals: null == ongoingFestivals
          ? _value._ongoingFestivals
          : ongoingFestivals // ignore: cast_nullable_to_non_nullable
              as List<TourFestival>,
      isLoadingFestivals: null == isLoadingFestivals
          ? _value.isLoadingFestivals
          : isLoadingFestivals // ignore: cast_nullable_to_non_nullable
              as bool,
      festivalsError: freezed == festivalsError
          ? _value.festivalsError
          : festivalsError // ignore: cast_nullable_to_non_nullable
              as String?,
      nearbyAttractions: null == nearbyAttractions
          ? _value._nearbyAttractions
          : nearbyAttractions // ignore: cast_nullable_to_non_nullable
              as List<TourAttraction>,
      isLoadingNearby: null == isLoadingNearby
          ? _value.isLoadingNearby
          : isLoadingNearby // ignore: cast_nullable_to_non_nullable
              as bool,
      nearbyError: freezed == nearbyError
          ? _value.nearbyError
          : nearbyError // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendedStays: null == recommendedStays
          ? _value._recommendedStays
          : recommendedStays // ignore: cast_nullable_to_non_nullable
              as List<TourStay>,
      isLoadingStays: null == isLoadingStays
          ? _value.isLoadingStays
          : isLoadingStays // ignore: cast_nullable_to_non_nullable
              as bool,
      staysError: freezed == staysError
          ? _value.staysError
          : staysError // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLatitude: freezed == currentLatitude
          ? _value.currentLatitude
          : currentLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLongitude: freezed == currentLongitude
          ? _value.currentLongitude
          : currentLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      selectedAreaCode: freezed == selectedAreaCode
          ? _value.selectedAreaCode
          : selectedAreaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSigunguCode: freezed == selectedSigunguCode
          ? _value.selectedSigunguCode
          : selectedSigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      searchKeyword: freezed == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String?,
      isInitializing: null == isInitializing
          ? _value.isInitializing
          : isInitializing // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$KTourStateImpl extends _KTourState {
  const _$KTourStateImpl(
      {final List<TourAttraction> popularAttractions = const [],
      this.isLoadingPopular = false,
      this.popularError,
      final List<TourFestival> ongoingFestivals = const [],
      this.isLoadingFestivals = false,
      this.festivalsError,
      final List<TourAttraction> nearbyAttractions = const [],
      this.isLoadingNearby = false,
      this.nearbyError,
      final List<TourStay> recommendedStays = const [],
      this.isLoadingStays = false,
      this.staysError,
      this.currentLatitude,
      this.currentLongitude,
      this.selectedAreaCode,
      this.selectedSigunguCode,
      this.searchKeyword,
      this.isInitializing = false,
      this.lastUpdated})
      : _popularAttractions = popularAttractions,
        _ongoingFestivals = ongoingFestivals,
        _nearbyAttractions = nearbyAttractions,
        _recommendedStays = recommendedStays,
        super._();

// 인기 관광지
  final List<TourAttraction> _popularAttractions;
// 인기 관광지
  @override
  @JsonKey()
  List<TourAttraction> get popularAttractions {
    if (_popularAttractions is EqualUnmodifiableListView)
      return _popularAttractions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_popularAttractions);
  }

  @override
  @JsonKey()
  final bool isLoadingPopular;
  @override
  final String? popularError;
// 진행중인 축제
  final List<TourFestival> _ongoingFestivals;
// 진행중인 축제
  @override
  @JsonKey()
  List<TourFestival> get ongoingFestivals {
    if (_ongoingFestivals is EqualUnmodifiableListView)
      return _ongoingFestivals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ongoingFestivals);
  }

  @override
  @JsonKey()
  final bool isLoadingFestivals;
  @override
  final String? festivalsError;
// 내 주변 관광지
  final List<TourAttraction> _nearbyAttractions;
// 내 주변 관광지
  @override
  @JsonKey()
  List<TourAttraction> get nearbyAttractions {
    if (_nearbyAttractions is EqualUnmodifiableListView)
      return _nearbyAttractions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbyAttractions);
  }

  @override
  @JsonKey()
  final bool isLoadingNearby;
  @override
  final String? nearbyError;
// 추천 숙박
  final List<TourStay> _recommendedStays;
// 추천 숙박
  @override
  @JsonKey()
  List<TourStay> get recommendedStays {
    if (_recommendedStays is EqualUnmodifiableListView)
      return _recommendedStays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedStays);
  }

  @override
  @JsonKey()
  final bool isLoadingStays;
  @override
  final String? staysError;
// 현재 위치
  @override
  final double? currentLatitude;
  @override
  final double? currentLongitude;
// 선택된 지역 코드
  @override
  final String? selectedAreaCode;
  @override
  final String? selectedSigunguCode;
// 검색 키워드
  @override
  final String? searchKeyword;
// 로딩 상태
  @override
  @JsonKey()
  final bool isInitializing;
// 마지막 업데이트 시간
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'KTourState(popularAttractions: $popularAttractions, isLoadingPopular: $isLoadingPopular, popularError: $popularError, ongoingFestivals: $ongoingFestivals, isLoadingFestivals: $isLoadingFestivals, festivalsError: $festivalsError, nearbyAttractions: $nearbyAttractions, isLoadingNearby: $isLoadingNearby, nearbyError: $nearbyError, recommendedStays: $recommendedStays, isLoadingStays: $isLoadingStays, staysError: $staysError, currentLatitude: $currentLatitude, currentLongitude: $currentLongitude, selectedAreaCode: $selectedAreaCode, selectedSigunguCode: $selectedSigunguCode, searchKeyword: $searchKeyword, isInitializing: $isInitializing, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KTourStateImpl &&
            const DeepCollectionEquality()
                .equals(other._popularAttractions, _popularAttractions) &&
            (identical(other.isLoadingPopular, isLoadingPopular) ||
                other.isLoadingPopular == isLoadingPopular) &&
            (identical(other.popularError, popularError) ||
                other.popularError == popularError) &&
            const DeepCollectionEquality()
                .equals(other._ongoingFestivals, _ongoingFestivals) &&
            (identical(other.isLoadingFestivals, isLoadingFestivals) ||
                other.isLoadingFestivals == isLoadingFestivals) &&
            (identical(other.festivalsError, festivalsError) ||
                other.festivalsError == festivalsError) &&
            const DeepCollectionEquality()
                .equals(other._nearbyAttractions, _nearbyAttractions) &&
            (identical(other.isLoadingNearby, isLoadingNearby) ||
                other.isLoadingNearby == isLoadingNearby) &&
            (identical(other.nearbyError, nearbyError) ||
                other.nearbyError == nearbyError) &&
            const DeepCollectionEquality()
                .equals(other._recommendedStays, _recommendedStays) &&
            (identical(other.isLoadingStays, isLoadingStays) ||
                other.isLoadingStays == isLoadingStays) &&
            (identical(other.staysError, staysError) ||
                other.staysError == staysError) &&
            (identical(other.currentLatitude, currentLatitude) ||
                other.currentLatitude == currentLatitude) &&
            (identical(other.currentLongitude, currentLongitude) ||
                other.currentLongitude == currentLongitude) &&
            (identical(other.selectedAreaCode, selectedAreaCode) ||
                other.selectedAreaCode == selectedAreaCode) &&
            (identical(other.selectedSigunguCode, selectedSigunguCode) ||
                other.selectedSigunguCode == selectedSigunguCode) &&
            (identical(other.searchKeyword, searchKeyword) ||
                other.searchKeyword == searchKeyword) &&
            (identical(other.isInitializing, isInitializing) ||
                other.isInitializing == isInitializing) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(_popularAttractions),
        isLoadingPopular,
        popularError,
        const DeepCollectionEquality().hash(_ongoingFestivals),
        isLoadingFestivals,
        festivalsError,
        const DeepCollectionEquality().hash(_nearbyAttractions),
        isLoadingNearby,
        nearbyError,
        const DeepCollectionEquality().hash(_recommendedStays),
        isLoadingStays,
        staysError,
        currentLatitude,
        currentLongitude,
        selectedAreaCode,
        selectedSigunguCode,
        searchKeyword,
        isInitializing,
        lastUpdated
      ]);

  /// Create a copy of KTourState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KTourStateImplCopyWith<_$KTourStateImpl> get copyWith =>
      __$$KTourStateImplCopyWithImpl<_$KTourStateImpl>(this, _$identity);
}

abstract class _KTourState extends KTourState {
  const factory _KTourState(
      {final List<TourAttraction> popularAttractions,
      final bool isLoadingPopular,
      final String? popularError,
      final List<TourFestival> ongoingFestivals,
      final bool isLoadingFestivals,
      final String? festivalsError,
      final List<TourAttraction> nearbyAttractions,
      final bool isLoadingNearby,
      final String? nearbyError,
      final List<TourStay> recommendedStays,
      final bool isLoadingStays,
      final String? staysError,
      final double? currentLatitude,
      final double? currentLongitude,
      final String? selectedAreaCode,
      final String? selectedSigunguCode,
      final String? searchKeyword,
      final bool isInitializing,
      final DateTime? lastUpdated}) = _$KTourStateImpl;
  const _KTourState._() : super._();

// 인기 관광지
  @override
  List<TourAttraction> get popularAttractions;
  @override
  bool get isLoadingPopular;
  @override
  String? get popularError; // 진행중인 축제
  @override
  List<TourFestival> get ongoingFestivals;
  @override
  bool get isLoadingFestivals;
  @override
  String? get festivalsError; // 내 주변 관광지
  @override
  List<TourAttraction> get nearbyAttractions;
  @override
  bool get isLoadingNearby;
  @override
  String? get nearbyError; // 추천 숙박
  @override
  List<TourStay> get recommendedStays;
  @override
  bool get isLoadingStays;
  @override
  String? get staysError; // 현재 위치
  @override
  double? get currentLatitude;
  @override
  double? get currentLongitude; // 선택된 지역 코드
  @override
  String? get selectedAreaCode;
  @override
  String? get selectedSigunguCode; // 검색 키워드
  @override
  String? get searchKeyword; // 로딩 상태
  @override
  bool get isInitializing; // 마지막 업데이트 시간
  @override
  DateTime? get lastUpdated;

  /// Create a copy of KTourState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KTourStateImplCopyWith<_$KTourStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
