// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkItemImpl _$$BookmarkItemImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkItemImpl(
      contentId: json['contentId'] as String,
      contentTypeId: (json['contentTypeId'] as num).toInt(),
      title: json['title'] as String,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      mapX: (json['mapX'] as num?)?.toDouble(),
      mapY: (json['mapY'] as num?)?.toDouble(),
      firstImage: json['firstImage'] as String?,
      firstImage2: json['firstImage2'] as String?,
      tel: json['tel'] as String?,
      overview: json['overview'] as String?,
      bookmarkedAt: DateTime.parse(json['bookmarkedAt'] as String),
      bookmarkType: json['bookmarkType'] as String? ?? 'attraction',
    );

Map<String, dynamic> _$$BookmarkItemImplToJson(_$BookmarkItemImpl instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'contentTypeId': instance.contentTypeId,
      'title': instance.title,
      'address1': instance.address1,
      'address2': instance.address2,
      'mapX': instance.mapX,
      'mapY': instance.mapY,
      'firstImage': instance.firstImage,
      'firstImage2': instance.firstImage2,
      'tel': instance.tel,
      'overview': instance.overview,
      'bookmarkedAt': instance.bookmarkedAt.toIso8601String(),
      'bookmarkType': instance.bookmarkType,
    };
