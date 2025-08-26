// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tour_explore_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TourExploreState {
// 필터 모드
  FilterMode get filterMode => throw _privateConstructorUsedError; // 지역별 필터
  List<String> get selectedAreaCodes => throw _privateConstructorUsedError;
  List<String> get selectedSigunguCodes => throw _privateConstructorUsedError;
  List<AreaCode> get areaCodes => throw _privateConstructorUsedError;
  Map<String, List<AreaCode>> get sigunguCodes =>
      throw _privateConstructorUsedError; // areaCode별 시군구 목록
// 테마별 필터
  List<int> get selectedThemes => throw _privateConstructorUsedError; // 내 주변 필터
  int get radius => throw _privateConstructorUsedError; // 미터 단위
  double? get currentLatitude => throw _privateConstructorUsedError;
  double? get currentLongitude => throw _privateConstructorUsedError; // 검색
  String get searchKeyword => throw _privateConstructorUsedError; // 정렬
  SortType get sortType => throw _privateConstructorUsedError; // 결과
  List<TourAttraction> get attractions => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError; // 페이지네이션
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError; // 로딩 상태
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError; // 위치 정보
  bool get hasLocation => throw _privateConstructorUsedError;
  bool get isRequestingLocation => throw _privateConstructorUsedError;

  /// Create a copy of TourExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TourExploreStateCopyWith<TourExploreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TourExploreStateCopyWith<$Res> {
  factory $TourExploreStateCopyWith(
          TourExploreState value, $Res Function(TourExploreState) then) =
      _$TourExploreStateCopyWithImpl<$Res, TourExploreState>;
  @useResult
  $Res call(
      {FilterMode filterMode,
      List<String> selectedAreaCodes,
      List<String> selectedSigunguCodes,
      List<AreaCode> areaCodes,
      Map<String, List<AreaCode>> sigunguCodes,
      List<int> selectedThemes,
      int radius,
      double? currentLatitude,
      double? currentLongitude,
      String searchKeyword,
      SortType sortType,
      List<TourAttraction> attractions,
      int totalCount,
      int currentPage,
      int pageSize,
      bool hasMore,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      bool hasLocation,
      bool isRequestingLocation});
}

