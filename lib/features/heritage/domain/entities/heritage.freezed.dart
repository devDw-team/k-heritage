// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'heritage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Heritage _$HeritageFromJson(Map<String, dynamic> json) {
  return _Heritage.fromJson(json);
}

/// @nodoc
mixin _$Heritage {
  String get id => throw _privateConstructorUsedError;
  String get nameKo => throw _privateConstructorUsedError;
  String? get nameEn => throw _privateConstructorUsedError;
  String? get nameJa => throw _privateConstructorUsedError;
  String? get nameZh => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get designatedYear => throw _privateConstructorUsedError;
  String? get descriptionKo => throw _privateConstructorUsedError;
  String? get descriptionEn => throw _privateConstructorUsedError;
  String? get descriptionJa => throw _privateConstructorUsedError;
  String? get descriptionZh => throw _privateConstructorUsedError;
  List<HeritageImage> get images => throw _privateConstructorUsedError;
  double? get distance =>
      throw _privateConstructorUsedError; // 현재 위치로부터의 거리 (km)
  bool get isBookmarked => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Heritage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Heritage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HeritageCopyWith<Heritage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeritageCopyWith<$Res> {
  factory $HeritageCopyWith(Heritage value, $Res Function(Heritage) then) =
      _$HeritageCopyWithImpl<$Res, Heritage>;
  @useResult
  $Res call(
      {String id,
      String nameKo,
      String? nameEn,
      String? nameJa,
      String? nameZh,
      String category,
      double latitude,
      double longitude,
      String address,
      String? designatedYear,
      String? descriptionKo,
      String? descriptionEn,
      String? descriptionJa,
      String? descriptionZh,
      List<HeritageImage> images,
      double? distance,
      bool isBookmarked,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$HeritageCopyWithImpl<$Res, $Val extends Heritage>
    implements $HeritageCopyWith<$Res> {
  _$HeritageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Heritage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameKo = null,
    Object? nameEn = freezed,
    Object? nameJa = freezed,
    Object? nameZh = freezed,
    Object? category = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? designatedYear = freezed,
    Object? descriptionKo = freezed,
    Object? descriptionEn = freezed,
    Object? descriptionJa = freezed,
    Object? descriptionZh = freezed,
    Object? images = null,
    Object? distance = freezed,
    Object? isBookmarked = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nameKo: null == nameKo
          ? _value.nameKo
          : nameKo // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: freezed == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String?,
      nameJa: freezed == nameJa
          ? _value.nameJa
          : nameJa // ignore: cast_nullable_to_non_nullable
              as String?,
      nameZh: freezed == nameZh
          ? _value.nameZh
          : nameZh // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      designatedYear: freezed == designatedYear
          ? _value.designatedYear
          : designatedYear // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionKo: freezed == descriptionKo
          ? _value.descriptionKo
          : descriptionKo // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionEn: freezed == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionJa: freezed == descriptionJa
          ? _value.descriptionJa
          : descriptionJa // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionZh: freezed == descriptionZh
          ? _value.descriptionZh
          : descriptionZh // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<HeritageImage>,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HeritageImplCopyWith<$Res>
    implements $HeritageCopyWith<$Res> {
  factory _$$HeritageImplCopyWith(
          _$HeritageImpl value, $Res Function(_$HeritageImpl) then) =
      __$$HeritageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nameKo,
      String? nameEn,
      String? nameJa,
      String? nameZh,
      String category,
      double latitude,
      double longitude,
      String address,
      String? designatedYear,
      String? descriptionKo,
      String? descriptionEn,
      String? descriptionJa,
      String? descriptionZh,
      List<HeritageImage> images,
      double? distance,
      bool isBookmarked,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$HeritageImplCopyWithImpl<$Res>
    extends _$HeritageCopyWithImpl<$Res, _$HeritageImpl>
    implements _$$HeritageImplCopyWith<$Res> {
  __$$HeritageImplCopyWithImpl(
      _$HeritageImpl _value, $Res Function(_$HeritageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Heritage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameKo = null,
    Object? nameEn = freezed,
    Object? nameJa = freezed,
    Object? nameZh = freezed,
    Object? category = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? designatedYear = freezed,
    Object? descriptionKo = freezed,
    Object? descriptionEn = freezed,
    Object? descriptionJa = freezed,
    Object? descriptionZh = freezed,
    Object? images = null,
    Object? distance = freezed,
    Object? isBookmarked = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$HeritageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nameKo: null == nameKo
          ? _value.nameKo
          : nameKo // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: freezed == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String?,
      nameJa: freezed == nameJa
          ? _value.nameJa
          : nameJa // ignore: cast_nullable_to_non_nullable
              as String?,
      nameZh: freezed == nameZh
          ? _value.nameZh
          : nameZh // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      designatedYear: freezed == designatedYear
          ? _value.designatedYear
          : designatedYear // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionKo: freezed == descriptionKo
          ? _value.descriptionKo
          : descriptionKo // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionEn: freezed == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionJa: freezed == descriptionJa
          ? _value.descriptionJa
          : descriptionJa // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionZh: freezed == descriptionZh
          ? _value.descriptionZh
          : descriptionZh // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<HeritageImage>,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HeritageImpl implements _Heritage {
  const _$HeritageImpl(
      {required this.id,
      required this.nameKo,
      this.nameEn,
      this.nameJa,
      this.nameZh,
      required this.category,
      required this.latitude,
      required this.longitude,
      required this.address,
      this.designatedYear,
      this.descriptionKo,
      this.descriptionEn,
      this.descriptionJa,
      this.descriptionZh,
      final List<HeritageImage> images = const [],
      this.distance,
      this.isBookmarked = false,
      this.createdAt,
      this.updatedAt})
      : _images = images;

  factory _$HeritageImpl.fromJson(Map<String, dynamic> json) =>
      _$$HeritageImplFromJson(json);

  @override
  final String id;
  @override
  final String nameKo;
  @override
  final String? nameEn;
  @override
  final String? nameJa;
  @override
  final String? nameZh;
  @override
  final String category;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String address;
  @override
  final String? designatedYear;
  @override
  final String? descriptionKo;
  @override
  final String? descriptionEn;
  @override
  final String? descriptionJa;
  @override
  final String? descriptionZh;
  final List<HeritageImage> _images;
  @override
  @JsonKey()
  List<HeritageImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final double? distance;
// 현재 위치로부터의 거리 (km)
  @override
  @JsonKey()
  final bool isBookmarked;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Heritage(id: $id, nameKo: $nameKo, nameEn: $nameEn, nameJa: $nameJa, nameZh: $nameZh, category: $category, latitude: $latitude, longitude: $longitude, address: $address, designatedYear: $designatedYear, descriptionKo: $descriptionKo, descriptionEn: $descriptionEn, descriptionJa: $descriptionJa, descriptionZh: $descriptionZh, images: $images, distance: $distance, isBookmarked: $isBookmarked, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeritageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameKo, nameKo) || other.nameKo == nameKo) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.nameJa, nameJa) || other.nameJa == nameJa) &&
            (identical(other.nameZh, nameZh) || other.nameZh == nameZh) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.designatedYear, designatedYear) ||
                other.designatedYear == designatedYear) &&
            (identical(other.descriptionKo, descriptionKo) ||
                other.descriptionKo == descriptionKo) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.descriptionJa, descriptionJa) ||
                other.descriptionJa == descriptionJa) &&
            (identical(other.descriptionZh, descriptionZh) ||
                other.descriptionZh == descriptionZh) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        nameKo,
        nameEn,
        nameJa,
        nameZh,
        category,
        latitude,
        longitude,
        address,
        designatedYear,
        descriptionKo,
        descriptionEn,
        descriptionJa,
        descriptionZh,
        const DeepCollectionEquality().hash(_images),
        distance,
        isBookmarked,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Heritage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HeritageImplCopyWith<_$HeritageImpl> get copyWith =>
      __$$HeritageImplCopyWithImpl<_$HeritageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HeritageImplToJson(
      this,
    );
  }
}

