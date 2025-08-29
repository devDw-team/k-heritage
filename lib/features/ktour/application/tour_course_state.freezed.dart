// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tour_course_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TourCourseState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  List<TourCourse> get courses => throw _privateConstructorUsedError;
  List<TourCourse> get filteredCourses => throw _privateConstructorUsedError;
  List<TourCourse> get recommendedCourses => throw _privateConstructorUsedError;
  List<TourCourse> get myCourses => throw _privateConstructorUsedError;
  TourCourse? get selectedCourse => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError; // 필터 상태
  String? get selectedAreaCode => throw _privateConstructorUsedError;
  String? get selectedSigunguCode => throw _privateConstructorUsedError;
  String? get selectedTheme => throw _privateConstructorUsedError;
  String? get selectedDifficulty => throw _privateConstructorUsedError;
  int? get minDuration => throw _privateConstructorUsedError;
  int? get maxDuration => throw _privateConstructorUsedError; // 정렬 옵션
  String get sortBy => throw _privateConstructorUsedError;

  /// Create a copy of TourCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TourCourseStateCopyWith<TourCourseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TourCourseStateCopyWith<$Res> {
  factory $TourCourseStateCopyWith(
          TourCourseState value, $Res Function(TourCourseState) then) =
      _$TourCourseStateCopyWithImpl<$Res, TourCourseState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingMore,
      List<TourCourse> courses,
      List<TourCourse> filteredCourses,
      List<TourCourse> recommendedCourses,
      List<TourCourse> myCourses,
      TourCourse? selectedCourse,
      String? error,
      int currentPage,
      bool hasMore,
      String? selectedAreaCode,
      String? selectedSigunguCode,
      String? selectedTheme,
      String? selectedDifficulty,
      int? minDuration,
      int? maxDuration,
      String sortBy});

  $TourCourseCopyWith<$Res>? get selectedCourse;
}