/// @nodoc
class _$TourExploreStateCopyWithImpl<$Res, $Val extends TourExploreState>
    implements $TourExploreStateCopyWith<$Res> {
  _$TourExploreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TourExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterMode = null,
    Object? selectedAreaCodes = null,
    Object? selectedSigunguCodes = null,
    Object? areaCodes = null,
    Object? sigunguCodes = null,
    Object? selectedThemes = null,
    Object? radius = null,
    Object? currentLatitude = freezed,
    Object? currentLongitude = freezed,
    Object? searchKeyword = null,
    Object? sortType = null,
    Object? attractions = null,
    Object? totalCount = null,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasMore = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
    Object? hasLocation = null,
    Object? isRequestingLocation = null,
  }) {
    return _then(_value.copyWith(
      filterMode: null == filterMode
          ? _value.filterMode
          : filterMode // ignore: cast_nullable_to_non_nullable
              as FilterMode,
      selectedAreaCodes: null == selectedAreaCodes
          ? _value.selectedAreaCodes
          : selectedAreaCodes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedSigunguCodes: null == selectedSigunguCodes
          ? _value.selectedSigunguCodes
          : selectedSigunguCodes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      areaCodes: null == areaCodes
          ? _value.areaCodes
          : areaCodes // ignore: cast_nullable_to_non_nullable
              as List<AreaCode>,
      sigunguCodes: null == sigunguCodes
          ? _value.sigunguCodes
          : sigunguCodes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<AreaCode>>,
      selectedThemes: null == selectedThemes
          ? _value.selectedThemes
          : selectedThemes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int,
      currentLatitude: freezed == currentLatitude
          ? _value.currentLatitude
          : currentLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLongitude: freezed == currentLongitude
          ? _value.currentLongitude
          : currentLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      searchKeyword: null == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as SortType,
      attractions: null == attractions
          ? _value.attractions
          : attractions // ignore: cast_nullable_to_non_nullable
              as List<TourAttraction>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      hasLocation: null == hasLocation
          ? _value.hasLocation
          : hasLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      isRequestingLocation: null == isRequestingLocation
          ? _value.isRequestingLocation
          : isRequestingLocation // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TourExploreStateImplCopyWith<$Res>
    implements $TourExploreStateCopyWith<$Res> {
  factory _$$TourExploreStateImplCopyWith(_$TourExploreStateImpl value,
          $Res Function(_$TourExploreStateImpl) then) =
      __$$TourExploreStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FilterMode filterMode,
      List<String> selectedAreaCodes,
      List<String> selectedSigunguCodes,
      List<AreaCode> areaCodes,
      Map<String, List<AreaCode>> sigunguCodes,
      List<int> selectedThemes,
      int radius,
      double? currentLatitude,
      double? currentLongitude,
      String searchKeyword,
      SortType sortType,
      List<TourAttraction> attractions,
      int totalCount,
      int currentPage,
      int pageSize,
      bool hasMore,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      bool hasLocation,
      bool isRequestingLocation});
}

/// @nodoc
class __$$TourExploreStateImplCopyWithImpl<$Res>
    extends _$TourExploreStateCopyWithImpl<$Res, _$TourExploreStateImpl>
    implements _$$TourExploreStateImplCopyWith<$Res> {
  __$$TourExploreStateImplCopyWithImpl(_$TourExploreStateImpl _value,
      $Res Function(_$TourExploreStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TourExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filterMode = null,
    Object? selectedAreaCodes = null,
    Object? selectedSigunguCodes = null,
    Object? areaCodes = null,
    Object? sigunguCodes = null,
    Object? selectedThemes = null,
    Object? radius = null,
    Object? currentLatitude = freezed,
    Object? currentLongitude = freezed,
    Object? searchKeyword = null,
    Object? sortType = null,
    Object? attractions = null,
    Object? totalCount = null,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasMore = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
    Object? hasLocation = null,
    Object? isRequestingLocation = null,
  }) {
    return _then(_$TourExploreStateImpl(
      filterMode: null == filterMode
          ? _value.filterMode
          : filterMode // ignore: cast_nullable_to_non_nullable
              as FilterMode,
      selectedAreaCodes: null == selectedAreaCodes
          ? _value._selectedAreaCodes
          : selectedAreaCodes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedSigunguCodes: null == selectedSigunguCodes
          ? _value._selectedSigunguCodes
          : selectedSigunguCodes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      areaCodes: null == areaCodes
          ? _value._areaCodes
          : areaCodes // ignore: cast_nullable_to_non_nullable
              as List<AreaCode>,
      sigunguCodes: null == sigunguCodes
          ? _value._sigunguCodes
          : sigunguCodes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<AreaCode>>,
      selectedThemes: null == selectedThemes
          ? _value._selectedThemes
          : selectedThemes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int,
      currentLatitude: freezed == currentLatitude
          ? _value.currentLatitude
          : currentLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLongitude: freezed == currentLongitude
          ? _value.currentLongitude
          : currentLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      searchKeyword: null == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as SortType,
      attractions: null == attractions
          ? _value._attractions
          : attractions // ignore: cast_nullable_to_non_nullable
              as List<TourAttraction>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      hasLocation: null == hasLocation
          ? _value.hasLocation
          : hasLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      isRequestingLocation: null == isRequestingLocation
          ? _value.isRequestingLocation
          : isRequestingLocation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TourExploreStateImpl extends _TourExploreState {
  const _$TourExploreStateImpl(
      {this.filterMode = FilterMode.area,
      final List<String> selectedAreaCodes = const [],
      final List<String> selectedSigunguCodes = const [],
      final List<AreaCode> areaCodes = const [],
      final Map<String, List<AreaCode>> sigunguCodes = const {},
      final List<int> selectedThemes = const [],
      this.radius = 5000,
      this.currentLatitude,
      this.currentLongitude,
      this.searchKeyword = '',
      this.sortType = SortType.title,
      final List<TourAttraction> attractions = const [],
      this.totalCount = 0,
      this.currentPage = 1,
      this.pageSize = 20,
      this.hasMore = true,
      this.isLoading = false,
      this.isLoadingMore = false,
      this.error,
      this.hasLocation = false,
      this.isRequestingLocation = false})
      : _selectedAreaCodes = selectedAreaCodes,
        _selectedSigunguCodes = selectedSigunguCodes,
        _areaCodes = areaCodes,
        _sigunguCodes = sigunguCodes,
        _selectedThemes = selectedThemes,
        _attractions = attractions,
        super._();

// 필터 모드
  @override
  @JsonKey()
  final FilterMode filterMode;
// 지역별 필터
  final List<String> _selectedAreaCodes;
// 지역별 필터
  @override
  @JsonKey()
  List<String> get selectedAreaCodes {
    if (_selectedAreaCodes is EqualUnmodifiableListView)
      return _selectedAreaCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedAreaCodes);
  }

  final List<String> _selectedSigunguCodes;
  @override
  @JsonKey()
  List<String> get selectedSigunguCodes {
    if (_selectedSigunguCodes is EqualUnmodifiableListView)
      return _selectedSigunguCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedSigunguCodes);
  }

  final List<AreaCode> _areaCodes;
  @override
  @JsonKey()
  List<AreaCode> get areaCodes {
    if (_areaCodes is EqualUnmodifiableListView) return _areaCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areaCodes);
  }

  final Map<String, List<AreaCode>> _sigunguCodes;
  @override
  @JsonKey()
  Map<String, List<AreaCode>> get sigunguCodes {
    if (_sigunguCodes is EqualUnmodifiableMapView) return _sigunguCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sigunguCodes);
  }

// areaCode별 시군구 목록
// 테마별 필터
  final List<int> _selectedThemes;
// areaCode별 시군구 목록
// 테마별 필터
  @override
  @JsonKey()
  List<int> get selectedThemes {
    if (_selectedThemes is EqualUnmodifiableListView) return _selectedThemes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedThemes);
  }

// 내 주변 필터
  @override
  @JsonKey()
  final int radius;
// 미터 단위
  @override
  final double? currentLatitude;
  @override
  final double? currentLongitude;
// 검색
  @override
  @JsonKey()
  final String searchKeyword;
// 정렬
  @override
  @JsonKey()
  final SortType sortType;
// 결과
  final List<TourAttraction> _attractions;
// 결과
  @override
  @JsonKey()
  List<TourAttraction> get attractions {
    if (_attractions is EqualUnmodifiableListView) return _attractions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attractions);
  }

  @override
  @JsonKey()
  final int totalCount;
