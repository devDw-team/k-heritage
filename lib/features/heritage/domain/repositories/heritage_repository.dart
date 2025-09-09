import '../entities/heritage.dart';

abstract class HeritageRepository {
  Future<List<Heritage>> getNearbyHeritages({
    required double latitude,
    required double longitude,
    required double radiusKm,
    String? lang,
  });
  
  Future<Heritage?> getHeritageDetail({
    required String id,
    String? lang,
  });
  
  Future<List<Heritage>> searchHeritages({
    String? keyword,
    String? category,
    String? cityCode,
    String? lang,
  });
  
  Future<void> refreshHeritagesForLocation({
    required double latitude,
    required double longitude,
    required double radiusKm,
  });
  
  // 테마 관련 메서드
  Future<List<Theme>> getAllThemes();
  
  Future<List<Heritage>> getHeritagesByTheme(
    String themeCode, {
    String? lang,
  });
  
  Future<Map<String, int>> getThemeCounts();
  
  Future<List<Heritage>> getAllHeritages({
    String? lang,
    int? limit,
  });
}