/// @nodoc
class _$TourCourseStateCopyWithImpl<$Res, $Val extends TourCourseState>
    implements $TourCourseStateCopyWith<$Res> {
  _$TourCourseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TourCourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? courses = null,
    Object? filteredCourses = null,
    Object? recommendedCourses = null,
    Object? myCourses = null,
    Object? selectedCourse = freezed,
    Object? error = freezed,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? selectedAreaCode = freezed,
    Object? selectedSigunguCode = freezed,
    Object? selectedTheme = freezed,
    Object? selectedDifficulty = freezed,
    Object? minDuration = freezed,
    Object? maxDuration = freezed,
    Object? sortBy = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      courses: null == courses
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<TourCourse>,
      filteredCourses: null == filteredCourses
          ? _value.filteredCourses
          : filteredCourses // ignore: cast_nullable_to_non_nullable
              as List<TourCourse>,
      recommendedCourses: null == recommendedCourses
          ? _value.recommendedCourses
          : recommendedCourses // ignore: cast_nullable_to_non_nullable
              as List<TourCourse>,
      myCourses: null == myCourses
          ? _value.myCourses
          : myCourses // ignore: cast_nullable_to_non_nullable
              as List<TourCourse>,
      selectedCourse: freezed == selectedCourse
          ? _value.selectedCourse
          : selectedCourse // ignore: cast_nullable_to_non_nullable
              as TourCourse?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedAreaCode: freezed == selectedAreaCode
          ? _value.selectedAreaCode
          : selectedAreaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSigunguCode: freezed == selectedSigunguCode
          ? _value.selectedSigunguCode
          : selectedSigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTheme: freezed == selectedTheme
          ? _value.selectedTheme
          : selectedTheme // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedDifficulty: freezed == selectedDifficulty
          ? _value.selectedDifficulty
          : selectedDifficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      minDuration: freezed == minDuration
          ? _value.minDuration
          : minDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      maxDuration: freezed == maxDuration
          ? _value.maxDuration
          : maxDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TourCourseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TourCourseCopyWith<$Res>? get selectedCourse {
    if (_value.selectedCourse == null) {
      return null;
    }

    return $TourCourseCopyWith<$Res>(_value.selectedCourse!, (value) {
      return _then(_value.copyWith(selectedCourse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TourCourseStateImplCopyWith<$Res>
    implements $TourCourseStateCopyWith<$Res> {
  factory _$$TourCourseStateImplCopyWith(_$TourCourseStateImpl value,
          $Res Function(_$TourCourseStateImpl) then) =
      __$$TourCourseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingMore,
      List<TourCourse> courses,
      List<TourCourse> filteredCourses,
      List<TourCourse> recommendedCourses,
      List<TourCourse> myCourses,
      TourCourse? selectedCourse,
      String? error,
      int currentPage,
      bool hasMore,
      String? selectedAreaCode,
      String? selectedSigunguCode,
      String? selectedTheme,
      String? selectedDifficulty,
      int? minDuration,
      int? maxDuration,
      String sortBy});

  @override
  $TourCourseCopyWith<$Res>? get selectedCourse;
}

/// @nodoc
class __$$TourCourseStateImplCopyWithImpl<$Res>
    extends _$TourCourseStateCopyWithImpl<$Res, _$TourCourseStateImpl>
    implements _$$TourCourseStateImplCopyWith<$Res> {
  __$$TourCourseStateImplCopyWithImpl(
      _$TourCourseStateImpl _value, $Res Function(_$TourCourseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TourCourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? courses = null,
    Object? filteredCourses = null,
    Object? recommendedCourses = null,
    Object? myCourses = null,
    Object? selectedCourse = freezed,
    Object? error = freezed,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? selectedAreaCode = freezed,
    Object? selectedSigunguCode = freezed,
    Object? selectedTheme = freezed,
    Object? selectedDifficulty = freezed,
    Object? minDuration = freezed,
    Object? maxDuration = freezed,
    Object? sortBy = null,
  }) {
    return _then(_$TourCourseStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      courses: null == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<TourCourse>,
      filteredCourses: null == filteredCourses
          ? _value._filteredCourses
          : filteredCourses // ignore: cast_nullable_to_non_nullable
              as List<TourCourse>,
      recommendedCourses: null == recommendedCourses
          ? _value._recommendedCourses
          : recommendedCourses // ignore: cast_nullable_to_non_nullable
              as List<TourCourse>,
      myCourses: null == myCourses
          ? _value._myCourses
          : myCourses // ignore: cast_nullable_to_non_nullable
              as List<TourCourse>,
      selectedCourse: freezed == selectedCourse
          ? _value.selectedCourse
          : selectedCourse // ignore: cast_nullable_to_non_nullable
              as TourCourse?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedAreaCode: freezed == selectedAreaCode
          ? _value.selectedAreaCode
          : selectedAreaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSigunguCode: freezed == selectedSigunguCode
          ? _value.selectedSigunguCode
          : selectedSigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTheme: freezed == selectedTheme
          ? _value.selectedTheme
          : selectedTheme // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedDifficulty: freezed == selectedDifficulty
          ? _value.selectedDifficulty
          : selectedDifficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      minDuration: freezed == minDuration
          ? _value.minDuration
          : minDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      maxDuration: freezed == maxDuration
          ? _value.maxDuration
          : maxDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TourCourseStateImpl implements _TourCourseState {
  const _$TourCourseStateImpl(
      {this.isLoading = false,
      this.isLoadingMore = false,
      final List<TourCourse> courses = const [],
      final List<TourCourse> filteredCourses = const [],
      final List<TourCourse> recommendedCourses = const [],
      final List<TourCourse> myCourses = const [],
      this.selectedCourse,
      this.error,
      this.currentPage = 1,
      this.hasMore = false,
      this.selectedAreaCode,
      this.selectedSigunguCode,
      this.selectedTheme,
      this.selectedDifficulty,
      this.minDuration,
      this.maxDuration,
      this.sortBy = 'P'})
      : _courses = courses,
        _filteredCourses = filteredCourses,
        _recommendedCourses = recommendedCourses,
        _myCourses = myCourses;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  final List<TourCourse> _courses;
  @override
  @JsonKey()
  List<TourCourse> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  final List<TourCourse> _filteredCourses;
  @override
  @JsonKey()
  List<TourCourse> get filteredCourses {
    if (_filteredCourses is EqualUnmodifiableListView) return _filteredCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredCourses);
  }

  final List<TourCourse> _recommendedCourses;
  @override
  @JsonKey()
  List<TourCourse> get recommendedCourses {
    if (_recommendedCourses is EqualUnmodifiableListView)
      return _recommendedCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedCourses);
  }

  final List<TourCourse> _myCourses;
  @override
  @JsonKey()
  List<TourCourse> get myCourses {
    if (_myCourses is EqualUnmodifiableListView) return _myCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myCourses);
  }

  @override
  final TourCourse? selectedCourse;
  @override
  final String? error;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;
// 필터 상태
  @override
  final String? selectedAreaCode;
  @override
  final String? selectedSigunguCode;
  @override
  final String? selectedTheme;
  @override
  final String? selectedDifficulty;
  @override
  final int? minDuration;
  @override
  final int? maxDuration;
// 정렬 옵션
  @override
  @JsonKey()
  final String sortBy;

  @override
  String toString() {
    return 'TourCourseState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, courses: $courses, filteredCourses: $filteredCourses, recommendedCourses: $recommendedCourses, myCourses: $myCourses, selectedCourse: $selectedCourse, error: $error, currentPage: $currentPage, hasMore: $hasMore, selectedAreaCode: $selectedAreaCode, selectedSigunguCode: $selectedSigunguCode, selectedTheme: $selectedTheme, selectedDifficulty: $selectedDifficulty, minDuration: $minDuration, maxDuration: $maxDuration, sortBy: $sortBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TourCourseStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality().equals(other._courses, _courses) &&
            const DeepCollectionEquality()
                .equals(other._filteredCourses, _filteredCourses) &&
            const DeepCollectionEquality()
                .equals(other._recommendedCourses, _recommendedCourses) &&
            const DeepCollectionEquality()
                .equals(other._myCourses, _myCourses) &&
            (identical(other.selectedCourse, selectedCourse) ||
                other.selectedCourse == selectedCourse) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.selectedAreaCode, selectedAreaCode) ||
                other.selectedAreaCode == selectedAreaCode) &&
            (identical(other.selectedSigunguCode, selectedSigunguCode) ||
                other.selectedSigunguCode == selectedSigunguCode) &&
            (identical(other.selectedTheme, selectedTheme) ||
                other.selectedTheme == selectedTheme) &&
            (identical(other.selectedDifficulty, selectedDifficulty) ||
                other.selectedDifficulty == selectedDifficulty) &&
            (identical(other.minDuration, minDuration) ||
                other.minDuration == minDuration) &&
            (identical(other.maxDuration, maxDuration) ||
                other.maxDuration == maxDuration) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isLoadingMore,
      const DeepCollectionEquality().hash(_courses),
      const DeepCollectionEquality().hash(_filteredCourses),
      const DeepCollectionEquality().hash(_recommendedCourses),
      const DeepCollectionEquality().hash(_myCourses),
      selectedCourse,
      error,
      currentPage,
      hasMore,
      selectedAreaCode,
      selectedSigunguCode,
      selectedTheme,
      selectedDifficulty,
      minDuration,
      maxDuration,
      sortBy);

  /// Create a copy of TourCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TourCourseStateImplCopyWith<_$TourCourseStateImpl> get copyWith =>
      __$$TourCourseStateImplCopyWithImpl<_$TourCourseStateImpl>(
          this, _$identity);
}

abstract class _TourCourseState implements TourCourseState {
  const factory _TourCourseState(
      {final bool isLoading,
      final bool isLoadingMore,
      final List<TourCourse> courses,
      final List<TourCourse> filteredCourses,
      final List<TourCourse> recommendedCourses,
      final List<TourCourse> myCourses,
      final TourCourse? selectedCourse,
      final String? error,
      final int currentPage,
      final bool hasMore,
      final String? selectedAreaCode,
      final String? selectedSigunguCode,
      final String? selectedTheme,
      final String? selectedDifficulty,
      final int? minDuration,
      final int? maxDuration,
      final String sortBy}) = _$TourCourseStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  List<TourCourse> get courses;
  @override
  List<TourCourse> get filteredCourses;
  @override
  List<TourCourse> get recommendedCourses;
  @override
  List<TourCourse> get myCourses;
  @override
  TourCourse? get selectedCourse;
  @override
  String? get error;
  @override
  int get currentPage;
  @override
  bool get hasMore; // 필터 상태
  @override
  String? get selectedAreaCode;
  @override
  String? get selectedSigunguCode;
  @override
  String? get selectedTheme;
  @override
  String? get selectedDifficulty;
  @override
  int? get minDuration;
  @override
  int? get maxDuration; // 정렬 옵션
  @override
  String get sortBy;

  /// Create a copy of TourCourseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TourCourseStateImplCopyWith<_$TourCourseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
