// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'festival_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FestivalState {
  /// 축제 목록
  List<TourFestival> get festivals => throw _privateConstructorUsedError;

  /// 전체 축제 목록 (필터링 전)
  List<TourFestival> get allFestivals => throw _privateConstructorUsedError;

  /// 로딩 상태
  bool get isLoading => throw _privateConstructorUsedError;

  /// 추가 데이터 로딩 중
  bool get isLoadingMore => throw _privateConstructorUsedError;

  /// 에러 메시지
  String? get error => throw _privateConstructorUsedError;

  /// 필터: 축제 상태
  FestivalStatus? get filterStatus => throw _privateConstructorUsedError;

  /// 필터: 지역 코드
  String? get filterAreaCode => throw _privateConstructorUsedError;

  /// 필터: 시군구 코드
  String? get filterSigunguCode => throw _privateConstructorUsedError;

  /// 필터: 선택된 월
  DateTime? get filterMonth => throw _privateConstructorUsedError;

  /// 검색 키워드
  String? get searchKeyword => throw _privateConstructorUsedError;

  /// 정렬 옵션 (R=시작일순, O=제목순)
  String get sortBy => throw _privateConstructorUsedError;

  /// 현재 페이지
  int get currentPage => throw _privateConstructorUsedError;

  /// 더 많은 데이터 존재 여부
  bool get hasMore => throw _privateConstructorUsedError;

  /// 보기 모드 (list, calendar, map)
  String get viewMode => throw _privateConstructorUsedError;

  /// 선택된 날짜 (캘린더 뷰용)
  DateTime? get selectedDate => throw _privateConstructorUsedError;

  /// 북마크된 축제 ID 목록
  List<String> get bookmarkedIds => throw _privateConstructorUsedError;

  /// Create a copy of FestivalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FestivalStateCopyWith<FestivalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FestivalStateCopyWith<$Res> {
  factory $FestivalStateCopyWith(
          FestivalState value, $Res Function(FestivalState) then) =
      _$FestivalStateCopyWithImpl<$Res, FestivalState>;
  @useResult
  $Res call(
      {List<TourFestival> festivals,
      List<TourFestival> allFestivals,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      FestivalStatus? filterStatus,
      String? filterAreaCode,
      String? filterSigunguCode,
      DateTime? filterMonth,
      String? searchKeyword,
      String sortBy,
      int currentPage,
      bool hasMore,
      String viewMode,
      DateTime? selectedDate,
      List<String> bookmarkedIds});
}