// 페이지네이션
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final bool hasMore;
// 로딩 상태
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? error;
// 위치 정보
  @override
  @JsonKey()
  final bool hasLocation;
  @override
  @JsonKey()
  final bool isRequestingLocation;

  @override
  String toString() {
    return 'TourExploreState(filterMode: $filterMode, selectedAreaCodes: $selectedAreaCodes, selectedSigunguCodes: $selectedSigunguCodes, areaCodes: $areaCodes, sigunguCodes: $sigunguCodes, selectedThemes: $selectedThemes, radius: $radius, currentLatitude: $currentLatitude, currentLongitude: $currentLongitude, searchKeyword: $searchKeyword, sortType: $sortType, attractions: $attractions, totalCount: $totalCount, currentPage: $currentPage, pageSize: $pageSize, hasMore: $hasMore, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error, hasLocation: $hasLocation, isRequestingLocation: $isRequestingLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TourExploreStateImpl &&
            (identical(other.filterMode, filterMode) ||
                other.filterMode == filterMode) &&
            const DeepCollectionEquality()
                .equals(other._selectedAreaCodes, _selectedAreaCodes) &&
            const DeepCollectionEquality()
                .equals(other._selectedSigunguCodes, _selectedSigunguCodes) &&
            const DeepCollectionEquality()
                .equals(other._areaCodes, _areaCodes) &&
            const DeepCollectionEquality()
                .equals(other._sigunguCodes, _sigunguCodes) &&
            const DeepCollectionEquality()
                .equals(other._selectedThemes, _selectedThemes) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.currentLatitude, currentLatitude) ||
                other.currentLatitude == currentLatitude) &&
            (identical(other.currentLongitude, currentLongitude) ||
                other.currentLongitude == currentLongitude) &&
            (identical(other.searchKeyword, searchKeyword) ||
                other.searchKeyword == searchKeyword) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            const DeepCollectionEquality()
                .equals(other._attractions, _attractions) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.hasLocation, hasLocation) ||
                other.hasLocation == hasLocation) &&
            (identical(other.isRequestingLocation, isRequestingLocation) ||
                other.isRequestingLocation == isRequestingLocation));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        filterMode,
        const DeepCollectionEquality().hash(_selectedAreaCodes),
        const DeepCollectionEquality().hash(_selectedSigunguCodes),
        const DeepCollectionEquality().hash(_areaCodes),
        const DeepCollectionEquality().hash(_sigunguCodes),
        const DeepCollectionEquality().hash(_selectedThemes),
        radius,
        currentLatitude,
        currentLongitude,
        searchKeyword,
        sortType,
        const DeepCollectionEquality().hash(_attractions),
        totalCount,
        currentPage,
        pageSize,
        hasMore,
        isLoading,
        isLoadingMore,
        error,
        hasLocation,
        isRequestingLocation
      ]);

  /// Create a copy of TourExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TourExploreStateImplCopyWith<_$TourExploreStateImpl> get copyWith =>
      __$$TourExploreStateImplCopyWithImpl<_$TourExploreStateImpl>(
          this, _$identity);
}

