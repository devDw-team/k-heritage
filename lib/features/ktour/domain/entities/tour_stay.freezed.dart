// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tour_stay.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TourStay _$TourStayFromJson(Map<String, dynamic> json) {
  return _TourStay.fromJson(json);
}

/// @nodoc
mixin _$TourStay {
  String get contentId => throw _privateConstructorUsedError; // Tour API 콘텐츠 ID
  String get title => throw _privateConstructorUsedError; // 숙박시설명
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
  String? get homepage => throw _privateConstructorUsedError; // 홈페이지
  String? get overview => throw _privateConstructorUsedError; // 개요
// 숙박 상세 정보
  String? get checkInTime => throw _privateConstructorUsedError; // 체크인 시간
  String? get checkOutTime => throw _privateConstructorUsedError; // 체크아웃 시간
  String? get roomType => throw _privateConstructorUsedError; // 객실 유형
  int? get roomCount => throw _privateConstructorUsedError; // 객실 수
  String? get parking => throw _privateConstructorUsedError; // 주차 정보
  String? get reservationUrl => throw _privateConstructorUsedError; // 예약 URL
  String? get reservationTel => throw _privateConstructorUsedError; // 예약 전화번호
  String? get accomCount => throw _privateConstructorUsedError; // 수용 가능 인원
  String? get foodPlace => throw _privateConstructorUsedError; // 식음료장
  String? get pickup => throw _privateConstructorUsedError; // 픽업 서비스
  String? get cooking => throw _privateConstructorUsedError; // 객실 내 취사
  String? get barbecue => throw _privateConstructorUsedError; // 바비큐
  String? get fitness => throw _privateConstructorUsedError; // 휘트니스센터
  String? get sauna => throw _privateConstructorUsedError; // 사우나
  String? get publicBath => throw _privateConstructorUsedError; // 공용샤워실
  String? get publicPc => throw _privateConstructorUsedError; // 공용PC실
  String? get seminar => throw _privateConstructorUsedError; // 세미나실
  String? get sports => throw _privateConstructorUsedError; // 스포츠시설
  String? get refundPolicy => throw _privateConstructorUsedError; // 환불 규정
// 특별 속성
  bool? get hanOk => throw _privateConstructorUsedError; // 한옥 여부
  bool? get goodStay => throw _privateConstructorUsedError; // 굿스테이 여부
// 분류 정보
  String? get cat1 => throw _privateConstructorUsedError; // 대분류
  String? get cat2 => throw _privateConstructorUsedError; // 중분류
  String? get cat3 => throw _privateConstructorUsedError; // 소분류
// 메타 정보
  String? get createdTime => throw _privateConstructorUsedError; // 생성일
  String? get modifiedTime => throw _privateConstructorUsedError; // 수정일
  String? get cpyrhtDivCd => throw _privateConstructorUsedError; // 저작권 유형
  int? get mlevel => throw _privateConstructorUsedError; // 지도 레벨
// 거리 정보 (위치 기반 검색 시)
  double? get distance => throw _privateConstructorUsedError; // 거리 (km)
// 북마크 여부
  bool get isBookmarked => throw _privateConstructorUsedError; // 캐시 정보
  DateTime? get cachedAt => throw _privateConstructorUsedError;

  /// Serializes this TourStay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TourStay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TourStayCopyWith<TourStay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TourStayCopyWith<$Res> {
  factory $TourStayCopyWith(TourStay value, $Res Function(TourStay) then) =
      _$TourStayCopyWithImpl<$Res, TourStay>;
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
      String? zipCode,
      String? homepage,
      String? overview,
      String? checkInTime,
      String? checkOutTime,
      String? roomType,
      int? roomCount,
      String? parking,
      String? reservationUrl,
      String? reservationTel,
      String? accomCount,
      String? foodPlace,
      String? pickup,
      String? cooking,
      String? barbecue,
      String? fitness,
      String? sauna,
      String? publicBath,
      String? publicPc,
      String? seminar,
      String? sports,
      String? refundPolicy,
      bool? hanOk,
      bool? goodStay,
      String? cat1,
      String? cat2,
      String? cat3,
      String? createdTime,
      String? modifiedTime,
      String? cpyrhtDivCd,
      int? mlevel,
      double? distance,
      bool isBookmarked,
      DateTime? cachedAt});
}

