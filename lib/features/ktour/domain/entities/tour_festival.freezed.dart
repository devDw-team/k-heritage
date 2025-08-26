// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tour_festival.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TourFestival _$TourFestivalFromJson(Map<String, dynamic> json) {
  return _TourFestival.fromJson(json);
}

/// @nodoc
mixin _$TourFestival {
  String get contentId => throw _privateConstructorUsedError; // Tour API 콘텐츠 ID
  String get title => throw _privateConstructorUsedError; // 행사명
  String? get address1 => throw _privateConstructorUsedError; // 주소
  String? get address2 => throw _privateConstructorUsedError; // 상세 주소
  String? get areaCode => throw _privateConstructorUsedError; // 지역 코드
  String? get sigunguCode => throw _privateConstructorUsedError; // 시군구 코드
  double? get mapX => throw _privateConstructorUsedError; // 경도
  double? get mapY => throw _privateConstructorUsedError; // 위도
  String? get firstImage => throw _privateConstructorUsedError; // 대표 이미지 원본
  String? get firstImage2 => throw _privateConstructorUsedError; // 대표 이미지 썸네일
  String? get tel => throw _privateConstructorUsedError; // 전화번호
  String? get eventStartDate =>
      throw _privateConstructorUsedError; // 행사 시작일 (YYYYMMDD)
  String? get eventEndDate =>
      throw _privateConstructorUsedError; // 행사 종료일 (YYYYMMDD)
  String? get eventPlace => throw _privateConstructorUsedError; // 행사 장소
  String? get playTime => throw _privateConstructorUsedError; // 공연 시간
  String? get sponsor1 => throw _privateConstructorUsedError; // 주최자
  String? get sponsor1Tel => throw _privateConstructorUsedError; // 주최자 연락처
  String? get sponsor2 => throw _privateConstructorUsedError; // 주관사
  String? get sponsor2Tel => throw _privateConstructorUsedError; // 주관사 연락처
  String? get useFee => throw _privateConstructorUsedError; // 이용 요금
  String? get homepage => throw _privateConstructorUsedError; // 홈페이지
  String? get overview => throw _privateConstructorUsedError; // 개요
  String? get cat1 => throw _privateConstructorUsedError; // 대분류
  String? get cat2 => throw _privateConstructorUsedError; // 중분류
  String? get cat3 => throw _privateConstructorUsedError; // 소분류
  String? get cpyrhtDivCd => throw _privateConstructorUsedError; // 저작권 유형
  String? get createdTime => throw _privateConstructorUsedError; // 생성일
  String? get modifiedTime => throw _privateConstructorUsedError; // 수정일
  int? get mlevel => throw _privateConstructorUsedError; // 지도 레벨
// 거리 정보 (위치 기반 검색 시)
  double? get distance => throw _privateConstructorUsedError; // 거리 (km)
// 북마크 여부
  bool get isBookmarked => throw _privateConstructorUsedError; // 캐시 정보
  DateTime? get cachedAt => throw _privateConstructorUsedError;

  /// Serializes this TourFestival to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TourFestival
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TourFestivalCopyWith<TourFestival> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TourFestivalCopyWith<$Res> {
  factory $TourFestivalCopyWith(
          TourFestival value, $Res Function(TourFestival) then) =
      _$TourFestivalCopyWithImpl<$Res, TourFestival>;
  @useResult
  $Res call(
      {String contentId,
      String title,
      String? address1,
      String? address2,
      String? areaCode,
      String? sigunguCode,
      double? mapX,
      double? mapY,
      String? firstImage,
      String? firstImage2,
      String? tel,
      String? eventStartDate,
      String? eventEndDate,
      String? eventPlace,
      String? playTime,
      String? sponsor1,
      String? sponsor1Tel,
      String? sponsor2,
      String? sponsor2Tel,
      String? useFee,
      String? homepage,
      String? overview,
      String? cat1,
      String? cat2,
      String? cat3,
      String? cpyrhtDivCd,
      String? createdTime,
      String? modifiedTime,
      int? mlevel,
      double? distance,
      bool isBookmarked,
      DateTime? cachedAt});
}

/// @nodoc
class _$TourFestivalCopyWithImpl<$Res, $Val extends TourFestival>
    implements $TourFestivalCopyWith<$Res> {
  _$TourFestivalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TourFestival
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? title = null,
    Object? address1 = freezed,
    Object? address2 = freezed,
    Object? areaCode = freezed,
    Object? sigunguCode = freezed,
    Object? mapX = freezed,
    Object? mapY = freezed,
    Object? firstImage = freezed,
    Object? firstImage2 = freezed,
    Object? tel = freezed,
    Object? eventStartDate = freezed,
    Object? eventEndDate = freezed,
    Object? eventPlace = freezed,
    Object? playTime = freezed,
    Object? sponsor1 = freezed,
    Object? sponsor1Tel = freezed,
    Object? sponsor2 = freezed,
    Object? sponsor2Tel = freezed,
    Object? useFee = freezed,
    Object? homepage = freezed,
    Object? overview = freezed,
    Object? cat1 = freezed,
    Object? cat2 = freezed,
    Object? cat3 = freezed,
    Object? cpyrhtDivCd = freezed,
    Object? createdTime = freezed,
    Object? modifiedTime = freezed,
    Object? mlevel = freezed,
    Object? distance = freezed,
    Object? isBookmarked = null,
    Object? cachedAt = freezed,
  }) {
    return _then(_value.copyWith(
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      address1: freezed == address1
          ? _value.address1
          : address1 // ignore: cast_nullable_to_non_nullable
              as String?,
      address2: freezed == address2
          ? _value.address2
          : address2 // ignore: cast_nullable_to_non_nullable
              as String?,
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      sigunguCode: freezed == sigunguCode
          ? _value.sigunguCode
          : sigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      mapX: freezed == mapX
          ? _value.mapX
          : mapX // ignore: cast_nullable_to_non_nullable
              as double?,
      mapY: freezed == mapY
          ? _value.mapY
          : mapY // ignore: cast_nullable_to_non_nullable
              as double?,
      firstImage: freezed == firstImage
          ? _value.firstImage
          : firstImage // ignore: cast_nullable_to_non_nullable
              as String?,
      firstImage2: freezed == firstImage2
          ? _value.firstImage2
          : firstImage2 // ignore: cast_nullable_to_non_nullable
              as String?,
      tel: freezed == tel
          ? _value.tel
          : tel // ignore: cast_nullable_to_non_nullable
              as String?,
      eventStartDate: freezed == eventStartDate
          ? _value.eventStartDate
          : eventStartDate // ignore: cast_nullable_to_non_nullable
              as String?,
      eventEndDate: freezed == eventEndDate
          ? _value.eventEndDate
          : eventEndDate // ignore: cast_nullable_to_non_nullable
              as String?,
      eventPlace: freezed == eventPlace
          ? _value.eventPlace
          : eventPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      playTime: freezed == playTime
          ? _value.playTime
          : playTime // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor1: freezed == sponsor1
          ? _value.sponsor1
          : sponsor1 // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor1Tel: freezed == sponsor1Tel
          ? _value.sponsor1Tel
          : sponsor1Tel // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor2: freezed == sponsor2
          ? _value.sponsor2
          : sponsor2 // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor2Tel: freezed == sponsor2Tel
          ? _value.sponsor2Tel
          : sponsor2Tel // ignore: cast_nullable_to_non_nullable
              as String?,
      useFee: freezed == useFee
          ? _value.useFee
          : useFee // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      cat1: freezed == cat1
          ? _value.cat1
          : cat1 // ignore: cast_nullable_to_non_nullable
              as String?,
      cat2: freezed == cat2
          ? _value.cat2
          : cat2 // ignore: cast_nullable_to_non_nullable
              as String?,
      cat3: freezed == cat3
          ? _value.cat3
          : cat3 // ignore: cast_nullable_to_non_nullable
              as String?,
      cpyrhtDivCd: freezed == cpyrhtDivCd
          ? _value.cpyrhtDivCd
          : cpyrhtDivCd // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedTime: freezed == modifiedTime
          ? _value.modifiedTime
          : modifiedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      mlevel: freezed == mlevel
          ? _value.mlevel
          : mlevel // ignore: cast_nullable_to_non_nullable
              as int?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      cachedAt: freezed == cachedAt
          ? _value.cachedAt
          : cachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TourFestivalImplCopyWith<$Res>
    implements $TourFestivalCopyWith<$Res> {
  factory _$$TourFestivalImplCopyWith(
          _$TourFestivalImpl value, $Res Function(_$TourFestivalImpl) then) =
      __$$TourFestivalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String contentId,
      String title,
      String? address1,
      String? address2,
      String? areaCode,
      String? sigunguCode,
      double? mapX,
      double? mapY,
      String? firstImage,
      String? firstImage2,
      String? tel,
      String? eventStartDate,
      String? eventEndDate,
      String? eventPlace,
      String? playTime,
      String? sponsor1,
      String? sponsor1Tel,
      String? sponsor2,
      String? sponsor2Tel,
      String? useFee,
      String? homepage,
      String? overview,
      String? cat1,
      String? cat2,
      String? cat3,
      String? cpyrhtDivCd,
      String? createdTime,
      String? modifiedTime,
      int? mlevel,
      double? distance,
      bool isBookmarked,
      DateTime? cachedAt});
}

/// @nodoc
class __$$TourFestivalImplCopyWithImpl<$Res>
    extends _$TourFestivalCopyWithImpl<$Res, _$TourFestivalImpl>
    implements _$$TourFestivalImplCopyWith<$Res> {
  __$$TourFestivalImplCopyWithImpl(
      _$TourFestivalImpl _value, $Res Function(_$TourFestivalImpl) _then)
      : super(_value, _then);

  /// Create a copy of TourFestival
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? title = null,
    Object? address1 = freezed,
    Object? address2 = freezed,
    Object? areaCode = freezed,
    Object? sigunguCode = freezed,
    Object? mapX = freezed,
    Object? mapY = freezed,
    Object? firstImage = freezed,
    Object? firstImage2 = freezed,
    Object? tel = freezed,
    Object? eventStartDate = freezed,
    Object? eventEndDate = freezed,
    Object? eventPlace = freezed,
    Object? playTime = freezed,
    Object? sponsor1 = freezed,
    Object? sponsor1Tel = freezed,
    Object? sponsor2 = freezed,
    Object? sponsor2Tel = freezed,
    Object? useFee = freezed,
    Object? homepage = freezed,
    Object? overview = freezed,
    Object? cat1 = freezed,
    Object? cat2 = freezed,
    Object? cat3 = freezed,
    Object? cpyrhtDivCd = freezed,
    Object? createdTime = freezed,
    Object? modifiedTime = freezed,
    Object? mlevel = freezed,
    Object? distance = freezed,
    Object? isBookmarked = null,
    Object? cachedAt = freezed,
  }) {
    return _then(_$TourFestivalImpl(
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      address1: freezed == address1
          ? _value.address1
          : address1 // ignore: cast_nullable_to_non_nullable
              as String?,
      address2: freezed == address2
          ? _value.address2
          : address2 // ignore: cast_nullable_to_non_nullable
              as String?,
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      sigunguCode: freezed == sigunguCode
          ? _value.sigunguCode
          : sigunguCode // ignore: cast_nullable_to_non_nullable
              as String?,
      mapX: freezed == mapX
          ? _value.mapX
          : mapX // ignore: cast_nullable_to_non_nullable
              as double?,
      mapY: freezed == mapY
          ? _value.mapY
          : mapY // ignore: cast_nullable_to_non_nullable
              as double?,
      firstImage: freezed == firstImage
          ? _value.firstImage
          : firstImage // ignore: cast_nullable_to_non_nullable
              as String?,
      firstImage2: freezed == firstImage2
          ? _value.firstImage2
          : firstImage2 // ignore: cast_nullable_to_non_nullable
              as String?,
      tel: freezed == tel
          ? _value.tel
          : tel // ignore: cast_nullable_to_non_nullable
              as String?,
      eventStartDate: freezed == eventStartDate
          ? _value.eventStartDate
          : eventStartDate // ignore: cast_nullable_to_non_nullable
              as String?,
      eventEndDate: freezed == eventEndDate
          ? _value.eventEndDate
          : eventEndDate // ignore: cast_nullable_to_non_nullable
              as String?,
      eventPlace: freezed == eventPlace
          ? _value.eventPlace
          : eventPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      playTime: freezed == playTime
          ? _value.playTime
          : playTime // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor1: freezed == sponsor1
          ? _value.sponsor1
          : sponsor1 // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor1Tel: freezed == sponsor1Tel
          ? _value.sponsor1Tel
          : sponsor1Tel // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor2: freezed == sponsor2
          ? _value.sponsor2
          : sponsor2 // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor2Tel: freezed == sponsor2Tel
          ? _value.sponsor2Tel
          : sponsor2Tel // ignore: cast_nullable_to_non_nullable
              as String?,
      useFee: freezed == useFee
          ? _value.useFee
          : useFee // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      cat1: freezed == cat1
          ? _value.cat1
          : cat1 // ignore: cast_nullable_to_non_nullable
              as String?,
      cat2: freezed == cat2
          ? _value.cat2
          : cat2 // ignore: cast_nullable_to_non_nullable
              as String?,
      cat3: freezed == cat3
          ? _value.cat3
          : cat3 // ignore: cast_nullable_to_non_nullable
              as String?,
      cpyrhtDivCd: freezed == cpyrhtDivCd
          ? _value.cpyrhtDivCd
          : cpyrhtDivCd // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedTime: freezed == modifiedTime
          ? _value.modifiedTime
          : modifiedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      mlevel: freezed == mlevel
          ? _value.mlevel
          : mlevel // ignore: cast_nullable_to_non_nullable
              as int?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      cachedAt: freezed == cachedAt
          ? _value.cachedAt
          : cachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TourFestivalImpl extends _TourFestival {
  const _$TourFestivalImpl(
      {required this.contentId,
      required this.title,
      this.address1,
      this.address2,
      this.areaCode,
      this.sigunguCode,
      this.mapX,
      this.mapY,
      this.firstImage,
      this.firstImage2,
      this.tel,
      this.eventStartDate,
      this.eventEndDate,
      this.eventPlace,
      this.playTime,
      this.sponsor1,
      this.sponsor1Tel,
      this.sponsor2,
      this.sponsor2Tel,
      this.useFee,
      this.homepage,
      this.overview,
      this.cat1,
      this.cat2,
      this.cat3,
      this.cpyrhtDivCd,
      this.createdTime,
      this.modifiedTime,
      this.mlevel,
      this.distance,
      this.isBookmarked = false,
      this.cachedAt})
      : super._();

  factory _$TourFestivalImpl.fromJson(Map<String, dynamic> json) =>
      _$$TourFestivalImplFromJson(json);

  @override
  final String contentId;
// Tour API 콘텐츠 ID
  @override
  final String title;
// 행사명
  @override
  final String? address1;
// 주소
  @override
  final String? address2;
// 상세 주소
  @override
  final String? areaCode;
// 지역 코드
  @override
  final String? sigunguCode;
// 시군구 코드
  @override
  final double? mapX;
// 경도
  @override
  final double? mapY;
// 위도
  @override
  final String? firstImage;
// 대표 이미지 원본
  @override
  final String? firstImage2;
// 대표 이미지 썸네일
  @override
  final String? tel;
// 전화번호
  @override
  final String? eventStartDate;
// 행사 시작일 (YYYYMMDD)
  @override
  final String? eventEndDate;
// 행사 종료일 (YYYYMMDD)
  @override
  final String? eventPlace;
// 행사 장소
  @override
  final String? playTime;
// 공연 시간
  @override
  final String? sponsor1;
// 주최자
  @override
  final String? sponsor1Tel;
// 주최자 연락처
  @override
  final String? sponsor2;
// 주관사
  @override
  final String? sponsor2Tel;
// 주관사 연락처
  @override
  final String? useFee;
// 이용 요금
  @override
  final String? homepage;
// 홈페이지
  @override
  final String? overview;
// 개요
  @override
  final String? cat1;
// 대분류
  @override
  final String? cat2;
// 중분류
  @override
  final String? cat3;
// 소분류
  @override
  final String? cpyrhtDivCd;
// 저작권 유형
  @override
  final String? createdTime;
// 생성일
  @override
  final String? modifiedTime;
// 수정일
  @override
  final int? mlevel;
// 지도 레벨
// 거리 정보 (위치 기반 검색 시)
  @override
  final double? distance;
// 거리 (km)
// 북마크 여부
  @override
  @JsonKey()
  final bool isBookmarked;
// 캐시 정보
  @override
  final DateTime? cachedAt;

  @override
  String toString() {
    return 'TourFestival(contentId: $contentId, title: $title, address1: $address1, address2: $address2, areaCode: $areaCode, sigunguCode: $sigunguCode, mapX: $mapX, mapY: $mapY, firstImage: $firstImage, firstImage2: $firstImage2, tel: $tel, eventStartDate: $eventStartDate, eventEndDate: $eventEndDate, eventPlace: $eventPlace, playTime: $playTime, sponsor1: $sponsor1, sponsor1Tel: $sponsor1Tel, sponsor2: $sponsor2, sponsor2Tel: $sponsor2Tel, useFee: $useFee, homepage: $homepage, overview: $overview, cat1: $cat1, cat2: $cat2, cat3: $cat3, cpyrhtDivCd: $cpyrhtDivCd, createdTime: $createdTime, modifiedTime: $modifiedTime, mlevel: $mlevel, distance: $distance, isBookmarked: $isBookmarked, cachedAt: $cachedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TourFestivalImpl &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.address1, address1) ||
                other.address1 == address1) &&
            (identical(other.address2, address2) ||
                other.address2 == address2) &&
            (identical(other.areaCode, areaCode) ||
                other.areaCode == areaCode) &&
            (identical(other.sigunguCode, sigunguCode) ||
                other.sigunguCode == sigunguCode) &&
            (identical(other.mapX, mapX) || other.mapX == mapX) &&
            (identical(other.mapY, mapY) || other.mapY == mapY) &&
            (identical(other.firstImage, firstImage) ||
                other.firstImage == firstImage) &&
            (identical(other.firstImage2, firstImage2) ||
                other.firstImage2 == firstImage2) &&
            (identical(other.tel, tel) || other.tel == tel) &&
            (identical(other.eventStartDate, eventStartDate) ||
                other.eventStartDate == eventStartDate) &&
            (identical(other.eventEndDate, eventEndDate) ||
                other.eventEndDate == eventEndDate) &&
            (identical(other.eventPlace, eventPlace) ||
                other.eventPlace == eventPlace) &&
            (identical(other.playTime, playTime) ||
                other.playTime == playTime) &&
            (identical(other.sponsor1, sponsor1) ||
                other.sponsor1 == sponsor1) &&
            (identical(other.sponsor1Tel, sponsor1Tel) ||
                other.sponsor1Tel == sponsor1Tel) &&
            (identical(other.sponsor2, sponsor2) ||
                other.sponsor2 == sponsor2) &&
            (identical(other.sponsor2Tel, sponsor2Tel) ||
                other.sponsor2Tel == sponsor2Tel) &&
            (identical(other.useFee, useFee) || other.useFee == useFee) &&
            (identical(other.homepage, homepage) ||
                other.homepage == homepage) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.cat1, cat1) || other.cat1 == cat1) &&
            (identical(other.cat2, cat2) || other.cat2 == cat2) &&
            (identical(other.cat3, cat3) || other.cat3 == cat3) &&
            (identical(other.cpyrhtDivCd, cpyrhtDivCd) ||
                other.cpyrhtDivCd == cpyrhtDivCd) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.modifiedTime, modifiedTime) ||
                other.modifiedTime == modifiedTime) &&
            (identical(other.mlevel, mlevel) || other.mlevel == mlevel) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.cachedAt, cachedAt) ||
                other.cachedAt == cachedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        contentId,
        title,
        address1,
        address2,
        areaCode,
        sigunguCode,
        mapX,
        mapY,
        firstImage,
        firstImage2,
        tel,
        eventStartDate,
        eventEndDate,
        eventPlace,
        playTime,
        sponsor1,
        sponsor1Tel,
        sponsor2,
        sponsor2Tel,
        useFee,
        homepage,
        overview,
        cat1,
        cat2,
        cat3,
        cpyrhtDivCd,
        createdTime,
        modifiedTime,
        mlevel,
        distance,
        isBookmarked,
        cachedAt
      ]);

  /// Create a copy of TourFestival
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TourFestivalImplCopyWith<_$TourFestivalImpl> get copyWith =>
      __$$TourFestivalImplCopyWithImpl<_$TourFestivalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TourFestivalImplToJson(
      this,
    );
  }
}

