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
}