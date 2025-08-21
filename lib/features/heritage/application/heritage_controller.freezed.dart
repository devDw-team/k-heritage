// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'heritage_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HeritageState {
  List<Heritage> get heritages => throw _privateConstructorUsedError;
  List<Heritage> get filteredHeritages => throw _privateConstructorUsedError;
  Heritage? get selectedHeritage => throw _privateConstructorUsedError;
  Position? get currentPosition => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isRefreshing => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  double get searchRadius => throw _privateConstructorUsedError;
  String? get selectedCategory => throw _privateConstructorUsedError;
  bool get hasLocationPermission => throw _privateConstructorUsedError;

  /// Create a copy of HeritageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HeritageStateCopyWith<HeritageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeritageStateCopyWith<$Res> {
  factory $HeritageStateCopyWith(
          HeritageState value, $Res Function(HeritageState) then) =
      _$HeritageStateCopyWithImpl<$Res, HeritageState>;
  @useResult
  $Res call(
      {List<Heritage> heritages,
      List<Heritage> filteredHeritages,
      Heritage? selectedHeritage,
      Position? currentPosition,
      bool isLoading,
      bool isRefreshing,
      String? error,
      String language,
      double searchRadius,
      String? selectedCategory,
      bool hasLocationPermission});

  $HeritageCopyWith<$Res>? get selectedHeritage;
}