/// @nodoc
class _$FestivalStateCopyWithImpl<$Res, $Val extends FestivalState>
    implements $FestivalStateCopyWith<$Res> {
  _$FestivalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FestivalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? festivals = null,
    Object? allFestivals = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
    Object? filterStatus = freezed,
    Object? filterAreaCode = freezed,
    Object? filterSigunguCode = freezed,
    Object? filterMonth = freezed,
    Object? searchKeyword = freezed,
    Object? sortBy = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? viewMode = null,
    Object? selectedDate = freezed,
    Object? bookmarkedIds = null,
  }) {
    return _then(_value.copyWith(
      festivals: null == festivals
          ? _value.festivals
          : festivals // ignore: cast_nullable_to_non_nullable
              as List<TourFestival>,
      allFestivals: null == allFestivals
          ? _value.allFestivals
          : allFestivals // ignore: cast_nullable_to_non_nullable
              as List<TourFestival>,
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
      filterStatus: freezed == filterStatus
          ? _value.filterStatus
          : filterStatus // ignore: cast_nullable_to_non_nullable
              as FestivalStatus?,
      filterAreaCode: freezed == filterAreaCode
          ? _value.filterAreaCode
          : filterAreaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      filterSigunguCode: freezed == filterSigunguCode
          ? _value.filterSigunguCode
          : filterSigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      filterMonth: freezed == filterMonth
          ? _value.filterMonth
          : filterMonth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      searchKeyword: freezed == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      viewMode: null == viewMode
          ? _value.viewMode
          : viewMode // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bookmarkedIds: null == bookmarkedIds
          ? _value.bookmarkedIds
          : bookmarkedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FestivalStateImplCopyWith<$Res>
    implements $FestivalStateCopyWith<$Res> {
  factory _$$FestivalStateImplCopyWith(
          _$FestivalStateImpl value, $Res Function(_$FestivalStateImpl) then) =
      __$$FestivalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TourFestival> festivals,
      List<TourFestival> allFestivals,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      FestivalStatus? filterStatus,
      String? filterAreaCode,
      String? filterSigunguCode,
      DateTime? filterMonth,
      String? searchKeyword,
      String sortBy,
      int currentPage,
      bool hasMore,
      String viewMode,
      DateTime? selectedDate,
      List<String> bookmarkedIds});
}

/// @nodoc
class __$$FestivalStateImplCopyWithImpl<$Res>
    extends _$FestivalStateCopyWithImpl<$Res, _$FestivalStateImpl>
    implements _$$FestivalStateImplCopyWith<$Res> {
  __$$FestivalStateImplCopyWithImpl(
      _$FestivalStateImpl _value, $Res Function(_$FestivalStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FestivalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? festivals = null,
    Object? allFestivals = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
    Object? filterStatus = freezed,
    Object? filterAreaCode = freezed,
    Object? filterSigunguCode = freezed,
    Object? filterMonth = freezed,
    Object? searchKeyword = freezed,
    Object? sortBy = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? viewMode = null,
    Object? selectedDate = freezed,
    Object? bookmarkedIds = null,
  }) {
    return _then(_$FestivalStateImpl(
      festivals: null == festivals
          ? _value._festivals
          : festivals // ignore: cast_nullable_to_non_nullable
              as List<TourFestival>,
      allFestivals: null == allFestivals
          ? _value._allFestivals
          : allFestivals // ignore: cast_nullable_to_non_nullable
              as List<TourFestival>,
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
      filterStatus: freezed == filterStatus
          ? _value.filterStatus
          : filterStatus // ignore: cast_nullable_to_non_nullable
              as FestivalStatus?,
      filterAreaCode: freezed == filterAreaCode
          ? _value.filterAreaCode
          : filterAreaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      filterSigunguCode: freezed == filterSigunguCode
          ? _value.filterSigunguCode
          : filterSigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      filterMonth: freezed == filterMonth
          ? _value.filterMonth
          : filterMonth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      searchKeyword: freezed == searchKeyword
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      viewMode: null == viewMode
          ? _value.viewMode
          : viewMode // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bookmarkedIds: null == bookmarkedIds
          ? _value._bookmarkedIds
          : bookmarkedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$FestivalStateImpl extends _FestivalState {
  const _$FestivalStateImpl(
      {final List<TourFestival> festivals = const [],
      final List<TourFestival> allFestivals = const [],
      this.isLoading = true,
      this.isLoadingMore = false,
      this.error,
      this.filterStatus,
      this.filterAreaCode,
      this.filterSigunguCode,
      this.filterMonth,
      this.searchKeyword,
      this.sortBy = 'R',
      this.currentPage = 1,
      this.hasMore = false,
      this.viewMode = 'list',
      this.selectedDate,
      final List<String> bookmarkedIds = const []})
      : _festivals = festivals,
        _allFestivals = allFestivals,
        _bookmarkedIds = bookmarkedIds,
        super._();

  /// 축제 목록
  final List<TourFestival> _festivals;

  /// 축제 목록
  @override
  @JsonKey()
  List<TourFestival> get festivals {
    if (_festivals is EqualUnmodifiableListView) return _festivals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_festivals);
  }

  /// 전체 축제 목록 (필터링 전)
  final List<TourFestival> _allFestivals;

  /// 전체 축제 목록 (필터링 전)
  @override
  @JsonKey()
  List<TourFestival> get allFestivals {
    if (_allFestivals is EqualUnmodifiableListView) return _allFestivals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allFestivals);
  }

  /// 로딩 상태
  @override
  @JsonKey()
  final bool isLoading;

  /// 추가 데이터 로딩 중
  @override
  @JsonKey()
  final bool isLoadingMore;

  /// 에러 메시지
  @override
  final String? error;

  /// 필터: 축제 상태
  @override
  final FestivalStatus? filterStatus;

  /// 필터: 지역 코드
  @override
  final String? filterAreaCode;

  /// 필터: 시군구 코드
  @override
  final String? filterSigunguCode;

  /// 필터: 선택된 월
  @override
  final DateTime? filterMonth;

  /// 검색 키워드
  @override
  final String? searchKeyword;

  /// 정렬 옵션 (R=시작일순, O=제목순)
  @override
  @JsonKey()
  final String sortBy;

  /// 현재 페이지
  @override
  @JsonKey()
  final int currentPage;

  /// 더 많은 데이터 존재 여부
  @override
  @JsonKey()
  final bool hasMore;

  /// 보기 모드 (list, calendar, map)
  @override
  @JsonKey()
  final String viewMode;

  /// 선택된 날짜 (캘린더 뷰용)
  @override
  final DateTime? selectedDate;

  /// 북마크된 축제 ID 목록
  final List<String> _bookmarkedIds;

  /// 북마크된 축제 ID 목록
  @override
  @JsonKey()
  List<String> get bookmarkedIds {
    if (_bookmarkedIds is EqualUnmodifiableListView) return _bookmarkedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarkedIds);
  }

  @override
  String toString() {
    return 'FestivalState(festivals: $festivals, allFestivals: $allFestivals, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error, filterStatus: $filterStatus, filterAreaCode: $filterAreaCode, filterSigunguCode: $filterSigunguCode, filterMonth: $filterMonth, searchKeyword: $searchKeyword, sortBy: $sortBy, currentPage: $currentPage, hasMore: $hasMore, viewMode: $viewMode, selectedDate: $selectedDate, bookmarkedIds: $bookmarkedIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FestivalStateImpl &&
            const DeepCollectionEquality()
                .equals(other._festivals, _festivals) &&
            const DeepCollectionEquality()
                .equals(other._allFestivals, _allFestivals) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.filterStatus, filterStatus) ||
                other.filterStatus == filterStatus) &&
            (identical(other.filterAreaCode, filterAreaCode) ||
                other.filterAreaCode == filterAreaCode) &&
            (identical(other.filterSigunguCode, filterSigunguCode) ||
                other.filterSigunguCode == filterSigunguCode) &&
            (identical(other.filterMonth, filterMonth) ||
                other.filterMonth == filterMonth) &&
            (identical(other.searchKeyword, searchKeyword) ||
                other.searchKeyword == searchKeyword) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.viewMode, viewMode) ||
                other.viewMode == viewMode) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality()
                .equals(other._bookmarkedIds, _bookmarkedIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_festivals),
      const DeepCollectionEquality().hash(_allFestivals),
      isLoading,
      isLoadingMore,
      error,
      filterStatus,
      filterAreaCode,
      filterSigunguCode,
      filterMonth,
      searchKeyword,
      sortBy,
      currentPage,
      hasMore,
      viewMode,
      selectedDate,
      const DeepCollectionEquality().hash(_bookmarkedIds));

  /// Create a copy of FestivalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FestivalStateImplCopyWith<_$FestivalStateImpl> get copyWith =>
      __$$FestivalStateImplCopyWithImpl<_$FestivalStateImpl>(this, _$identity);
}