abstract class _TourFestival extends TourFestival {
  const factory _TourFestival(
      {required final String contentId,
      required final String title,
      final String? address1,
      final String? address2,
      final String? areaCode,
      final String? sigunguCode,
      final double? mapX,
      final double? mapY,
      final String? firstImage,
      final String? firstImage2,
      final String? tel,
      final String? eventStartDate,
      final String? eventEndDate,
      final String? eventPlace,
      final String? playTime,
      final String? sponsor1,
      final String? sponsor1Tel,
      final String? sponsor2,
      final String? sponsor2Tel,
      final String? useFee,
      final String? homepage,
      final String? overview,
      final String? cat1,
      final String? cat2,
      final String? cat3,
      final String? cpyrhtDivCd,
      final String? createdTime,
      final String? modifiedTime,
      final int? mlevel,
      final double? distance,
      final bool isBookmarked,
      final DateTime? cachedAt}) = _$TourFestivalImpl;
  const _TourFestival._() : super._();

  factory _TourFestival.fromJson(Map<String, dynamic> json) =
      _$TourFestivalImpl.fromJson;

  @override
  String get contentId; // Tour API 콘텐츠 ID
  @override
  String get title; // 행사명
  @override
  String? get address1; // 주소
  @override
  String? get address2; // 상세 주소
  @override
  String? get areaCode; // 지역 코드
  @override
  String? get sigunguCode; // 시군구 코드
  @override
  double? get mapX; // 경도
  @override
  double? get mapY; // 위도
  @override
  String? get firstImage; // 대표 이미지 원본
  @override
  String? get firstImage2; // 대표 이미지 썸네일
  @override
  String? get tel; // 전화번호
  @override
  String? get eventStartDate; // 행사 시작일 (YYYYMMDD)
  @override
  String? get eventEndDate; // 행사 종료일 (YYYYMMDD)
  @override
  String? get eventPlace; // 행사 장소
  @override
  String? get playTime; // 공연 시간
  @override
  String? get sponsor1; // 주최자
  @override
  String? get sponsor1Tel; // 주최자 연락처
  @override
  String? get sponsor2; // 주관사
  @override
  String? get sponsor2Tel; // 주관사 연락처
  @override
  String? get useFee; // 이용 요금
  @override
  String? get homepage; // 홈페이지
  @override
  String? get overview; // 개요
  @override
  String? get cat1; // 대분류
  @override
  String? get cat2; // 중분류
  @override
  String? get cat3; // 소분류
  @override
  String? get cpyrhtDivCd; // 저작권 유형
  @override
  String? get createdTime; // 생성일
  @override
  String? get modifiedTime; // 수정일
  @override
  int? get mlevel; // 지도 레벨
// 거리 정보 (위치 기반 검색 시)
  @override
  double? get distance; // 거리 (km)
// 북마크 여부
  @override
  bool get isBookmarked; // 캐시 정보
  @override
  DateTime? get cachedAt;

  /// Create a copy of TourFestival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TourFestivalImplCopyWith<_$TourFestivalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