/// @nodoc
class _$HeritageStateCopyWithImpl<$Res, $Val extends HeritageState>
    implements $HeritageStateCopyWith<$Res> {
  _$HeritageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HeritageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? heritages = null,
    Object? filteredHeritages = null,
    Object? selectedHeritage = freezed,
    Object? currentPosition = freezed,
    Object? isLoading = null,
    Object? isRefreshing = null,
    Object? error = freezed,
    Object? language = null,
    Object? searchRadius = null,
    Object? selectedCategory = freezed,
    Object? hasLocationPermission = null,
  }) {
    return _then(_value.copyWith(
      heritages: null == heritages
          ? _value.heritages
          : heritages // ignore: cast_nullable_to_non_nullable
              as List<Heritage>,
      filteredHeritages: null == filteredHeritages
          ? _value.filteredHeritages
          : filteredHeritages // ignore: cast_nullable_to_non_nullable
              as List<Heritage>,
      selectedHeritage: freezed == selectedHeritage
          ? _value.selectedHeritage
          : selectedHeritage // ignore: cast_nullable_to_non_nullable
              as Heritage?,
      currentPosition: freezed == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Position?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefreshing: null == isRefreshing
          ? _value.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      searchRadius: null == searchRadius
          ? _value.searchRadius
          : searchRadius // ignore: cast_nullable_to_non_nullable
              as double,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      hasLocationPermission: null == hasLocationPermission
          ? _value.hasLocationPermission
          : hasLocationPermission // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of HeritageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HeritageCopyWith<$Res>? get selectedHeritage {
    if (_value.selectedHeritage == null) {
      return null;
    }

    return $HeritageCopyWith<$Res>(_value.selectedHeritage!, (value) {
      return _then(_value.copyWith(selectedHeritage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HeritageStateImplCopyWith<$Res>
    implements $HeritageStateCopyWith<$Res> {
  factory _$$HeritageStateImplCopyWith(
          _$HeritageStateImpl value, $Res Function(_$HeritageStateImpl) then) =
      __$$HeritageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Heritage> heritages,
      List<Heritage> filteredHeritages,
      Heritage? selectedHeritage,
      Position? currentPosition,
      bool isLoading,
      bool isRefreshing,
      String? error,
      String language,
      double searchRadius,
      String? selectedCategory,
      bool hasLocationPermission});

  @override
  $HeritageCopyWith<$Res>? get selectedHeritage;
}

/// @nodoc
class __$$HeritageStateImplCopyWithImpl<$Res>
    extends _$HeritageStateCopyWithImpl<$Res, _$HeritageStateImpl>
    implements _$$HeritageStateImplCopyWith<$Res> {
  __$$HeritageStateImplCopyWithImpl(
      _$HeritageStateImpl _value, $Res Function(_$HeritageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HeritageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? heritages = null,
    Object? filteredHeritages = null,
    Object? selectedHeritage = freezed,
    Object? currentPosition = freezed,
    Object? isLoading = null,
    Object? isRefreshing = null,
    Object? error = freezed,
    Object? language = null,
    Object? searchRadius = null,
    Object? selectedCategory = freezed,
    Object? hasLocationPermission = null,
  }) {
    return _then(_$HeritageStateImpl(
      heritages: null == heritages
          ? _value._heritages
          : heritages // ignore: cast_nullable_to_non_nullable
              as List<Heritage>,
      filteredHeritages: null == filteredHeritages
          ? _value._filteredHeritages
          : filteredHeritages // ignore: cast_nullable_to_non_nullable
              as List<Heritage>,
      selectedHeritage: freezed == selectedHeritage
          ? _value.selectedHeritage
          : selectedHeritage // ignore: cast_nullable_to_non_nullable
              as Heritage?,
      currentPosition: freezed == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Position?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefreshing: null == isRefreshing
          ? _value.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      searchRadius: null == searchRadius
          ? _value.searchRadius
          : searchRadius // ignore: cast_nullable_to_non_nullable
              as double,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      hasLocationPermission: null == hasLocationPermission
          ? _value.hasLocationPermission
          : hasLocationPermission // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HeritageStateImpl implements _HeritageState {
  const _$HeritageStateImpl(
      {final List<Heritage> heritages = const [],
      final List<Heritage> filteredHeritages = const [],
      this.selectedHeritage,
      this.currentPosition,
      this.isLoading = false,
      this.isRefreshing = false,
      this.error,
      this.language = 'ko',
      this.searchRadius = 3.0,
      this.selectedCategory,
      this.hasLocationPermission = false})
      : _heritages = heritages,
        _filteredHeritages = filteredHeritages;

  final List<Heritage> _heritages;
  @override
  @JsonKey()
  List<Heritage> get heritages {
    if (_heritages is EqualUnmodifiableListView) return _heritages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_heritages);
  }

  final List<Heritage> _filteredHeritages;
  @override
  @JsonKey()
  List<Heritage> get filteredHeritages {
    if (_filteredHeritages is EqualUnmodifiableListView)
      return _filteredHeritages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredHeritages);
  }

  @override
  final Heritage? selectedHeritage;
  @override
  final Position? currentPosition;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isRefreshing;
  @override
  final String? error;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final double searchRadius;
  @override
  final String? selectedCategory;
  @override
  @JsonKey()
  final bool hasLocationPermission;

  @override
  String toString() {
    return 'HeritageState(heritages: $heritages, filteredHeritages: $filteredHeritages, selectedHeritage: $selectedHeritage, currentPosition: $currentPosition, isLoading: $isLoading, isRefreshing: $isRefreshing, error: $error, language: $language, searchRadius: $searchRadius, selectedCategory: $selectedCategory, hasLocationPermission: $hasLocationPermission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeritageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._heritages, _heritages) &&
            const DeepCollectionEquality()
                .equals(other._filteredHeritages, _filteredHeritages) &&
            (identical(other.selectedHeritage, selectedHeritage) ||
                other.selectedHeritage == selectedHeritage) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.searchRadius, searchRadius) ||
                other.searchRadius == searchRadius) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.hasLocationPermission, hasLocationPermission) ||
                other.hasLocationPermission == hasLocationPermission));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_heritages),
      const DeepCollectionEquality().hash(_filteredHeritages),
      selectedHeritage,
      currentPosition,
      isLoading,
      isRefreshing,
      error,
      language,
      searchRadius,
      selectedCategory,
      hasLocationPermission);

  /// Create a copy of HeritageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HeritageStateImplCopyWith<_$HeritageStateImpl> get copyWith =>
      __$$HeritageStateImplCopyWithImpl<_$HeritageStateImpl>(this, _$identity);
}

abstract class _HeritageState implements HeritageState {
  const factory _HeritageState(
      {final List<Heritage> heritages,
      final List<Heritage> filteredHeritages,
      final Heritage? selectedHeritage,
      final Position? currentPosition,
      final bool isLoading,
      final bool isRefreshing,
      final String? error,
      final String language,
      final double searchRadius,
      final String? selectedCategory,
      final bool hasLocationPermission}) = _$HeritageStateImpl;

  @override
  List<Heritage> get heritages;
  @override
  List<Heritage> get filteredHeritages;
  @override
  Heritage? get selectedHeritage;
  @override
  Position? get currentPosition;
  @override
  bool get isLoading;
  @override
  bool get isRefreshing;
  @override
  String? get error;
  @override
  String get language;
  @override
  double get searchRadius;
  @override
  String? get selectedCategory;
  @override
  bool get hasLocationPermission;

  /// Create a copy of HeritageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HeritageStateImplCopyWith<_$HeritageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
