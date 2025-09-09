import '../domain/entities/heritage.dart';
import '../infrastructure/data/theme_data.dart';

/// 테마별 문화재 분류 서비스
/// 
/// 문화재를 테마별로 자동 분류하고 관리하는 서비스입니다.
class ThemeClassificationService {
  /// 문화재 목록을 테마별로 분류
  static Map<String, List<Heritage>> classifyHeritagesByTheme(
    List<Heritage> heritages,
  ) {
    final Map<String, List<Heritage>> themeHeritagesMap = {};
    
    // 각 테마별로 빈 리스트 초기화
    for (final themeKey in ThemeData.themeMapping.keys) {
      themeHeritagesMap[themeKey] = [];
    }
    
    // 각 문화재를 해당하는 테마에 분류
    for (final heritage in heritages) {
      final themes = ThemeData.findThemesForHeritage(
        category: heritage.category,
        name: heritage.nameKo,
        description: heritage.descriptionKo,
      );
      
      for (final themeKey in themes) {
        themeHeritagesMap[themeKey]?.add(heritage);
      }
    }
    
    return themeHeritagesMap;
  }
  
  /// 특정 테마에 속하는 문화재 필터링
  static List<Heritage> filterHeritagesByTheme(
    List<Heritage> heritages,
    String themeKey,
  ) {
    return heritages.where((heritage) {
      return ThemeData.belongsToTheme(
        themeKey,
        category: heritage.category,
        name: heritage.nameKo,
        description: heritage.descriptionKo,
      );
    }).toList();
  }
  
  /// 테마별 문화재 개수 계산
  static Map<String, int> countHeritagesByTheme(
    List<Heritage> heritages,
  ) {
    final Map<String, int> themeCounts = {};
    final classifiedHeritages = classifyHeritagesByTheme(heritages);
    
    for (final entry in classifiedHeritages.entries) {
      themeCounts[entry.key] = entry.value.length;
    }
    
    return themeCounts;
  }
  
  /// 테마 정보와 문화재 목록을 결합하여 Theme 엔티티 생성
  static List<Theme> createThemesWithCounts(
    Map<String, int> themeCounts,
  ) {
    final themes = <Theme>[];
    
    for (final entry in ThemeData.themeMapping.entries) {
      final themeKey = entry.key;
      final themeData = entry.value;
      final count = themeCounts[themeKey] ?? 0;
      
      themes.add(Theme(
        id: themeKey,
        code: themeData['code'] as String,
        nameKo: themeData['nameKo'] as String,
        nameEn: themeData['nameEn'] as String?,
        icon: themeData['icon'] as String,
        descriptionKo: themeData['description'] as String?,
        heritageCount: count,
      ));
    }
    
    // orderIndex로 정렬 (여기서는 정의된 순서대로)
    themes.sort((a, b) {
      final aIndex = ThemeData.themeMapping.keys.toList().indexOf(a.id);
      final bIndex = ThemeData.themeMapping.keys.toList().indexOf(b.id);
      return aIndex.compareTo(bIndex);
    });
    
    return themes;
  }
  
  /// 문화재가 특정 테마에 속하는지 확인
  static bool heritageMatchesTheme(Heritage heritage, String themeKey) {
    return ThemeData.belongsToTheme(
      themeKey,
      category: heritage.category,
      name: heritage.nameKo,
      description: heritage.descriptionKo,
    );
  }
  
  /// 추천 테마 생성 (가장 많은 문화재를 가진 테마)
  static String? getRecommendedTheme(Map<String, int> themeCounts) {
    if (themeCounts.isEmpty) return null;
    
    String? recommendedTheme;
    int maxCount = 0;
    
    for (final entry in themeCounts.entries) {
      if (entry.value > maxCount) {
        maxCount = entry.value;
        recommendedTheme = entry.key;
      }
    }
    
    return recommendedTheme;
  }
  
  /// 테마 정보 가져오기
  static Map<String, dynamic>? getThemeInfo(String themeKey) {
    return ThemeData.themeMapping[themeKey];
  }
  
  /// 테마 색상 가져오기
  static int getThemeColor(String themeKey) {
    return ThemeData.getThemeColor(themeKey);
  }
}