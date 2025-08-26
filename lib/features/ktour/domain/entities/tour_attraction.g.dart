// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_attraction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TourAttractionImpl _$$TourAttractionImplFromJson(Map<String, dynamic> json) =>
    _$TourAttractionImpl(
      contentId: json['contentId'] as String,
      contentTypeId: (json['contentTypeId'] as num).toInt(),
      title: json['title'] as String,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      areaCode: json['areaCode'] as String?,
      sigunguCode: json['sigunguCode'] as String?,
      mapX: (json['mapX'] as num?)?.toDouble(),
      mapY: (json['mapY'] as num?)?.toDouble(),
      firstImage: json['firstImage'] as String?,
      firstImage2: json['firstImage2'] as String?,
      tel: json['tel'] as String?,
      zipCode: json['zipCode'] as String?,
      cat1: json['cat1'] as String?,
      cat2: json['cat2'] as String?,
      cat3: json['cat3'] as String?,
      overview: json['overview'] as String?,
      homepage: json['homepage'] as String?,
      createdTime: json['createdTime'] as String?,
      modifiedTime: json['modifiedTime'] as String?,
      mlevel: (json['mlevel'] as num?)?.toInt(),
      cpyrhtDivCd: json['cpyrhtDivCd'] as String?,
      openTime: json['openTime'] as String?,
      restDate: json['restDate'] as String?,
      useFee: json['useFee'] as String?,
      spendTime: json['spendTime'] as String?,
      parking: json['parking'] as String?,
      infocenter: json['infocenter'] as String?,
      disability: json['disability'] as String?,
      stroller: json['stroller'] as String?,
      pet: json['pet'] as String?,
      creditcard: json['creditcard'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      cachedAt: json['cachedAt'] == null
          ? null
          : DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$$TourAttractionImplToJson(
        _$TourAttractionImpl instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'contentTypeId': instance.contentTypeId,
      'title': instance.title,
      'address1': instance.address1,
      'address2': instance.address2,
      'areaCode': instance.areaCode,
      'sigunguCode': instance.sigunguCode,
      'mapX': instance.mapX,
      'mapY': instance.mapY,
      'firstImage': instance.firstImage,
      'firstImage2': instance.firstImage2,
      'tel': instance.tel,
      'zipCode': instance.zipCode,
      'cat1': instance.cat1,
      'cat2': instance.cat2,
      'cat3': instance.cat3,
      'overview': instance.overview,
      'homepage': instance.homepage,
      'createdTime': instance.createdTime,
      'modifiedTime': instance.modifiedTime,
      'mlevel': instance.mlevel,
      'cpyrhtDivCd': instance.cpyrhtDivCd,
      'openTime': instance.openTime,
      'restDate': instance.restDate,
      'useFee': instance.useFee,
      'spendTime': instance.spendTime,
      'parking': instance.parking,
      'infocenter': instance.infocenter,
      'disability': instance.disability,
      'stroller': instance.stroller,
      'pet': instance.pet,
      'creditcard': instance.creditcard,
      'distance': instance.distance,
      'isBookmarked': instance.isBookmarked,
      'cachedAt': instance.cachedAt?.toIso8601String(),
    };
