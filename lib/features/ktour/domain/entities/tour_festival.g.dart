// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_festival.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TourFestivalImpl _$$TourFestivalImplFromJson(Map<String, dynamic> json) =>
    _$TourFestivalImpl(
      contentId: json['contentId'] as String,
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
      eventStartDate: json['eventStartDate'] as String?,
      eventEndDate: json['eventEndDate'] as String?,
      eventPlace: json['eventPlace'] as String?,
      playTime: json['playTime'] as String?,
      sponsor1: json['sponsor1'] as String?,
      sponsor1Tel: json['sponsor1Tel'] as String?,
      sponsor2: json['sponsor2'] as String?,
      sponsor2Tel: json['sponsor2Tel'] as String?,
      useFee: json['useFee'] as String?,
      homepage: json['homepage'] as String?,
      overview: json['overview'] as String?,
      cat1: json['cat1'] as String?,
      cat2: json['cat2'] as String?,
      cat3: json['cat3'] as String?,
      cpyrhtDivCd: json['cpyrhtDivCd'] as String?,
      createdTime: json['createdTime'] as String?,
      modifiedTime: json['modifiedTime'] as String?,
      mlevel: (json['mlevel'] as num?)?.toInt(),
      distance: (json['distance'] as num?)?.toDouble(),
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      cachedAt: json['cachedAt'] == null
          ? null
          : DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$$TourFestivalImplToJson(_$TourFestivalImpl instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
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
      'eventStartDate': instance.eventStartDate,
      'eventEndDate': instance.eventEndDate,
      'eventPlace': instance.eventPlace,
      'playTime': instance.playTime,
      'sponsor1': instance.sponsor1,
      'sponsor1Tel': instance.sponsor1Tel,
      'sponsor2': instance.sponsor2,
      'sponsor2Tel': instance.sponsor2Tel,
      'useFee': instance.useFee,
      'homepage': instance.homepage,
      'overview': instance.overview,
      'cat1': instance.cat1,
      'cat2': instance.cat2,
      'cat3': instance.cat3,
      'cpyrhtDivCd': instance.cpyrhtDivCd,
      'createdTime': instance.createdTime,
      'modifiedTime': instance.modifiedTime,
      'mlevel': instance.mlevel,
      'distance': instance.distance,
      'isBookmarked': instance.isBookmarked,
      'cachedAt': instance.cachedAt?.toIso8601String(),
    };
