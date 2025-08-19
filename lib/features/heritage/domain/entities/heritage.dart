import 'package:freezed_annotation/freezed_annotation.dart';

part 'heritage.freezed.dart';
part 'heritage.g.dart';

/// 문화재 엔티티
@freezed
class Heritage with _$Heritage {
  const factory Heritage({
    required String id,
    required String nameKo,
    String? nameEn,
    String? nameJa,
    String? nameZh,
    required String category,
    required double latitude,
    required double longitude,
    required String address,
    String? designatedYear,
    String? descriptionKo,
    String? descriptionEn,
    String? descriptionJa,
    String? descriptionZh,
    @Default([]) List<HeritageImage> images,
    double? distance, // 현재 위치로부터의 거리 (km)
    @Default(false) bool isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Heritage;

  factory Heritage.fromJson(Map<String, dynamic> json) =>
      _$HeritageFromJson(json);
}

/// 문화재 이미지 엔티티
@freezed
class HeritageImage with _$HeritageImage {
  const factory HeritageImage({
    required String id,
    required String heritageId,
    required String url,
    String? thumbnailUrl,
    String? caption,
    String? copyright,
    int? orderIndex,
  }) = _HeritageImage;

  factory HeritageImage.fromJson(Map<String, dynamic> json) =>
      _$HeritageImageFromJson(json);
}

/// 문화재 카테고리 enum
enum HeritageCategory {
  nationalTreasure('국보'),
  treasure('보물'),
  historicSite('사적'),
  scenicSite('명승'),
  naturalMonument('천연기념물'),
  intangibleHeritage('무형문화재'),
  folkloreMaterial('민속문화재'),
  other('기타');

  final String displayName;
  const HeritageCategory(this.displayName);

  static HeritageCategory fromString(String value) {
    return HeritageCategory.values.firstWhere(
      (category) => category.displayName == value,
      orElse: () => HeritageCategory.other,
    );
  }
}

/// 테마 엔티티
@freezed
class Theme with _$Theme {
  const factory Theme({
    required String id,
    required String code,
    required String nameKo,
    String? nameEn,
    String? nameJa,
    String? nameZh,
    required String icon,
    String? descriptionKo,
    String? descriptionEn,
    String? descriptionJa,
    String? descriptionZh,
    @Default(0) int heritageCount,
    int? orderIndex,
  }) = _Theme;

  factory Theme.fromJson(Map<String, dynamic> json) => _$ThemeFromJson(json);
}

/// 사용자 설정 엔티티
@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String userId,
    @Default('ko') String language,
    @Default(3.0) double searchRadiusKm,
    @Default(true) bool enableNotifications,
    @Default(true) bool enableNearbyAlerts,
    @Default(false) bool enableDarkMode,
    @Default(false) bool hasCompletedOnboarding,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}