/// @nodoc
class _$TourStayCopyWithImpl<$Res, $Val extends TourStay>
    implements $TourStayCopyWith<$Res> {
  _$TourStayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TourStay
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
    Object? zipCode = freezed,
    Object? homepage = freezed,
    Object? overview = freezed,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? roomType = freezed,
    Object? roomCount = freezed,
    Object? parking = freezed,
    Object? reservationUrl = freezed,
    Object? reservationTel = freezed,
    Object? accomCount = freezed,
    Object? foodPlace = freezed,
    Object? pickup = freezed,
    Object? cooking = freezed,
    Object? barbecue = freezed,
    Object? fitness = freezed,
    Object? sauna = freezed,
    Object? publicBath = freezed,
    Object? publicPc = freezed,
    Object? seminar = freezed,
    Object? sports = freezed,
    Object? refundPolicy = freezed,
    Object? hanOk = freezed,
    Object? goodStay = freezed,
    Object? cat1 = freezed,
    Object? cat2 = freezed,
    Object? cat3 = freezed,
    Object? createdTime = freezed,
    Object? modifiedTime = freezed,
    Object? cpyrhtDivCd = freezed,
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
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      checkInTime: freezed == checkInTime
          ? _value.checkInTime
          : checkInTime // ignore: cast_nullable_to_non_nullable
              as String?,
      checkOutTime: freezed == checkOutTime
          ? _value.checkOutTime
          : checkOutTime // ignore: cast_nullable_to_non_nullable
              as String?,
      roomType: freezed == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String?,
      roomCount: freezed == roomCount
          ? _value.roomCount
          : roomCount // ignore: cast_nullable_to_non_nullable
              as int?,
      parking: freezed == parking
          ? _value.parking
          : parking // ignore: cast_nullable_to_non_nullable
              as String?,
      reservationUrl: freezed == reservationUrl
          ? _value.reservationUrl
          : reservationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reservationTel: freezed == reservationTel
          ? _value.reservationTel
          : reservationTel // ignore: cast_nullable_to_non_nullable
              as String?,
      accomCount: freezed == accomCount
          ? _value.accomCount
          : accomCount // ignore: cast_nullable_to_non_nullable
              as String?,
      foodPlace: freezed == foodPlace
          ? _value.foodPlace
          : foodPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      pickup: freezed == pickup
          ? _value.pickup
          : pickup // ignore: cast_nullable_to_non_nullable
              as String?,
      cooking: freezed == cooking
          ? _value.cooking
          : cooking // ignore: cast_nullable_to_non_nullable
              as String?,
      barbecue: freezed == barbecue
          ? _value.barbecue
          : barbecue // ignore: cast_nullable_to_non_nullable
              as String?,
      fitness: freezed == fitness
          ? _value.fitness
          : fitness // ignore: cast_nullable_to_non_nullable
              as String?,
      sauna: freezed == sauna
          ? _value.sauna
          : sauna // ignore: cast_nullable_to_non_nullable
              as String?,
      publicBath: freezed == publicBath
          ? _value.publicBath
          : publicBath // ignore: cast_nullable_to_non_nullable
              as String?,
      publicPc: freezed == publicPc
          ? _value.publicPc
          : publicPc // ignore: cast_nullable_to_non_nullable
              as String?,
      seminar: freezed == seminar
          ? _value.seminar
          : seminar // ignore: cast_nullable_to_non_nullable
              as String?,
      sports: freezed == sports
          ? _value.sports
          : sports // ignore: cast_nullable_to_non_nullable
              as String?,
      refundPolicy: freezed == refundPolicy
          ? _value.refundPolicy
          : refundPolicy // ignore: cast_nullable_to_non_nullable
              as String?,
      hanOk: freezed == hanOk
          ? _value.hanOk
          : hanOk // ignore: cast_nullable_to_non_nullable
              as bool?,
      goodStay: freezed == goodStay
          ? _value.goodStay
          : goodStay // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedTime: freezed == modifiedTime
          ? _value.modifiedTime
          : modifiedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      cpyrhtDivCd: freezed == cpyrhtDivCd
          ? _value.cpyrhtDivCd
          : cpyrhtDivCd // ignore: cast_nullable_to_non_nullable
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
abstract class _$$TourStayImplCopyWith<$Res>
    implements $TourStayCopyWith<$Res> {
  factory _$$TourStayImplCopyWith(
          _$TourStayImpl value, $Res Function(_$TourStayImpl) then) =
      __$$TourStayImplCopyWithImpl<$Res>;
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
      String? zipCode,
      String? homepage,
      String? overview,
      String? checkInTime,
      String? checkOutTime,
      String? roomType,
      int? roomCount,
      String? parking,
      String? reservationUrl,
      String? reservationTel,
      String? accomCount,
      String? foodPlace,
      String? pickup,
      String? cooking,
      String? barbecue,
      String? fitness,
      String? sauna,
      String? publicBath,
      String? publicPc,
      String? seminar,
      String? sports,
      String? refundPolicy,
      bool? hanOk,
      bool? goodStay,
      String? cat1,
      String? cat2,
      String? cat3,
      String? createdTime,
      String? modifiedTime,
      String? cpyrhtDivCd,
      int? mlevel,
      double? distance,
      bool isBookmarked,
      DateTime? cachedAt});
}

