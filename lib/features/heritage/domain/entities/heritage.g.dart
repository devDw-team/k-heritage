// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heritage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HeritageImpl _$$HeritageImplFromJson(Map<String, dynamic> json) =>
    _$HeritageImpl(
      id: json['id'] as String,
      nameKo: json['nameKo'] as String,
      nameEn: json['nameEn'] as String?,
      nameJa: json['nameJa'] as String?,
      nameZh: json['nameZh'] as String?,
      category: json['category'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      designatedYear: json['designatedYear'] as String?,
      descriptionKo: json['descriptionKo'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      descriptionJa: json['descriptionJa'] as String?,
      descriptionZh: json['descriptionZh'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => HeritageImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      distance: (json['distance'] as num?)?.toDouble(),
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$HeritageImplToJson(_$HeritageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameKo': instance.nameKo,
      'nameEn': instance.nameEn,
      'nameJa': instance.nameJa,
      'nameZh': instance.nameZh,
      'category': instance.category,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'designatedYear': instance.designatedYear,
      'descriptionKo': instance.descriptionKo,
      'descriptionEn': instance.descriptionEn,
      'descriptionJa': instance.descriptionJa,
      'descriptionZh': instance.descriptionZh,
      'images': instance.images,
      'distance': instance.distance,
      'isBookmarked': instance.isBookmarked,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$HeritageImageImpl _$$HeritageImageImplFromJson(Map<String, dynamic> json) =>
    _$HeritageImageImpl(
      id: json['id'] as String,
      heritageId: json['heritageId'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      caption: json['caption'] as String?,
      copyright: json['copyright'] as String?,
      orderIndex: (json['orderIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$HeritageImageImplToJson(_$HeritageImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'heritageId': instance.heritageId,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'caption': instance.caption,
      'copyright': instance.copyright,
      'orderIndex': instance.orderIndex,
    };

_$ThemeImpl _$$ThemeImplFromJson(Map<String, dynamic> json) => _$ThemeImpl(
      id: json['id'] as String,
      code: json['code'] as String,
      nameKo: json['nameKo'] as String,
      nameEn: json['nameEn'] as String?,
      nameJa: json['nameJa'] as String?,
      nameZh: json['nameZh'] as String?,
      icon: json['icon'] as String,
      descriptionKo: json['descriptionKo'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      descriptionJa: json['descriptionJa'] as String?,
      descriptionZh: json['descriptionZh'] as String?,
      heritageCount: (json['heritageCount'] as num?)?.toInt() ?? 0,
      orderIndex: (json['orderIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ThemeImplToJson(_$ThemeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'nameKo': instance.nameKo,
      'nameEn': instance.nameEn,
      'nameJa': instance.nameJa,
      'nameZh': instance.nameZh,
      'icon': instance.icon,
      'descriptionKo': instance.descriptionKo,
      'descriptionEn': instance.descriptionEn,
      'descriptionJa': instance.descriptionJa,
      'descriptionZh': instance.descriptionZh,
      'heritageCount': instance.heritageCount,
      'orderIndex': instance.orderIndex,
    };

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      userId: json['userId'] as String,
      language: json['language'] as String? ?? 'ko',
      searchRadiusKm: (json['searchRadiusKm'] as num?)?.toDouble() ?? 3.0,
      enableNotifications: json['enableNotifications'] as bool? ?? true,
      enableNearbyAlerts: json['enableNearbyAlerts'] as bool? ?? true,
      enableDarkMode: json['enableDarkMode'] as bool? ?? false,
      hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'language': instance.language,
      'searchRadiusKm': instance.searchRadiusKm,
      'enableNotifications': instance.enableNotifications,
      'enableNearbyAlerts': instance.enableNearbyAlerts,
      'enableDarkMode': instance.enableDarkMode,
      'hasCompletedOnboarding': instance.hasCompletedOnboarding,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
