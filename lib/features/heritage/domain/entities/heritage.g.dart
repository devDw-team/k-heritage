// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heritage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HeritageImpl _$$HeritageImplFromJson(Map<String, dynamic> json) =>
    _$HeritageImpl(
      id: json['id'] as String,
      kdcd: json['kdcd'] as String,
      ctcd: json['ctcd'] as String,
      asno: json['asno'] as String,
      nameKo: json['nameKo'] as String,
      nameHanja: json['nameHanja'] as String?,
      nameEn: json['nameEn'] as String?,
      nameJa: json['nameJa'] as String?,
      nameZh: json['nameZh'] as String?,
      category: json['category'] as String,
      cityName: json['cityName'] as String?,
      sigungu: json['sigungu'] as String?,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      period: json['period'] as String?,
      designatedDate: json['designatedDate'] == null
          ? null
          : DateTime.parse(json['designatedDate'] as String),
      descriptionKo: json['descriptionKo'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      descriptionJa: json['descriptionJa'] as String?,
      descriptionZh: json['descriptionZh'] as String?,
      admin: json['admin'] as String?,
      mainImageUrl: json['mainImageUrl'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => HeritageImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      narrations: (json['narrations'] as List<dynamic>?)
              ?.map(
                  (e) => HeritageNarration.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
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
      'kdcd': instance.kdcd,
      'ctcd': instance.ctcd,
      'asno': instance.asno,
      'nameKo': instance.nameKo,
      'nameHanja': instance.nameHanja,
      'nameEn': instance.nameEn,
      'nameJa': instance.nameJa,
      'nameZh': instance.nameZh,
      'category': instance.category,
      'cityName': instance.cityName,
      'sigungu': instance.sigungu,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'period': instance.period,
      'designatedDate': instance.designatedDate?.toIso8601String(),
      'descriptionKo': instance.descriptionKo,
      'descriptionEn': instance.descriptionEn,
      'descriptionJa': instance.descriptionJa,
      'descriptionZh': instance.descriptionZh,
      'admin': instance.admin,
      'mainImageUrl': instance.mainImageUrl,
      'images': instance.images,
      'narrations': instance.narrations,
      'distanceKm': instance.distanceKm,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$HeritageImageImpl _$$HeritageImageImplFromJson(Map<String, dynamic> json) =>
    _$HeritageImageImpl(
      id: json['id'] as String,
      heritageId: json['heritageId'] as String,
      imageUrl: json['imageUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      description: json['description'] as String?,
      copyright: json['copyright'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$HeritageImageImplToJson(_$HeritageImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'heritageId': instance.heritageId,
      'imageUrl': instance.imageUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'copyright': instance.copyright,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$HeritageNarrationImpl _$$HeritageNarrationImplFromJson(
        Map<String, dynamic> json) =>
    _$HeritageNarrationImpl(
      id: json['id'] as String,
      heritageId: json['heritageId'] as String,
      audioUrl: json['audioUrl'] as String,
      language: json['language'] as String? ?? 'ko',
      description: json['description'] as String?,
      copyright: json['copyright'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$HeritageNarrationImplToJson(
        _$HeritageNarrationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'heritageId': instance.heritageId,
      'audioUrl': instance.audioUrl,
      'language': instance.language,
      'description': instance.description,
      'copyright': instance.copyright,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt?.toIso8601String(),
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