/// @nodoc
class __$$TourStayImplCopyWithImpl<$Res>
    extends _$TourStayCopyWithImpl<$Res, _$TourStayImpl>
    implements _$$TourStayImplCopyWith<$Res> {
  __$$TourStayImplCopyWithImpl(
      _$TourStayImpl _value, $Res Function(_$TourStayImpl) _then)
      : super(_value, _then);

  /// Create a copy of TourStay
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
    Object? zipCode = freezed,
    Object? homepage = freezed,
    Object? overview = freezed,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? roomType = freezed,
    Object? roomCount = freezed,
    Object? parking = freezed,
    Object? reservationUrl = freezed,
    Object? reservationTel = freezed,
    Object? accomCount = freezed,
    Object? foodPlace = freezed,
    Object? pickup = freezed,
    Object? cooking = freezed,
    Object? barbecue = freezed,
    Object? fitness = freezed,
    Object? sauna = freezed,
    Object? publicBath = freezed,
    Object? publicPc = freezed,
    Object? seminar = freezed,
    Object? sports = freezed,
    Object? refundPolicy = freezed,
    Object? hanOk = freezed,
    Object? goodStay = freezed,
    Object? cat1 = freezed,
    Object? cat2 = freezed,
    Object? cat3 = freezed,
    Object? createdTime = freezed,
    Object? modifiedTime = freezed,
    Object? cpyrhtDivCd = freezed,
    Object? mlevel = freezed,
    Object? distance = freezed,
    Object? isBookmarked = null,
    Object? cachedAt = freezed,
  }) {
    return _then(_$TourStayImpl(
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
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      checkInTime: freezed == checkInTime
          ? _value.checkInTime
          : checkInTime // ignore: cast_nullable_to_non_nullable
              as String?,
      checkOutTime: freezed == checkOutTime
          ? _value.checkOutTime
          : checkOutTime // ignore: cast_nullable_to_non_nullable
              as String?,
      roomType: freezed == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String?,
      roomCount: freezed == roomCount
          ? _value.roomCount
          : roomCount // ignore: cast_nullable_to_non_nullable
              as int?,
      parking: freezed == parking
          ? _value.parking
          : parking // ignore: cast_nullable_to_non_nullable
              as String?,
      reservationUrl: freezed == reservationUrl
          ? _value.reservationUrl
          : reservationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reservationTel: freezed == reservationTel
          ? _value.reservationTel
          : reservationTel // ignore: cast_nullable_to_non_nullable
              as String?,
      accomCount: freezed == accomCount
          ? _value.accomCount
          : accomCount // ignore: cast_nullable_to_non_nullable
              as String?,
      foodPlace: freezed == foodPlace
          ? _value.foodPlace
          : foodPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      pickup: freezed == pickup
          ? _value.pickup
          : pickup // ignore: cast_nullable_to_non_nullable
              as String?,
      cooking: freezed == cooking
          ? _value.cooking
          : cooking // ignore: cast_nullable_to_non_nullable
              as String?,
      barbecue: freezed == barbecue
          ? _value.barbecue
          : barbecue // ignore: cast_nullable_to_non_nullable
              as String?,
      fitness: freezed == fitness
          ? _value.fitness
          : fitness // ignore: cast_nullable_to_non_nullable
              as String?,
      sauna: freezed == sauna
          ? _value.sauna
          : sauna // ignore: cast_nullable_to_non_nullable
              as String?,
      publicBath: freezed == publicBath
          ? _value.publicBath
          : publicBath // ignore: cast_nullable_to_non_nullable
              as String?,
      publicPc: freezed == publicPc
          ? _value.publicPc
          : publicPc // ignore: cast_nullable_to_non_nullable
              as String?,
      seminar: freezed == seminar
          ? _value.seminar
          : seminar // ignore: cast_nullable_to_non_nullable
              as String?,
      sports: freezed == sports
          ? _value.sports
          : sports // ignore: cast_nullable_to_non_nullable
              as String?,
      refundPolicy: freezed == refundPolicy
          ? _value.refundPolicy
          : refundPolicy // ignore: cast_nullable_to_non_nullable
              as String?,
      hanOk: freezed == hanOk
          ? _value.hanOk
          : hanOk // ignore: cast_nullable_to_non_nullable
              as bool?,
      goodStay: freezed == goodStay
          ? _value.goodStay
          : goodStay // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedTime: freezed == modifiedTime
          ? _value.modifiedTime
          : modifiedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      cpyrhtDivCd: freezed == cpyrhtDivCd
          ? _value.cpyrhtDivCd
          : cpyrhtDivCd // ignore: cast_nullable_to_non_nullable
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
class _$TourStayImpl extends _TourStay {
  const _$TourStayImpl(
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
      this.zipCode,
      this.homepage,
      this.overview,
      this.checkInTime,
      this.checkOutTime,
      this.roomType,
      this.roomCount,
      this.parking,
      this.reservationUrl,
      this.reservationTel,
      this.accomCount,
      this.foodPlace,
      this.pickup,
      this.cooking,
      this.barbecue,
      this.fitness,
      this.sauna,
      this.publicBath,
      this.publicPc,
      this.seminar,
      this.sports,
      this.refundPolicy,
      this.hanOk,
      this.goodStay,
      this.cat1,
      this.cat2,
      this.cat3,
      this.createdTime,
      this.modifiedTime,
      this.cpyrhtDivCd,
      this.mlevel,
      this.distance,
      this.isBookmarked = false,
      this.cachedAt})
      : super._();

  factory _$TourStayImpl.fromJson(Map<String, dynamic> json) =>
      _$$TourStayImplFromJson(json);

  @override
  final String contentId;
// Tour API 콘텐츠 ID
  @override
  final String title;
// 숙박시설명
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
  @override
  final String? homepage;
// 홈페이지
  @override
  final String? overview;
// 개요
// 숙박 상세 정보
  @override
  final String? checkInTime;
// 체크인 시간
  @override
  final String? checkOutTime;
// 체크아웃 시간
  @override
  final String? roomType;
// 객실 유형
  @override
  final int? roomCount;
// 객실 수
  @override
  final String? parking;
// 주차 정보
  @override
  final String? reservationUrl;
// 예약 URL
  @override
  final String? reservationTel;
// 예약 전화번호
  @override
  final String? accomCount;
// 수용 가능 인원
  @override
  final String? foodPlace;
// 식음료장
  @override
  final String? pickup;
// 픽업 서비스
  @override
  final String? cooking;
// 객실 내 취사
  @override
  final String? barbecue;
// 바비큐
  @override
  final String? fitness;
// 휘트니스센터
  @override
  final String? sauna;
// 사우나
  @override
  final String? publicBath;
// 공용샤워실
  @override
  final String? publicPc;
// 공용PC실
  @override
  final String? seminar;
// 세미나실
  @override
  final String? sports;
// 스포츠시설
  @override
  final String? refundPolicy;
// 환불 규정
// 특별 속성
  @override
  final bool? hanOk;
// 한옥 여부
  @override
  final bool? goodStay;
// 굿스테이 여부
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
// 메타 정보
  @override
  final String? createdTime;
// 생성일
  @override
  final String? modifiedTime;
// 수정일
  @override
  final String? cpyrhtDivCd;
// 저작권 유형
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
    return 'TourStay(contentId: $contentId, title: $title, address1: $address1, address2: $address2, areaCode: $areaCode, sigunguCode: $sigunguCode, mapX: $mapX, mapY: $mapY, firstImage: $firstImage, firstImage2: $firstImage2, tel: $tel, zipCode: $zipCode, homepage: $homepage, overview: $overview, checkInTime: $checkInTime, checkOutTime: $checkOutTime, roomType: $roomType, roomCount: $roomCount, parking: $parking, reservationUrl: $reservationUrl, reservationTel: $reservationTel, accomCount: $accomCount, foodPlace: $foodPlace, pickup: $pickup, cooking: $cooking, barbecue: $barbecue, fitness: $fitness, sauna: $sauna, publicBath: $publicBath, publicPc: $publicPc, seminar: $seminar, sports: $sports, refundPolicy: $refundPolicy, hanOk: $hanOk, goodStay: $goodStay, cat1: $cat1, cat2: $cat2, cat3: $cat3, createdTime: $createdTime, modifiedTime: $modifiedTime, cpyrhtDivCd: $cpyrhtDivCd, mlevel: $mlevel, distance: $distance, isBookmarked: $isBookmarked, cachedAt: $cachedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TourStayImpl &&
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
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.homepage, homepage) ||
                other.homepage == homepage) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.checkInTime, checkInTime) ||
                other.checkInTime == checkInTime) &&
            (identical(other.checkOutTime, checkOutTime) ||
                other.checkOutTime == checkOutTime) &&
            (identical(other.roomType, roomType) ||
                other.roomType == roomType) &&
            (identical(other.roomCount, roomCount) ||
                other.roomCount == roomCount) &&
            (identical(other.parking, parking) || other.parking == parking) &&
            (identical(other.reservationUrl, reservationUrl) ||
                other.reservationUrl == reservationUrl) &&
            (identical(other.reservationTel, reservationTel) ||
                other.reservationTel == reservationTel) &&
            (identical(other.accomCount, accomCount) ||
                other.accomCount == accomCount) &&
            (identical(other.foodPlace, foodPlace) ||
                other.foodPlace == foodPlace) &&
            (identical(other.pickup, pickup) || other.pickup == pickup) &&
            (identical(other.cooking, cooking) || other.cooking == cooking) &&
            (identical(other.barbecue, barbecue) ||
                other.barbecue == barbecue) &&
            (identical(other.fitness, fitness) || other.fitness == fitness) &&
            (identical(other.sauna, sauna) || other.sauna == sauna) &&
            (identical(other.publicBath, publicBath) ||
                other.publicBath == publicBath) &&
            (identical(other.publicPc, publicPc) ||
                other.publicPc == publicPc) &&
            (identical(other.seminar, seminar) || other.seminar == seminar) &&
            (identical(other.sports, sports) || other.sports == sports) &&
            (identical(other.refundPolicy, refundPolicy) ||
                other.refundPolicy == refundPolicy) &&
            (identical(other.hanOk, hanOk) || other.hanOk == hanOk) &&
            (identical(other.goodStay, goodStay) ||
                other.goodStay == goodStay) &&
            (identical(other.cat1, cat1) || other.cat1 == cat1) &&
            (identical(other.cat2, cat2) || other.cat2 == cat2) &&
            (identical(other.cat3, cat3) || other.cat3 == cat3) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.modifiedTime, modifiedTime) ||
                other.modifiedTime == modifiedTime) &&
            (identical(other.cpyrhtDivCd, cpyrhtDivCd) ||
                other.cpyrhtDivCd == cpyrhtDivCd) &&
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
        zipCode,
        homepage,
        overview,
        checkInTime,
        checkOutTime,
        roomType,
        roomCount,
        parking,
        reservationUrl,
        reservationTel,
        accomCount,
        foodPlace,
        pickup,
        cooking,
        barbecue,
        fitness,
        sauna,
        publicBath,
        publicPc,
        seminar,
        sports,
        refundPolicy,
        hanOk,
        goodStay,
        cat1,
        cat2,
        cat3,
        createdTime,
        modifiedTime,
        cpyrhtDivCd,
        mlevel,
        distance,
        isBookmarked,
        cachedAt
      ]);

  /// Create a copy of TourStay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TourStayImplCopyWith<_$TourStayImpl> get copyWith =>
      __$$TourStayImplCopyWithImpl<_$TourStayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TourStayImplToJson(
      this,
    );
  }
}

