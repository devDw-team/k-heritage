// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tour_attraction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TourAttraction _$TourAttractionFromJson(Map<String, dynamic> json) {
  return _TourAttraction.fromJson(json);
}

/// @nodoc
mixin _$TourAttraction {
  String get contentId => throw _privateConstructorUsedError; // Tour API 콘텐츠 ID
  int get contentTypeId =>
      throw _privateConstructorUsedError; // 콘텐츠 타입 (12: 관광지, 14: 문화시설 등)
  String get title => throw _privateConstructorUsedError; // 관광지명
  String? get address1 => throw _privateConstructorUsedError; // 주소
  String? get address2 => throw _privateConstructorUsedError; // 상세 주소
  String? get areaCode => throw _privateConstructorUsedError; // 지역 코드
  String? get sigunguCode => throw _privateConstructorUsedError; // 시군구 코드
  double? get mapX => throw _privateConstructorUsedError; // 경도
  double? get mapY => throw _privateConstructorUsedError; // 위도
  String? get firstImage => throw _privateConstructorUsedError; // 대표 이미지 원본
  String? get firstImage2 => throw _privateConstructorUsedError; // 대표 이미지 썸네일
  String? get tel => throw _privateConstructorUsedError; // 전화번호
  String? get zipCode => throw _privateConstructorUsedError; // 우편번호
// 분류 정보
  String? get cat1 => throw _privateConstructorUsedError; // 대분류
  String? get cat2 => throw _privateConstructorUsedError; // 중분류
  String? get cat3 => throw _privateConstructorUsedError; // 소분류
// 상세 정보
  String? get overview => throw _privateConstructorUsedError; // 개요
  String? get homepage => throw _privateConstructorUsedError; // 홈페이지
// 메타 정보
  String? get createdTime => throw _privateConstructorUsedError; // 생성일
  String? get modifiedTime => throw _privateConstructorUsedError; // 수정일
  int? get mlevel => throw _privateConstructorUsedError; // 지도 레벨
// 저작권
  String? get cpyrhtDivCd => throw _privateConstructorUsedError; // 저작권 유형
// 추가 정보 (detailIntro2에서 가져올 정보들)
  String? get openTime => throw _privateConstructorUsedError; // 운영 시간
  String? get restDate => throw _privateConstructorUsedError; // 휴무일
  String? get useFee => throw _privateConstructorUsedError; // 이용 요금
  String? get spendTime => throw _privateConstructorUsedError; // 관람 소요시간
  String? get parking => throw _privateConstructorUsedError; // 주차 정보
  String? get infocenter => throw _privateConstructorUsedError; // 문의처
  String? get disability => throw _privateConstructorUsedError; // 장애인 편의시설
  String? get stroller => throw _privateConstructorUsedError; // 유모차 대여
  String? get pet => throw _privateConstructorUsedError; // 반려동물 동반
  String? get creditcard => throw _privateConstructorUsedError; // 신용카드 사용
// 거리 정보 (위치 기반 검색 시)
  double? get distance => throw _privateConstructorUsedError; // 거리 (km)
// 북마크 여부
  bool get isBookmarked => throw _privateConstructorUsedError; // 캐시 정보
  DateTime? get cachedAt => throw _privateConstructorUsedError;

  /// Serializes this TourAttraction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TourAttraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TourAttractionCopyWith<TourAttraction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TourAttractionCopyWith<$Res> {
  factory $TourAttractionCopyWith(
          TourAttraction value, $Res Function(TourAttraction) then) =
      _$TourAttractionCopyWithImpl<$Res, TourAttraction>;
  @useResult
  $Res call(
      {String contentId,
      int contentTypeId,
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
      String? zipCode,
      String? cat1,
      String? cat2,
      String? cat3,
      String? overview,
      String? homepage,
      String? createdTime,
      String? modifiedTime,
      int? mlevel,
      String? cpyrhtDivCd,
      String? openTime,
      String? restDate,
      String? useFee,
      String? spendTime,
      String? parking,
      String? infocenter,
      String? disability,
      String? stroller,
      String? pet,
      String? creditcard,
      double? distance,
      bool isBookmarked,
      DateTime? cachedAt});
}

