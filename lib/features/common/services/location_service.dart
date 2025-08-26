import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final currentPositionProvider = FutureProvider<Position?>((ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return await locationService.getCurrentPosition();
});

class LocationService {
  Future<bool> requestLocationPermission() async {
    // Geolocator를 사용한 권한 확인
    LocationPermission permission = await Geolocator.checkPermission();
    
    // 권한이 이미 허용된 경우
    if (permission == LocationPermission.always || 
        permission == LocationPermission.whileInUse) {
      return true;
    }
    
    // 권한이 거부된 경우 다시 요청
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      
      if (permission == LocationPermission.denied) {
        return false;
      }
      
      if (permission == LocationPermission.deniedForever) {
        // 영구 거부된 경우 설정으로 이동
        await Geolocator.openAppSettings();
        return false;
      }
      
      return permission == LocationPermission.always || 
             permission == LocationPermission.whileInUse;
    }
    
    // 영구 거부된 경우
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }
    
    return false;
  }
  
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
  
  Future<Position?> getCurrentPosition() async {
    try {
      // Check if location service is enabled
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }
      
      // Check and request permission
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        return null;
      }
      
      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      
      return position;
    } catch (e) {
      return null;
    }
  }
  
  Future<Position?> getLastKnownPosition() async {
    try {
      return await Geolocator.getLastKnownPosition();
    } catch (e) {
      return null;
    }
  }
  
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }
  
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    ) / 1000; // Convert to kilometers
  }
  
  double calculateBearing(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
  
  Position getDefaultPosition() {
    // Seoul City Hall coordinates as default
    return Position(
      latitude: 37.5665,
      longitude: 126.9780,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }
}