abstract class _TourStay extends TourStay {
  const factory _TourStay(
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
      final String? zipCode,
      final String? homepage,
      final String? overview,
      final String? checkInTime,
      final String? checkOutTime,
      final String? roomType,
      final int? roomCount,
      final String? parking,
      final String? reservationUrl,
      final String? reservationTel,
      final String? accomCount,
      final String? foodPlace,
      final String? pickup,
      final String? cooking,
      final String? barbecue,
      final String? fitness,
      final String? sauna,
      final String? publicBath,
      final String? publicPc,
      final String? seminar,
      final String? sports,
      final String? refundPolicy,
      final bool? hanOk,
      final bool? goodStay,
      final String? cat1,
      final String? cat2,
      final String? cat3,
      final String? createdTime,
      final String? modifiedTime,
      final String? cpyrhtDivCd,
      final int? mlevel,
      final double? distance,
      final bool isBookmarked,
      final DateTime? cachedAt}) = _$TourStayImpl;
  const _TourStay._() : super._();

  factory _TourStay.fromJson(Map<String, dynamic> json) =
      _$TourStayImpl.fromJson;

  @override
  String get contentId; // Tour API 콘텐츠 ID
  @override
  String get title; // 숙박시설명
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
  @override
  String? get homepage; // 홈페이지
  @override
  String? get overview; // 개요
