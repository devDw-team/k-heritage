import 'dart:math' as math;
import '../../domain/entities/heritage.dart';
import '../../domain/repositories/heritage_repository.dart';
import '../datasources/heritage_local_datasource.dart';
import '../datasources/heritage_remote_datasource.dart';

class HeritageRepositoryImpl implements HeritageRepository {
  final HeritageLocalDataSource _localDataSource;
  final HeritageRemoteDataSource _remoteDataSource;
  
  HeritageRepositoryImpl({
    HeritageLocalDataSource? localDataSource,
    HeritageRemoteDataSource? remoteDataSource,
  }) : _localDataSource = localDataSource ?? HeritageLocalDataSource(),
       _remoteDataSource = remoteDataSource ?? HeritageRemoteDataSource();
  
  @override
  Future<List<Heritage>> getNearbyHeritages({
    required double latitude,
    required double longitude,
    required double radiusKm,
    String? lang,
  }) async {
    try {
      // Try to get from local database first
      final localHeritages = await _localDataSource.getNearbyHeritages(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        lang: lang,
      );
      
      if (localHeritages.isNotEmpty) {
        return localHeritages;
      }
      
      // If no local data, fetch from remote and cache
      await refreshHeritagesForLocation(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
      );
      
      // Return from local after refresh
      return await _localDataSource.getNearbyHeritages(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        lang: lang,
      );
    } catch (e) {
      throw Exception('Failed to get nearby heritages: $e');
    }
  }
  
  @override
  Future<Heritage?> getHeritageDetail({
    required String id,
    String? lang,
  }) async {
    try {
      // Try local first
      final localHeritage = await _localDataSource.getHeritageById(id, lang: lang);
      if (localHeritage != null) {
        return localHeritage;
      }
      
      // Parse id to get components (format: kdcd_asno_ctcd)
      final parts = id.split('_');
      if (parts.length != 3) {
        return null;
      }
      
      // Fetch from remote
      final remoteHeritage = await _remoteDataSource.fetchHeritageDetail(
        kdcd: parts[0],
        asno: parts[1],
        ctcd: parts[2],
      );
      
      // Cache it
      await _localDataSource.upsertHeritage(remoteHeritage);
      
      return remoteHeritage;
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<Heritage>> searchHeritages({
    String? keyword,
    String? category,
    String? cityCode,
    String? lang,
  }) async {
    try {
      // Search in local database
      final localResults = await _localDataSource.searchHeritages(
        keyword: keyword,
        category: category,
        cityCode: cityCode,
        lang: lang,
      );
      
      if (localResults.isNotEmpty) {
        return localResults;
      }
      
      // If no local results, fetch from remote
      final remoteResults = await _remoteDataSource.fetchHeritageList(
        cityCode: cityCode,
        keyword: keyword,
        pageSize: 100,
      );
      
      // Cache results
      if (remoteResults.isNotEmpty) {
        await _localDataSource.upsertHeritages(remoteResults);
      }
      
      // Filter by category if needed
      if (category != null && category.isNotEmpty) {
        return remoteResults.where((h) => h.category == category).toList();
      }
      
      return remoteResults;
    } catch (e) {
      throw Exception('Failed to search heritages: $e');
    }
  }
  
  @override
  Future<void> refreshHeritagesForLocation({
    required double latitude,
    required double longitude,
    required double radiusKm,
  }) async {
    try {
      // Get nearby city codes based on coordinates
      final cityCodes = _getNearbyCityCodes(latitude, longitude);
      
      // Fetch heritage list from multiple cities
      final List<Heritage> allHeritages = [];
      
      for (final cityCode in cityCodes) {
        try {
          final remoteHeritages = await _remoteDataSource.fetchHeritageList(
            cityCode: cityCode,
            pageSize: 200,  // Increased page size
          );
          allHeritages.addAll(remoteHeritages);
        } catch (e) {
          // Log error but continue with other cities
          print('Failed to fetch heritages for city $cityCode: $e');
        }
      }
      
      // Also fetch without city code filter to get more results
      if (allHeritages.isEmpty) {
        try {
          final allRemoteHeritages = await _remoteDataSource.fetchHeritageList(
            pageSize: 200,
          );
          allHeritages.addAll(allRemoteHeritages);
        } catch (e) {
          print('Failed to fetch all heritages: $e');
        }
      }
      
      // Filter by distance and validate coordinates
      final nearbyHeritages = allHeritages.where((heritage) {
        // Skip invalid coordinates
        if (heritage.latitude == 0 || heritage.longitude == 0) return false;
        if (heritage.latitude < 33 || heritage.latitude > 39) return false;
        if (heritage.longitude < 124 || heritage.longitude > 132) return false;
        
        final distance = _calculateDistance(
          latitude,
          longitude,
          heritage.latitude,
          heritage.longitude,
        );
        return distance <= radiusKm;
      }).map((heritage) {
        final distance = _calculateDistance(
          latitude,
          longitude,
          heritage.latitude,
          heritage.longitude,
        );
        return heritage.copyWith(distanceKm: distance);
      }).toList();
      
      // Sort by distance
      nearbyHeritages.sort((a, b) => (a.distanceKm ?? 0).compareTo(b.distanceKm ?? 0));
      
      // Cache in local database
      if (nearbyHeritages.isNotEmpty) {
        await _localDataSource.upsertHeritages(nearbyHeritages);
      }
    } catch (e) {
      throw Exception('Failed to refresh heritages: $e');
    }
  }
  
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Earth's radius in km
    
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) * math.cos(_toRadians(lat2)) *
        math.sin(dLon / 2) * math.sin(dLon / 2);
    
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    
    return R * c;
  }
  
