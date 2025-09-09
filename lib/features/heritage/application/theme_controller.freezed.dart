// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ThemeState {
  List<Theme> get themes => throw _privateConstructorUsedError;
  Theme? get selectedTheme => throw _privateConstructorUsedError;
  List<Heritage> get themeHeritages => throw _privateConstructorUsedError;
  Map<String, int> get themeCounts => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingHeritages => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeStateCopyWith<ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
          ThemeState value, $Res Function(ThemeState) then) =
      _$ThemeStateCopyWithImpl<$Res, ThemeState>;
  @useResult
  $Res call(
      {List<Theme> themes,
      Theme? selectedTheme,
      List<Heritage> themeHeritages,
      Map<String, int> themeCounts,
      bool isLoading,
      bool isLoadingHeritages,
      String? error,
      String language});

  $ThemeCopyWith<$Res>? get selectedTheme;
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res, $Val extends ThemeState>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themes = null,
    Object? selectedTheme = freezed,
    Object? themeHeritages = null,
    Object? themeCounts = null,
    Object? isLoading = null,
    Object? isLoadingHeritages = null,
    Object? error = freezed,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      themes: null == themes
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<Theme>,
      selectedTheme: freezed == selectedTheme
          ? _value.selectedTheme
          : selectedTheme // ignore: cast_nullable_to_non_nullable
              as Theme?,
      themeHeritages: null == themeHeritages
          ? _value.themeHeritages
          : themeHeritages // ignore: cast_nullable_to_non_nullable
              as List<Heritage>,
      themeCounts: null == themeCounts
          ? _value.themeCounts
          : themeCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingHeritages: null == isLoadingHeritages
          ? _value.isLoadingHeritages
          : isLoadingHeritages // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemeCopyWith<$Res>? get selectedTheme {
    if (_value.selectedTheme == null) {
      return null;
    }

    return $ThemeCopyWith<$Res>(_value.selectedTheme!, (value) {
      return _then(_value.copyWith(selectedTheme: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ThemeStateImplCopyWith<$Res>
    implements $ThemeStateCopyWith<$Res> {
  factory _$$ThemeStateImplCopyWith(
          _$ThemeStateImpl value, $Res Function(_$ThemeStateImpl) then) =
      __$$ThemeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Theme> themes,
      Theme? selectedTheme,
      List<Heritage> themeHeritages,
      Map<String, int> themeCounts,
      bool isLoading,
      bool isLoadingHeritages,
      String? error,
      String language});

  @override
  $ThemeCopyWith<$Res>? get selectedTheme;
}

/// @nodoc
class __$$ThemeStateImplCopyWithImpl<$Res>
    extends _$ThemeStateCopyWithImpl<$Res, _$ThemeStateImpl>
    implements _$$ThemeStateImplCopyWith<$Res> {
  __$$ThemeStateImplCopyWithImpl(
      _$ThemeStateImpl _value, $Res Function(_$ThemeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themes = null,
    Object? selectedTheme = freezed,
    Object? themeHeritages = null,
    Object? themeCounts = null,
    Object? isLoading = null,
    Object? isLoadingHeritages = null,
    Object? error = freezed,
    Object? language = null,
  }) {
    return _then(_$ThemeStateImpl(
      themes: null == themes
          ? _value._themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<Theme>,
      selectedTheme: freezed == selectedTheme
          ? _value.selectedTheme
          : selectedTheme // ignore: cast_nullable_to_non_nullable
              as Theme?,
      themeHeritages: null == themeHeritages
          ? _value._themeHeritages
          : themeHeritages // ignore: cast_nullable_to_non_nullable
              as List<Heritage>,
      themeCounts: null == themeCounts
          ? _value._themeCounts
          : themeCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingHeritages: null == isLoadingHeritages
          ? _value.isLoadingHeritages
          : isLoadingHeritages // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ThemeStateImpl implements _ThemeState {
  const _$ThemeStateImpl(
      {final List<Theme> themes = const [],
      this.selectedTheme,
      final List<Heritage> themeHeritages = const [],
      final Map<String, int> themeCounts = const {},
      this.isLoading = false,
      this.isLoadingHeritages = false,
      this.error,
      this.language = 'ko'})
      : _themes = themes,
        _themeHeritages = themeHeritages,
        _themeCounts = themeCounts;

  final List<Theme> _themes;
  @override
  @JsonKey()
  List<Theme> get themes {
    if (_themes is EqualUnmodifiableListView) return _themes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themes);
  }

  @override
  final Theme? selectedTheme;
  final List<Heritage> _themeHeritages;
  @override
  @JsonKey()
  List<Heritage> get themeHeritages {
    if (_themeHeritages is EqualUnmodifiableListView) return _themeHeritages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themeHeritages);
  }

  final Map<String, int> _themeCounts;
  @override
  @JsonKey()
  Map<String, int> get themeCounts {
    if (_themeCounts is EqualUnmodifiableMapView) return _themeCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_themeCounts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingHeritages;
  @override
  final String? error;
  @override
  @JsonKey()
  final String language;

  @override
  String toString() {
    return 'ThemeState(themes: $themes, selectedTheme: $selectedTheme, themeHeritages: $themeHeritages, themeCounts: $themeCounts, isLoading: $isLoading, isLoadingHeritages: $isLoadingHeritages, error: $error, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeStateImpl &&
            const DeepCollectionEquality().equals(other._themes, _themes) &&
            (identical(other.selectedTheme, selectedTheme) ||
                other.selectedTheme == selectedTheme) &&
            const DeepCollectionEquality()
                .equals(other._themeHeritages, _themeHeritages) &&
            const DeepCollectionEquality()
                .equals(other._themeCounts, _themeCounts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingHeritages, isLoadingHeritages) ||
                other.isLoadingHeritages == isLoadingHeritages) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_themes),
      selectedTheme,
      const DeepCollectionEquality().hash(_themeHeritages),
      const DeepCollectionEquality().hash(_themeCounts),
      isLoading,
      isLoadingHeritages,
      error,
      language);

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeStateImplCopyWith<_$ThemeStateImpl> get copyWith =>
      __$$ThemeStateImplCopyWithImpl<_$ThemeStateImpl>(this, _$identity);
}

abstract class _ThemeState implements ThemeState {
  const factory _ThemeState(
      {final List<Theme> themes,
      final Theme? selectedTheme,
      final List<Heritage> themeHeritages,
      final Map<String, int> themeCounts,
      final bool isLoading,
      final bool isLoadingHeritages,
      final String? error,
      final String language}) = _$ThemeStateImpl;

  @override
  List<Theme> get themes;
  @override
  Theme? get selectedTheme;
  @override
  List<Heritage> get themeHeritages;
  @override
  Map<String, int> get themeCounts;
  @override
  bool get isLoading;
  @override
  bool get isLoadingHeritages;
  @override
  String? get error;
  @override
  String get language;

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeStateImplCopyWith<_$ThemeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