abstract class _FestivalState extends FestivalState {
  const factory _FestivalState(
      {final List<TourFestival> festivals,
      final List<TourFestival> allFestivals,
      final bool isLoading,
      final bool isLoadingMore,
      final String? error,
      final FestivalStatus? filterStatus,
      final String? filterAreaCode,
      final String? filterSigunguCode,
      final DateTime? filterMonth,
      final String? searchKeyword,
      final String sortBy,
      final int currentPage,
      final bool hasMore,
      final String viewMode,
      final DateTime? selectedDate,
      final List<String> bookmarkedIds}) = _$FestivalStateImpl;
  const _FestivalState._() : super._();

  /// 축제 목록
  @override
  List<TourFestival> get festivals;

  /// 전체 축제 목록 (필터링 전)
  @override
  List<TourFestival> get allFestivals;

  /// 로딩 상태
  @override
  bool get isLoading;

  /// 추가 데이터 로딩 중
  @override
  bool get isLoadingMore;

  /// 에러 메시지
  @override
  String? get error;

  /// 필터: 축제 상태
  @override
  FestivalStatus? get filterStatus;

  /// 필터: 지역 코드
  @override
  String? get filterAreaCode;

  /// 필터: 시군구 코드
  @override
  String? get filterSigunguCode;

  /// 필터: 선택된 월
  @override
  DateTime? get filterMonth;

  /// 검색 키워드
  @override
  String? get searchKeyword;

  /// 정렬 옵션 (R=시작일순, O=제목순)
  @override
  String get sortBy;

  /// 현재 페이지
  @override
  int get currentPage;

  /// 더 많은 데이터 존재 여부
  @override
  bool get hasMore;

  /// 보기 모드 (list, calendar, map)
  @override
  String get viewMode;

  /// 선택된 날짜 (캘린더 뷰용)
  @override
  DateTime? get selectedDate;

  /// 북마크된 축제 ID 목록
  @override
  List<String> get bookmarkedIds;

  /// Create a copy of FestivalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FestivalStateImplCopyWith<_$FestivalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