  double _toRadians(double degree) {
    return degree * math.pi / 180;
  }
  
  List<String> _getNearbyCityCodes(double latitude, double longitude) {
    // Return multiple city codes based on location
    final List<String> cityCodes = [];
    
    // Seoul area
    if (latitude >= 37.4 && latitude <= 37.7 && longitude >= 126.7 && longitude <= 127.2) {
      cityCodes.addAll(['11', '31', '23']); // Seoul, Gyeonggi, Incheon
    }
    // Busan area
    else if (latitude >= 35.0 && latitude <= 35.3 && longitude >= 128.9 && longitude <= 129.3) {
      cityCodes.addAll(['21', '26', '38']); // Busan, Ulsan, Gyeongnam
    }
    // Daegu area
    else if (latitude >= 35.7 && latitude <= 36.0 && longitude >= 128.4 && longitude <= 128.8) {
      cityCodes.addAll(['22', '37']); // Daegu, Gyeongbuk
    }
    // Gwangju area
    else if (latitude >= 35.0 && latitude <= 35.3 && longitude >= 126.7 && longitude <= 127.0) {
      cityCodes.addAll(['24', '36']); // Gwangju, Jeonnam
    }
    // Daejeon area
    else if (latitude >= 36.2 && latitude <= 36.5 && longitude >= 127.2 && longitude <= 127.5) {
      cityCodes.addAll(['25', '33', '34']); // Daejeon, Chungbuk, Chungnam
    }
    // Jeju area
    else if (latitude >= 33.2 && latitude <= 33.6 && longitude >= 126.1 && longitude <= 127.0) {
      cityCodes.add('39'); // Jeju
    }
    // Gyeonggi area
    else if (latitude >= 37.0 && latitude <= 37.9 && longitude >= 126.5 && longitude <= 127.8) {
      cityCodes.addAll(['31', '11', '23', '32']); // Gyeonggi, Seoul, Incheon, Gangwon
    }
    // Default: try major cities
    else {
      cityCodes.addAll(['11', '31', '21', '22']); // Seoul, Gyeonggi, Busan, Daegu
    }
    
    return cityCodes;
  }
}