abstract class _Heritage implements Heritage {
  const factory _Heritage(
      {required final String id,
      required final String nameKo,
      final String? nameEn,
      final String? nameJa,
      final String? nameZh,
      required final String category,
      required final double latitude,
      required final double longitude,
      required final String address,
      final String? designatedYear,
      final String? descriptionKo,
      final String? descriptionEn,
      final String? descriptionJa,
      final String? descriptionZh,
      final List<HeritageImage> images,
      final double? distance,
      final bool isBookmarked,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$HeritageImpl;

  factory _Heritage.fromJson(Map<String, dynamic> json) =
      _$HeritageImpl.fromJson;

  @override
  String get id;
  @override
  String get nameKo;
  @override
  String? get nameEn;
  @override
  String? get nameJa;
  @override
  String? get nameZh;
  @override
  String get category;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  String? get designatedYear;
  @override
  String? get descriptionKo;
  @override
  String? get descriptionEn;
  @override
  String? get descriptionJa;
  @override
  String? get descriptionZh;
  @override
  List<HeritageImage> get images;
  @override
  double? get distance; // 현재 위치로부터의 거리 (km)
  @override
  bool get isBookmarked;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Heritage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HeritageImplCopyWith<_$HeritageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HeritageImage _$HeritageImageFromJson(Map<String, dynamic> json) {
  return _HeritageImage.fromJson(json);
}

/// @nodoc
mixin _$HeritageImage {
  String get id => throw _privateConstructorUsedError;
  String get heritageId => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  String? get copyright => throw _privateConstructorUsedError;
  int? get orderIndex => throw _privateConstructorUsedError;

  /// Serializes this HeritageImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HeritageImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HeritageImageCopyWith<HeritageImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeritageImageCopyWith<$Res> {
  factory $HeritageImageCopyWith(
          HeritageImage value, $Res Function(HeritageImage) then) =
      _$HeritageImageCopyWithImpl<$Res, HeritageImage>;
  @useResult
  $Res call(
      {String id,
      String heritageId,
      String url,
      String? thumbnailUrl,
      String? caption,
      String? copyright,
      int? orderIndex});
}

/// @nodoc
class _$HeritageImageCopyWithImpl<$Res, $Val extends HeritageImage>
    implements $HeritageImageCopyWith<$Res> {
  _$HeritageImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HeritageImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? heritageId = null,
    Object? url = null,
    Object? thumbnailUrl = freezed,
    Object? caption = freezed,
    Object? copyright = freezed,
    Object? orderIndex = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      heritageId: null == heritageId
          ? _value.heritageId
          : heritageId // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      copyright: freezed == copyright
          ? _value.copyright
          : copyright // ignore: cast_nullable_to_non_nullable
              as String?,
      orderIndex: freezed == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HeritageImageImplCopyWith<$Res>
    implements $HeritageImageCopyWith<$Res> {
  factory _$$HeritageImageImplCopyWith(
          _$HeritageImageImpl value, $Res Function(_$HeritageImageImpl) then) =
      __$$HeritageImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String heritageId,
      String url,
      String? thumbnailUrl,
      String? caption,
      String? copyright,
      int? orderIndex});
}

/// @nodoc
class __$$HeritageImageImplCopyWithImpl<$Res>
    extends _$HeritageImageCopyWithImpl<$Res, _$HeritageImageImpl>
    implements _$$HeritageImageImplCopyWith<$Res> {
  __$$HeritageImageImplCopyWithImpl(
      _$HeritageImageImpl _value, $Res Function(_$HeritageImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of HeritageImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? heritageId = null,
    Object? url = null,
    Object? thumbnailUrl = freezed,
    Object? caption = freezed,
    Object? copyright = freezed,
    Object? orderIndex = freezed,
  }) {
    return _then(_$HeritageImageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      heritageId: null == heritageId
          ? _value.heritageId
          : heritageId // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      copyright: freezed == copyright
          ? _value.copyright
          : copyright // ignore: cast_nullable_to_non_nullable
              as String?,
      orderIndex: freezed == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HeritageImageImpl implements _HeritageImage {
  const _$HeritageImageImpl(
      {required this.id,
      required this.heritageId,
      required this.url,
      this.thumbnailUrl,
      this.caption,
      this.copyright,
      this.orderIndex});

  factory _$HeritageImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$HeritageImageImplFromJson(json);

  @override
  final String id;
  @override
  final String heritageId;
  @override
  final String url;
  @override
  final String? thumbnailUrl;
  @override
  final String? caption;
  @override
  final String? copyright;
  @override
  final int? orderIndex;

  @override
  String toString() {
    return 'HeritageImage(id: $id, heritageId: $heritageId, url: $url, thumbnailUrl: $thumbnailUrl, caption: $caption, copyright: $copyright, orderIndex: $orderIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeritageImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.heritageId, heritageId) ||
                other.heritageId == heritageId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.copyright, copyright) ||
                other.copyright == copyright) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, heritageId, url,
      thumbnailUrl, caption, copyright, orderIndex);

  /// Create a copy of HeritageImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HeritageImageImplCopyWith<_$HeritageImageImpl> get copyWith =>
      __$$HeritageImageImplCopyWithImpl<_$HeritageImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HeritageImageImplToJson(
      this,
    );
  }
}

abstract class _HeritageImage implements HeritageImage {
  const factory _HeritageImage(
      {required final String id,
      required final String heritageId,
      required final String url,
      final String? thumbnailUrl,
      final String? caption,
      final String? copyright,
      final int? orderIndex}) = _$HeritageImageImpl;

  factory _HeritageImage.fromJson(Map<String, dynamic> json) =
      _$HeritageImageImpl.fromJson;

  @override
  String get id;
  @override
  String get heritageId;
  @override
  String get url;
  @override
  String? get thumbnailUrl;
  @override
  String? get caption;
  @override
  String? get copyright;
  @override
  int? get orderIndex;

  /// Create a copy of HeritageImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HeritageImageImplCopyWith<_$HeritageImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Theme _$ThemeFromJson(Map<String, dynamic> json) {
  return _Theme.fromJson(json);
}

/// @nodoc
mixin _$Theme {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get nameKo => throw _privateConstructorUsedError;
  String? get nameEn => throw _privateConstructorUsedError;
  String? get nameJa => throw _privateConstructorUsedError;
  String? get nameZh => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String? get descriptionKo => throw _privateConstructorUsedError;
  String? get descriptionEn => throw _privateConstructorUsedError;
  String? get descriptionJa => throw _privateConstructorUsedError;
  String? get descriptionZh => throw _privateConstructorUsedError;
  int get heritageCount => throw _privateConstructorUsedError;
  int? get orderIndex => throw _privateConstructorUsedError;

  /// Serializes this Theme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Theme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeCopyWith<Theme> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeCopyWith<$Res> {
  factory $ThemeCopyWith(Theme value, $Res Function(Theme) then) =
      _$ThemeCopyWithImpl<$Res, Theme>;
  @useResult
  $Res call(
      {String id,
      String code,
      String nameKo,
      String? nameEn,
      String? nameJa,
      String? nameZh,
      String icon,
      String? descriptionKo,
      String? descriptionEn,
      String? descriptionJa,
      String? descriptionZh,
      int heritageCount,
      int? orderIndex});
}

/// @nodoc
class _$ThemeCopyWithImpl<$Res, $Val extends Theme>
    implements $ThemeCopyWith<$Res> {
  _$ThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Theme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? nameKo = null,
    Object? nameEn = freezed,
    Object? nameJa = freezed,
    Object? nameZh = freezed,
    Object? icon = null,
    Object? descriptionKo = freezed,
    Object? descriptionEn = freezed,
    Object? descriptionJa = freezed,
    Object? descriptionZh = freezed,
    Object? heritageCount = null,
    Object? orderIndex = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      nameKo: null == nameKo
          ? _value.nameKo
          : nameKo // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: freezed == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String?,
      nameJa: freezed == nameJa
          ? _value.nameJa
          : nameJa // ignore: cast_nullable_to_non_nullable
              as String?,
      nameZh: freezed == nameZh
          ? _value.nameZh
          : nameZh // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionKo: freezed == descriptionKo
          ? _value.descriptionKo
          : descriptionKo // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionEn: freezed == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionJa: freezed == descriptionJa
          ? _value.descriptionJa
          : descriptionJa // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionZh: freezed == descriptionZh
          ? _value.descriptionZh
          : descriptionZh // ignore: cast_nullable_to_non_nullable
              as String?,
      heritageCount: null == heritageCount
          ? _value.heritageCount
          : heritageCount // ignore: cast_nullable_to_non_nullable
              as int,
      orderIndex: freezed == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThemeImplCopyWith<$Res> implements $ThemeCopyWith<$Res> {
  factory _$$ThemeImplCopyWith(
          _$ThemeImpl value, $Res Function(_$ThemeImpl) then) =
      __$$ThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String code,
      String nameKo,
      String? nameEn,
      String? nameJa,
      String? nameZh,
      String icon,
      String? descriptionKo,
      String? descriptionEn,
      String? descriptionJa,
      String? descriptionZh,
      int heritageCount,
      int? orderIndex});
}

/// @nodoc
class __$$ThemeImplCopyWithImpl<$Res>
    extends _$ThemeCopyWithImpl<$Res, _$ThemeImpl>
    implements _$$ThemeImplCopyWith<$Res> {
  __$$ThemeImplCopyWithImpl(
      _$ThemeImpl _value, $Res Function(_$ThemeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Theme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? nameKo = null,
    Object? nameEn = freezed,
    Object? nameJa = freezed,
    Object? nameZh = freezed,
    Object? icon = null,
    Object? descriptionKo = freezed,
    Object? descriptionEn = freezed,
    Object? descriptionJa = freezed,
    Object? descriptionZh = freezed,
    Object? heritageCount = null,
    Object? orderIndex = freezed,
  }) {
    return _then(_$ThemeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      nameKo: null == nameKo
          ? _value.nameKo
          : nameKo // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: freezed == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String?,
      nameJa: freezed == nameJa
          ? _value.nameJa
          : nameJa // ignore: cast_nullable_to_non_nullable
              as String?,
      nameZh: freezed == nameZh
          ? _value.nameZh
          : nameZh // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionKo: freezed == descriptionKo
          ? _value.descriptionKo
          : descriptionKo // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionEn: freezed == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionJa: freezed == descriptionJa
          ? _value.descriptionJa
          : descriptionJa // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionZh: freezed == descriptionZh
          ? _value.descriptionZh
          : descriptionZh // ignore: cast_nullable_to_non_nullable
              as String?,
      heritageCount: null == heritageCount
          ? _value.heritageCount
          : heritageCount // ignore: cast_nullable_to_non_nullable
              as int,
      orderIndex: freezed == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemeImpl implements _Theme {
  const _$ThemeImpl(
      {required this.id,
      required this.code,
      required this.nameKo,
      this.nameEn,
      this.nameJa,
      this.nameZh,
      required this.icon,
      this.descriptionKo,
      this.descriptionEn,
      this.descriptionJa,
      this.descriptionZh,
      this.heritageCount = 0,
      this.orderIndex});

  factory _$ThemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeImplFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  final String nameKo;
  @override
  final String? nameEn;
  @override
  final String? nameJa;
  @override
  final String? nameZh;
  @override
  final String icon;
  @override
  final String? descriptionKo;
  @override
  final String? descriptionEn;
  @override
  final String? descriptionJa;
  @override
  final String? descriptionZh;
  @override
  @JsonKey()
  final int heritageCount;
  @override
  final int? orderIndex;

  @override
  String toString() {
    return 'Theme(id: $id, code: $code, nameKo: $nameKo, nameEn: $nameEn, nameJa: $nameJa, nameZh: $nameZh, icon: $icon, descriptionKo: $descriptionKo, descriptionEn: $descriptionEn, descriptionJa: $descriptionJa, descriptionZh: $descriptionZh, heritageCount: $heritageCount, orderIndex: $orderIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.nameKo, nameKo) || other.nameKo == nameKo) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.nameJa, nameJa) || other.nameJa == nameJa) &&
            (identical(other.nameZh, nameZh) || other.nameZh == nameZh) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.descriptionKo, descriptionKo) ||
                other.descriptionKo == descriptionKo) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.descriptionJa, descriptionJa) ||
                other.descriptionJa == descriptionJa) &&
            (identical(other.descriptionZh, descriptionZh) ||
                other.descriptionZh == descriptionZh) &&
            (identical(other.heritageCount, heritageCount) ||
                other.heritageCount == heritageCount) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      nameKo,
      nameEn,
      nameJa,
      nameZh,
      icon,
      descriptionKo,
      descriptionEn,
      descriptionJa,
      descriptionZh,
      heritageCount,
      orderIndex);