abstract class _TourExploreState extends TourExploreState {
  const factory _TourExploreState(
      {final FilterMode filterMode,
      final List<String> selectedAreaCodes,
      final List<String> selectedSigunguCodes,
      final List<AreaCode> areaCodes,
      final Map<String, List<AreaCode>> sigunguCodes,
      final List<int> selectedThemes,
      final int radius,
      final double? currentLatitude,
      final double? currentLongitude,
      final String searchKeyword,
      final SortType sortType,
      final List<TourAttraction> attractions,
      final int totalCount,
      final int currentPage,
      final int pageSize,
      final bool hasMore,
      final bool isLoading,
      final bool isLoadingMore,
      final String? error,
      final bool hasLocation,
      final bool isRequestingLocation}) = _$TourExploreStateImpl;
  const _TourExploreState._() : super._();

// 필터 모드
  @override
  FilterMode get filterMode; // 지역별 필터
  @override
  List<String> get selectedAreaCodes;
  @override
  List<String> get selectedSigunguCodes;
  @override
  List<AreaCode> get areaCodes;
  @override
  Map<String, List<AreaCode>> get sigunguCodes; // areaCode별 시군구 목록
// 테마별 필터
  @override
  List<int> get selectedThemes; // 내 주변 필터
  @override
  int get radius; // 미터 단위
  @override
  double? get currentLatitude;
  @override
  double? get currentLongitude; // 검색
  @override
  String get searchKeyword; // 정렬
  @override
  SortType get sortType; // 결과
  @override
  List<TourAttraction> get attractions;
  @override
  int get totalCount; // 페이지네이션
  @override
  int get currentPage;
  @override
  int get pageSize;
  @override
  bool get hasMore; // 로딩 상태
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  String? get error; // 위치 정보
  @override
  bool get hasLocation;
  @override
  bool get isRequestingLocation;

  /// Create a copy of TourExploreState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TourExploreStateImplCopyWith<_$TourExploreStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