/// @nodoc
class _$TourAttractionCopyWithImpl<$Res, $Val extends TourAttraction>
    implements $TourAttractionCopyWith<$Res> {
  _$TourAttractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TourAttraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? contentTypeId = null,
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
    Object? zipCode = freezed,
    Object? cat1 = freezed,
    Object? cat2 = freezed,
    Object? cat3 = freezed,
    Object? overview = freezed,
    Object? homepage = freezed,
    Object? createdTime = freezed,
    Object? modifiedTime = freezed,
    Object? mlevel = freezed,
    Object? cpyrhtDivCd = freezed,
    Object? openTime = freezed,
    Object? restDate = freezed,
    Object? useFee = freezed,
    Object? spendTime = freezed,
    Object? parking = freezed,
    Object? infocenter = freezed,
    Object? disability = freezed,
    Object? stroller = freezed,
    Object? pet = freezed,
    Object? creditcard = freezed,
    Object? distance = freezed,
    Object? isBookmarked = null,
    Object? cachedAt = freezed,
  }) {
    return _then(_value.copyWith(
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      contentTypeId: null == contentTypeId
          ? _value.contentTypeId
          : contentTypeId // ignore: cast_nullable_to_non_nullable
              as int,
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
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
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
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
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
      cpyrhtDivCd: freezed == cpyrhtDivCd
          ? _value.cpyrhtDivCd
          : cpyrhtDivCd // ignore: cast_nullable_to_non_nullable
              as String?,
      openTime: freezed == openTime
          ? _value.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String?,
      restDate: freezed == restDate
          ? _value.restDate
          : restDate // ignore: cast_nullable_to_non_nullable
              as String?,
      useFee: freezed == useFee
          ? _value.useFee
          : useFee // ignore: cast_nullable_to_non_nullable
              as String?,
      spendTime: freezed == spendTime
          ? _value.spendTime
          : spendTime // ignore: cast_nullable_to_non_nullable
              as String?,
      parking: freezed == parking
          ? _value.parking
          : parking // ignore: cast_nullable_to_non_nullable
              as String?,
      infocenter: freezed == infocenter
          ? _value.infocenter
          : infocenter // ignore: cast_nullable_to_non_nullable
              as String?,
      disability: freezed == disability
          ? _value.disability
          : disability // ignore: cast_nullable_to_non_nullable
              as String?,
      stroller: freezed == stroller
          ? _value.stroller
          : stroller // ignore: cast_nullable_to_non_nullable
              as String?,
      pet: freezed == pet
          ? _value.pet
          : pet // ignore: cast_nullable_to_non_nullable
              as String?,
      creditcard: freezed == creditcard
          ? _value.creditcard
          : creditcard // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$TourAttractionImplCopyWith<$Res>
    implements $TourAttractionCopyWith<$Res> {
  factory _$$TourAttractionImplCopyWith(_$TourAttractionImpl value,
          $Res Function(_$TourAttractionImpl) then) =
      __$$TourAttractionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String contentId,
      int contentTypeId,
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
      String? zipCode,
      String? cat1,
      String? cat2,
      String? cat3,
      String? overview,
      String? homepage,
      String? createdTime,
      String? modifiedTime,
      int? mlevel,
      String? cpyrhtDivCd,
      String? openTime,
      String? restDate,
      String? useFee,
      String? spendTime,
      String? parking,
      String? infocenter,
      String? disability,
      String? stroller,
      String? pet,
      String? creditcard,
      double? distance,
      bool isBookmarked,
      DateTime? cachedAt});
}

/// @nodoc
class __$$TourAttractionImplCopyWithImpl<$Res>
    extends _$TourAttractionCopyWithImpl<$Res, _$TourAttractionImpl>
    implements _$$TourAttractionImplCopyWith<$Res> {
  __$$TourAttractionImplCopyWithImpl(
      _$TourAttractionImpl _value, $Res Function(_$TourAttractionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TourAttraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? contentTypeId = null,
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
    Object? zipCode = freezed,
    Object? cat1 = freezed,
    Object? cat2 = freezed,
    Object? cat3 = freezed,
    Object? overview = freezed,
    Object? homepage = freezed,
    Object? createdTime = freezed,
    Object? modifiedTime = freezed,
    Object? mlevel = freezed,
    Object? cpyrhtDivCd = freezed,
    Object? openTime = freezed,
    Object? restDate = freezed,
    Object? useFee = freezed,
    Object? spendTime = freezed,
    Object? parking = freezed,
    Object? infocenter = freezed,
    Object? disability = freezed,
    Object? stroller = freezed,
    Object? pet = freezed,
    Object? creditcard = freezed,
    Object? distance = freezed,
    Object? isBookmarked = null,
    Object? cachedAt = freezed,
  }) {
    return _then(_$TourAttractionImpl(
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      contentTypeId: null == contentTypeId
          ? _value.contentTypeId
          : contentTypeId // ignore: cast_nullable_to_non_nullable
              as int,
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
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
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
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
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
      cpyrhtDivCd: freezed == cpyrhtDivCd
          ? _value.cpyrhtDivCd
          : cpyrhtDivCd // ignore: cast_nullable_to_non_nullable
              as String?,
      openTime: freezed == openTime
          ? _value.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String?,
      restDate: freezed == restDate
          ? _value.restDate
          : restDate // ignore: cast_nullable_to_non_nullable
              as String?,
      useFee: freezed == useFee
          ? _value.useFee
          : useFee // ignore: cast_nullable_to_non_nullable
              as String?,
      spendTime: freezed == spendTime
          ? _value.spendTime
          : spendTime // ignore: cast_nullable_to_non_nullable
              as String?,
      parking: freezed == parking
          ? _value.parking
          : parking // ignore: cast_nullable_to_non_nullable
              as String?,
      infocenter: freezed == infocenter
          ? _value.infocenter
          : infocenter // ignore: cast_nullable_to_non_nullable
              as String?,
      disability: freezed == disability
          ? _value.disability
          : disability // ignore: cast_nullable_to_non_nullable
              as String?,
      stroller: freezed == stroller
          ? _value.stroller
          : stroller // ignore: cast_nullable_to_non_nullable
              as String?,
      pet: freezed == pet
          ? _value.pet
          : pet // ignore: cast_nullable_to_non_nullable
              as String?,
      creditcard: freezed == creditcard
          ? _value.creditcard
          : creditcard // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$TourAttractionImpl extends _TourAttraction {
  const _$TourAttractionImpl(
      {required this.contentId,
      required this.contentTypeId,
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
      this.zipCode,
      this.cat1,
      this.cat2,
      this.cat3,
      this.overview,
      this.homepage,
      this.createdTime,
      this.modifiedTime,
      this.mlevel,
      this.cpyrhtDivCd,
      this.openTime,
      this.restDate,
      this.useFee,
      this.spendTime,
      this.parking,
      this.infocenter,
      this.disability,
      this.stroller,
      this.pet,
      this.creditcard,
      this.distance,
      this.isBookmarked = false,
      this.cachedAt})
      : super._();

  factory _$TourAttractionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TourAttractionImplFromJson(json);

  @override
  final String contentId;
// Tour API 콘텐츠 ID
  @override
  final int contentTypeId;
// 콘텐츠 타입 (12: 관광지, 14: 문화시설 등)
  @override
  final String title;
// 관광지명
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
  final String? zipCode;
// 우편번호
// 분류 정보
  @override
  final String? cat1;
// 대분류
  @override
  final String? cat2;
// 중분류
  @override
  final String? cat3;
// 소분류
// 상세 정보
  @override
  final String? overview;
// 개요
  @override
  final String? homepage;
// 홈페이지
// 메타 정보
  @override
  final String? createdTime;
// 생성일
  @override
  final String? modifiedTime;
// 수정일
  @override
  final int? mlevel;
// 지도 레벨
// 저작권
  @override
  final String? cpyrhtDivCd;
// 저작권 유형
// 추가 정보 (detailIntro2에서 가져올 정보들)
  @override
  final String? openTime;
// 운영 시간
  @override
  final String? restDate;
// 휴무일
  @override
  final String? useFee;
// 이용 요금
  @override
  final String? spendTime;
// 관람 소요시간
  @override
  final String? parking;
// 주차 정보
  @override
  final String? infocenter;
// 문의처
  @override
  final String? disability;
// 장애인 편의시설
  @override
  final String? stroller;
// 유모차 대여
  @override
  final String? pet;
// 반려동물 동반
  @override
  final String? creditcard;
// 신용카드 사용
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
    return 'TourAttraction(contentId: $contentId, contentTypeId: $contentTypeId, title: $title, address1: $address1, address2: $address2, areaCode: $areaCode, sigunguCode: $sigunguCode, mapX: $mapX, mapY: $mapY, firstImage: $firstImage, firstImage2: $firstImage2, tel: $tel, zipCode: $zipCode, cat1: $cat1, cat2: $cat2, cat3: $cat3, overview: $overview, homepage: $homepage, createdTime: $createdTime, modifiedTime: $modifiedTime, mlevel: $mlevel, cpyrhtDivCd: $cpyrhtDivCd, openTime: $openTime, restDate: $restDate, useFee: $useFee, spendTime: $spendTime, parking: $parking, infocenter: $infocenter, disability: $disability, stroller: $stroller, pet: $pet, creditcard: $creditcard, distance: $distance, isBookmarked: $isBookmarked, cachedAt: $cachedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TourAttractionImpl &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.contentTypeId, contentTypeId) ||
                other.contentTypeId == contentTypeId) &&
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
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.cat1, cat1) || other.cat1 == cat1) &&
            (identical(other.cat2, cat2) || other.cat2 == cat2) &&
            (identical(other.cat3, cat3) || other.cat3 == cat3) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.homepage, homepage) ||
                other.homepage == homepage) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.modifiedTime, modifiedTime) ||
                other.modifiedTime == modifiedTime) &&
            (identical(other.mlevel, mlevel) || other.mlevel == mlevel) &&
            (identical(other.cpyrhtDivCd, cpyrhtDivCd) ||
                other.cpyrhtDivCd == cpyrhtDivCd) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.restDate, restDate) ||
                other.restDate == restDate) &&
            (identical(other.useFee, useFee) || other.useFee == useFee) &&
            (identical(other.spendTime, spendTime) ||
                other.spendTime == spendTime) &&
            (identical(other.parking, parking) || other.parking == parking) &&
            (identical(other.infocenter, infocenter) ||
                other.infocenter == infocenter) &&
            (identical(other.disability, disability) ||
                other.disability == disability) &&
            (identical(other.stroller, stroller) ||
                other.stroller == stroller) &&
            (identical(other.pet, pet) || other.pet == pet) &&
            (identical(other.creditcard, creditcard) ||
                other.creditcard == creditcard) &&
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
        contentTypeId,
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
        zipCode,
        cat1,
        cat2,
        cat3,
        overview,
        homepage,
        createdTime,
        modifiedTime,
        mlevel,
        cpyrhtDivCd,
        openTime,
        restDate,
        useFee,
        spendTime,
        parking,
        infocenter,
        disability,
        stroller,
        pet,
        creditcard,
        distance,
        isBookmarked,
        cachedAt
      ]);

  /// Create a copy of TourAttraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TourAttractionImplCopyWith<_$TourAttractionImpl> get copyWith =>
      __$$TourAttractionImplCopyWithImpl<_$TourAttractionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TourAttractionImplToJson(
      this,
    );
  }
}