  /// Create a copy of Theme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeImplCopyWith<_$ThemeImpl> get copyWith =>
      __$$ThemeImplCopyWithImpl<_$ThemeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeImplToJson(
      this,
    );
  }
}

abstract class _Theme implements Theme {
  const factory _Theme(
      {required final String id,
      required final String code,
      required final String nameKo,
      final String? nameEn,
      final String? nameJa,
      final String? nameZh,
      required final String icon,
      final String? descriptionKo,
      final String? descriptionEn,
      final String? descriptionJa,
      final String? descriptionZh,
      final int heritageCount,
      final int? orderIndex}) = _$ThemeImpl;

  factory _Theme.fromJson(Map<String, dynamic> json) = _$ThemeImpl.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  String get nameKo;
  @override
  String? get nameEn;
  @override
  String? get nameJa;
  @override
  String? get nameZh;
  @override
  String get icon;
  @override
  String? get descriptionKo;
  @override
  String? get descriptionEn;
  @override
  String? get descriptionJa;
  @override
  String? get descriptionZh;
  @override
  int get heritageCount;
  @override
  int? get orderIndex;

  /// Create a copy of Theme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeImplCopyWith<_$ThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  String get userId => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  double get searchRadiusKm => throw _privateConstructorUsedError;
  bool get enableNotifications => throw _privateConstructorUsedError;
  bool get enableNearbyAlerts => throw _privateConstructorUsedError;
  bool get enableDarkMode => throw _privateConstructorUsedError;
  bool get hasCompletedOnboarding => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) then) =
      _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call(
      {String userId,
      String language,
      double searchRadiusKm,
      bool enableNotifications,
      bool enableNearbyAlerts,
      bool enableDarkMode,
      bool hasCompletedOnboarding,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? language = null,
    Object? searchRadiusKm = null,
    Object? enableNotifications = null,
    Object? enableNearbyAlerts = null,
    Object? enableDarkMode = null,
    Object? hasCompletedOnboarding = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      searchRadiusKm: null == searchRadiusKm
          ? _value.searchRadiusKm
          : searchRadiusKm // ignore: cast_nullable_to_non_nullable
              as double,
      enableNotifications: null == enableNotifications
          ? _value.enableNotifications
          : enableNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      enableNearbyAlerts: null == enableNearbyAlerts
          ? _value.enableNearbyAlerts
          : enableNearbyAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDarkMode: null == enableDarkMode
          ? _value.enableDarkMode
          : enableDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      hasCompletedOnboarding: null == hasCompletedOnboarding
          ? _value.hasCompletedOnboarding
          : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
          _$UserSettingsImpl value, $Res Function(_$UserSettingsImpl) then) =
      __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String language,
      double searchRadiusKm,
      bool enableNotifications,
      bool enableNearbyAlerts,
      bool enableDarkMode,
      bool hasCompletedOnboarding,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
      _$UserSettingsImpl _value, $Res Function(_$UserSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? language = null,
    Object? searchRadiusKm = null,
    Object? enableNotifications = null,
    Object? enableNearbyAlerts = null,
    Object? enableDarkMode = null,
    Object? hasCompletedOnboarding = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserSettingsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      searchRadiusKm: null == searchRadiusKm
          ? _value.searchRadiusKm
          : searchRadiusKm // ignore: cast_nullable_to_non_nullable
              as double,
      enableNotifications: null == enableNotifications
          ? _value.enableNotifications
          : enableNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      enableNearbyAlerts: null == enableNearbyAlerts
          ? _value.enableNearbyAlerts
          : enableNearbyAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      enableDarkMode: null == enableDarkMode
          ? _value.enableDarkMode
          : enableDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      hasCompletedOnboarding: null == hasCompletedOnboarding
          ? _value.hasCompletedOnboarding
          : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl(
      {required this.userId,
      this.language = 'ko',
      this.searchRadiusKm = 3.0,
      this.enableNotifications = true,
      this.enableNearbyAlerts = true,
      this.enableDarkMode = false,
      this.hasCompletedOnboarding = false,
      this.createdAt,
      this.updatedAt});

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final double searchRadiusKm;
  @override
  @JsonKey()
  final bool enableNotifications;
  @override
  @JsonKey()
  final bool enableNearbyAlerts;
  @override
  @JsonKey()
  final bool enableDarkMode;
  @override
  @JsonKey()
  final bool hasCompletedOnboarding;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserSettings(userId: $userId, language: $language, searchRadiusKm: $searchRadiusKm, enableNotifications: $enableNotifications, enableNearbyAlerts: $enableNearbyAlerts, enableDarkMode: $enableDarkMode, hasCompletedOnboarding: $hasCompletedOnboarding, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.searchRadiusKm, searchRadiusKm) ||
                other.searchRadiusKm == searchRadiusKm) &&
            (identical(other.enableNotifications, enableNotifications) ||
                other.enableNotifications == enableNotifications) &&
            (identical(other.enableNearbyAlerts, enableNearbyAlerts) ||
                other.enableNearbyAlerts == enableNearbyAlerts) &&
            (identical(other.enableDarkMode, enableDarkMode) ||
                other.enableDarkMode == enableDarkMode) &&
            (identical(other.hasCompletedOnboarding, hasCompletedOnboarding) ||
                other.hasCompletedOnboarding == hasCompletedOnboarding) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      language,
      searchRadiusKm,
      enableNotifications,
      enableNearbyAlerts,
      enableDarkMode,
      hasCompletedOnboarding,
      createdAt,
      updatedAt);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(
      this,
    );
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings(
      {required final String userId,
      final String language,
      final double searchRadiusKm,
      final bool enableNotifications,
      final bool enableNearbyAlerts,
      final bool enableDarkMode,
      final bool hasCompletedOnboarding,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  @override
  String get userId;
  @override
  String get language;
  @override
  double get searchRadiusKm;
  @override
  bool get enableNotifications;
  @override
  bool get enableNearbyAlerts;
  @override
  bool get enableDarkMode;
  @override
  bool get hasCompletedOnboarding;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
