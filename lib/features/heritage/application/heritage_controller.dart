import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import '../domain/entities/heritage.dart';
import '../domain/repositories/heritage_repository.dart';
import '../infrastructure/repositories/heritage_repository_impl.dart';
import '../../common/services/location_service.dart';
import '../../../core/config/app_config.dart';

part 'heritage_controller.freezed.dart';

final heritageRepositoryProvider = Provider<HeritageRepository>((ref) {
  // AppConfig가 초기화되었는지 확인
  if (!AppConfig.instance.isInitialized) {
    throw Exception('AppConfig is not initialized. Please ensure AppConfig.initialize() is called before using this provider.');
  }
  return HeritageRepositoryImpl();
});

final heritageControllerProvider = 
    StateNotifierProvider<HeritageController, HeritageState>((ref) {
  final repository = ref.watch(heritageRepositoryProvider);
  final locationService = ref.watch(locationServiceProvider);
  return HeritageController(repository, locationService, ref);
});

@freezed
class HeritageState with _$HeritageState {
  const factory HeritageState({
    @Default([]) List<Heritage> heritages,
    @Default([]) List<Heritage> filteredHeritages,
    Heritage? selectedHeritage,
    Position? currentPosition,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    String? error,
    @Default('ko') String language,
    @Default(3.0) double searchRadius,
    String? selectedCategory,
    @Default(false) bool hasLocationPermission,
  }) = _HeritageState;
}

class HeritageController extends StateNotifier<HeritageState> {
  final HeritageRepository _repository;
  final LocationService _locationService;
  final Ref _ref;
  
  HeritageController(this._repository, this._locationService, this._ref)
      : super(const HeritageState()) {
    _initialize();
  }
  
  Future<void> _initialize() async {
    await loadNearbyHeritages();
  }
  
  Future<void> loadNearbyHeritages() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Get current position
      Position? position = await _locationService.getCurrentPosition();
      
      if (position == null) {
        // Use default position if location is not available
        position = _locationService.getDefaultPosition();
        state = state.copyWith(hasLocationPermission: false);
      } else {
        state = state.copyWith(hasLocationPermission: true);
      }
      
      state = state.copyWith(currentPosition: position);
      
      // Load heritages
      final heritages = await _repository.getNearbyHeritages(
        latitude: position.latitude,
        longitude: position.longitude,
        radiusKm: state.searchRadius,
        lang: state.language,
      );
      
      state = state.copyWith(
        heritages: heritages,
        filteredHeritages: _applyFilters(heritages),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load heritages: $e',
      );
    }
  }
  
  Future<void> refreshHeritages() async {
    if (state.isRefreshing) return;
    
    state = state.copyWith(isRefreshing: true, error: null);
    
    try {
      final position = state.currentPosition ?? _locationService.getDefaultPosition();
      
      // Refresh from remote
      await _repository.refreshHeritagesForLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        radiusKm: state.searchRadius,
      );
      
      // Reload from local
      final heritages = await _repository.getNearbyHeritages(
        latitude: position.latitude,
        longitude: position.longitude,
        radiusKm: state.searchRadius,
        lang: state.language,
      );
      
      state = state.copyWith(
        heritages: heritages,
        filteredHeritages: _applyFilters(heritages),
        isRefreshing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        error: 'Failed to refresh heritages: $e',
      );
    }
  }
  
  Future<void> searchHeritages(String keyword) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final heritages = await _repository.searchHeritages(
        keyword: keyword,
        category: state.selectedCategory,
        lang: state.language,
      );
      
      state = state.copyWith(
        heritages: heritages,
        filteredHeritages: heritages,
        isLoading: false,
      );
    } catch (e) {
      final errorMessage = _getErrorMessage(e.toString());
      state = state.copyWith(
        isLoading: false,
        error: errorMessage,
      );
    }
  }
  
  Future<void> selectHeritage(String heritageId) async {
    final heritage = state.heritages.firstWhere(
      (h) => h.id == heritageId,
      orElse: () => state.heritages.first,
    );
    
    state = state.copyWith(selectedHeritage: heritage);
    
    // Load full details if not already loaded
    if (heritage.descriptionKo == null) {
      final detailedHeritage = await _repository.getHeritageDetail(
        id: heritageId,
        lang: state.language,
      );
      
      if (detailedHeritage != null) {
        state = state.copyWith(selectedHeritage: detailedHeritage);
        
        // Update in list
        final updatedHeritages = state.heritages.map((h) {
          return h.id == heritageId ? detailedHeritage : h;
        }).toList();
        
        state = state.copyWith(
          heritages: updatedHeritages,
          filteredHeritages: _applyFilters(updatedHeritages),
        );
      }
    }
  }
  
  void setCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
    state = state.copyWith(
      filteredHeritages: _applyFilters(state.heritages),
    );
  }
  
  void setLanguage(String language) {
    state = state.copyWith(language: language);
    // Reload heritages with new language
    loadNearbyHeritages();
  }
  
  void setSearchRadius(double radius) {
    state = state.copyWith(searchRadius: radius);
    loadNearbyHeritages();
  }
  
  Future<void> requestLocationPermission() async {
    final hasPermission = await _locationService.requestLocationPermission();
    state = state.copyWith(hasLocationPermission: hasPermission);
    
    if (hasPermission) {
      await loadNearbyHeritages();
    }
  }
  
  List<Heritage> _applyFilters(List<Heritage> heritages) {
    if (state.selectedCategory == null) {
      return heritages;
    }
    
    return heritages.where((h) => h.category == state.selectedCategory).toList();
  }
  
  void clearError() {
    state = state.copyWith(error: null);
  }
  
  String _getErrorMessage(String error) {
    if (error.contains('연결 시간 초과')) {
      return '네트워크 연결이 불안정합니다. 잠시 후 다시 시도해주세요.';
    } else if (error.contains('서버에 연결할 수 없습니다')) {
      return '서버에 연결할 수 없습니다. 인터넷 연결을 확인해주세요.';
    } else if (error.contains('API 엔드포인트를 찾을 수 없습니다')) {
      return '문화재 정보 서비스를 일시적으로 이용할 수 없습니다.';
    } else if (error.contains('Failed to get nearby heritages')) {
      return '주변 문화재 정보를 불러올 수 없습니다.';
    } else if (error.contains('Failed to refresh heritages')) {
      return '문화재 정보를 새로고침할 수 없습니다.';
    } else if (error.contains('Failed to upsert heritages')) {
      // This is just a caching error, we can ignore it for the user
      return '문화재 정보를 불러오는 중입니다...';
    } else if (error.contains('row-level security policy')) {
      // Database permission error - ignore for user
      return '데이터베이스 연결 중입니다...';
    }
    return '문화재 정보를 불러오는데 실패했습니다.';
  }
}