abstract class _TourAttraction extends TourAttraction {
  const factory _TourAttraction(
      {required final String contentId,
      required final int contentTypeId,
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
      final String? zipCode,
      final String? cat1,
      final String? cat2,
      final String? cat3,
      final String? overview,
      final String? homepage,
      final String? createdTime,
      final String? modifiedTime,
      final int? mlevel,
      final String? cpyrhtDivCd,
      final String? openTime,
      final String? restDate,
      final String? useFee,
      final String? spendTime,
      final String? parking,
      final String? infocenter,
      final String? disability,
      final String? stroller,
      final String? pet,
      final String? creditcard,
      final double? distance,
      final bool isBookmarked,
      final DateTime? cachedAt}) = _$TourAttractionImpl;
  const _TourAttraction._() : super._();

  factory _TourAttraction.fromJson(Map<String, dynamic> json) =
      _$TourAttractionImpl.fromJson;

  @override
  String get contentId; // Tour API 콘텐츠 ID
  @override
  int get contentTypeId; // 콘텐츠 타입 (12: 관광지, 14: 문화시설 등)
  @override
  String get title; // 관광지명
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
  String? get zipCode; // 우편번호
// 분류 정보
  @override
  String? get cat1; // 대분류
  @override
  String? get cat2; // 중분류
  @override
  String? get cat3; // 소분류
// 상세 정보
  @override
  String? get overview; // 개요
  @override
  String? get homepage; // 홈페이지
// 메타 정보
  @override
  String? get createdTime; // 생성일
  @override
  String? get modifiedTime; // 수정일
  @override
  int? get mlevel; // 지도 레벨
// 저작권
  @override
  String? get cpyrhtDivCd; // 저작권 유형
// 추가 정보 (detailIntro2에서 가져올 정보들)
  @override
  String? get openTime; // 운영 시간
  @override
  String? get restDate; // 휴무일
  @override
  String? get useFee; // 이용 요금
  @override
  String? get spendTime; // 관람 소요시간
  @override
  String? get parking; // 주차 정보
  @override
  String? get infocenter; // 문의처
  @override
  String? get disability; // 장애인 편의시설
  @override
  String? get stroller; // 유모차 대여
  @override
  String? get pet; // 반려동물 동반
  @override
  String? get creditcard; // 신용카드 사용
// 거리 정보 (위치 기반 검색 시)
  @override
  double? get distance; // 거리 (km)
// 북마크 여부
  @override
  bool get isBookmarked; // 캐시 정보
  @override
  DateTime? get cachedAt;

  /// Create a copy of TourAttraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TourAttractionImplCopyWith<_$TourAttractionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