// 숙박 상세 정보
  @override
  String? get checkInTime; // 체크인 시간
  @override
  String? get checkOutTime; // 체크아웃 시간
  @override
  String? get roomType; // 객실 유형
  @override
  int? get roomCount; // 객실 수
  @override
  String? get parking; // 주차 정보
  @override
  String? get reservationUrl; // 예약 URL
  @override
  String? get reservationTel; // 예약 전화번호
  @override
  String? get accomCount; // 수용 가능 인원
  @override
  String? get foodPlace; // 식음료장
  @override
  String? get pickup; // 픽업 서비스
  @override
  String? get cooking; // 객실 내 취사
  @override
  String? get barbecue; // 바비큐
  @override
  String? get fitness; // 휘트니스센터
  @override
  String? get sauna; // 사우나
  @override
  String? get publicBath; // 공용샤워실
  @override
  String? get publicPc; // 공용PC실
  @override
  String? get seminar; // 세미나실
  @override
  String? get sports; // 스포츠시설
  @override
  String? get refundPolicy; // 환불 규정
// 특별 속성
  @override
  bool? get hanOk; // 한옥 여부
  @override
  bool? get goodStay; // 굿스테이 여부
// 분류 정보
  @override
  String? get cat1; // 대분류
  @override
  String? get cat2; // 중분류
  @override
  String? get cat3; // 소분류
// 메타 정보
  @override
  String? get createdTime; // 생성일
  @override
  String? get modifiedTime; // 수정일
  @override
  String? get cpyrhtDivCd; // 저작권 유형
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

  /// Create a copy of TourStay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TourStayImplCopyWith<_$TourStayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
