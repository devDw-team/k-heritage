import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/utils/logger.dart';
import '../../common/services/location_service.dart';
import '../domain/entities/tour_attraction.dart';
import '../domain/repositories/ktour_repository.dart';
import '../infrastructure/datasources/tour_api_datasource.dart';
import 'ktour_controller.dart';
import 'tour_explore_state.dart';

/// 여행지 탐색 화면 Controller Provider
final tourExploreControllerProvider = 
    StateNotifierProvider<TourExploreController, TourExploreState>((ref) {
  return TourExploreController(
    repository: ref.watch(ktourRepositoryProvider),
    locationService: ref.watch(locationServiceProvider),
  );
});

/// 여행지 탐색 화면 Controller
class TourExploreController extends StateNotifier<TourExploreState> {
  final KTourRepository _repository;
  final LocationService _locationService;
  Timer? _searchDebounce;
  
  TourExploreController({
    required KTourRepository repository,
    required LocationService locationService,
  })  : _repository = repository,
        _locationService = locationService,
        super(const TourExploreState()) {
    _initialize();
  }
  
  /// 초기화
  Future<void> _initialize() async {
    // 지역 코드 로드
    await _loadAreaCodes();
    
    // 위치 정보 확인 (초기 로드 시에는 마지막 알려진 위치도 시도)
    await _checkLocation();
  }
  
  /// 지역 코드 로드
  Future<void> _loadAreaCodes() async {
    try {
      final areas = await _repository.getAreaCodes();
      state = state.copyWith(areaCodes: areas);
    } catch (e) {
      Log.e('Failed to load area codes', error: e);
    }
  }
  
  /// 위치 정보 확인
  Future<void> _checkLocation() async {
    try {
      Log.i('Checking location permission and current position...');
      
      // Geolocator를 사용한 권한 상태 확인
      final permission = await Geolocator.checkPermission();
      Log.i('Current location permission: ${permission.toString()}');
      
      // 권한이 허용된 경우
      if (permission == LocationPermission.always || 
          permission == LocationPermission.whileInUse) {
        Log.i('Location permission is granted');
      } else if (permission == LocationPermission.denied) {
        Log.w('Location permission is denied - can request again');
        state = state.copyWith(hasLocation: false);
        return;
      } else if (permission == LocationPermission.deniedForever) {
        Log.w('Location permission is permanently denied - need to open settings');
        state = state.copyWith(hasLocation: false);
        return;
      } else {
        Log.w('Unknown permission status: $permission');
        state = state.copyWith(hasLocation: false);
        return;
      }
      
      // 서비스 활성화 확인
      final serviceEnabled = await _locationService.isLocationServiceEnabled();
      Log.i('Location service enabled: $serviceEnabled');
      
      if (!serviceEnabled) {
        Log.w('Location service is disabled');
        state = state.copyWith(hasLocation: false);
        return;
      }
      
      // 현재 위치 가져오기 시도
      Position? position = await _locationService.getCurrentPosition();
      
      // 현재 위치를 못 가져왔으면 마지막 알려진 위치 시도
      if (position == null) {
        Log.w('Could not get current position, trying last known position...');
        position = await _locationService.getLastKnownPosition();
      }
      
      if (position != null) {
        Log.i('Location obtained: ${position.latitude}, ${position.longitude}');
        state = state.copyWith(
          currentLatitude: position.latitude,
          currentLongitude: position.longitude,
          hasLocation: true,
        );
        
        // 내 주변 모드일 경우 자동 검색
        if (state.filterMode == FilterMode.nearby) {
          search();
        }
      } else {
        Log.w('No location available (neither current nor last known)');
        state = state.copyWith(hasLocation: false);
      }
    } catch (e) {
      Log.e('Failed to get location', error: e);
      state = state.copyWith(hasLocation: false);
    }
  }
  
  /// 필터 모드 설정
  void setFilterMode(FilterMode mode) {
    if (state.filterMode != mode) {
      state = state.copyWith(
        filterMode: mode,
        attractions: [], // 필터 변경 시 결과 초기화
        currentPage: 1,
        totalCount: 0,
      );
      
      // 내 주변 모드로 변경 시 자동 검색
      if (mode == FilterMode.nearby && state.hasLocation) {
        search();
      }
    }
  }
  
  /// 지역 필터 설정
  Future<void> setAreaFilter(List<String> areaCodes, List<String> sigunguCodes) async {
    state = state.copyWith(
      selectedAreaCodes: areaCodes,
      selectedSigunguCodes: sigunguCodes,
    );
    
    // 선택된 지역의 시군구 코드 로드
    for (final areaCode in areaCodes) {
      if (!state.sigunguCodes.containsKey(areaCode)) {
        try {
          final sigungus = await _repository.getAreaCodes(parentCode: areaCode);
          state = state.copyWith(
            sigunguCodes: {
              ...state.sigunguCodes,
              areaCode: sigungus,
            },
          );
        } catch (e) {
          Log.e('Failed to load sigungu codes for $areaCode', error: e);
        }
      }
    }
    
    // 자동 검색
    if (areaCodes.isNotEmpty) {
      search();
    }
  }
  
  /// 테마 필터 설정
  void setThemeFilter(List<int> themes) {
    state = state.copyWith(selectedThemes: themes);
    
    // 자동 검색
    if (themes.isNotEmpty) {
      search();
    }
  }
  
  /// 반경 설정
  void setRadius(int radius) {
    state = state.copyWith(radius: radius);
    
    // 내 주변 모드일 때 자동 재검색
    if (state.filterMode == FilterMode.nearby && state.hasLocation) {
      search();
    }
  }
  
  /// 검색어 설정
  void setSearchKeyword(String keyword) {
    state = state.copyWith(searchKeyword: keyword);
    
    // 디바운싱 검색
    _searchDebounce?.cancel();
    if (keyword.isNotEmpty) {
      _searchDebounce = Timer(const Duration(milliseconds: 500), () {
        search();
      });
    }
  }
  
  /// 정렬 방식 설정
  void setSortType(SortType sortType) {
    state = state.copyWith(sortType: sortType);
    search(); // 재검색
  }
  
  /// 위치 요청
  Future<void> requestLocation() async {
    if (state.isRequestingLocation) return;
    
    // 이미 위치 정보가 있는 경우 다시 확인
    if (state.hasLocation) {
      Log.i('Location already available, rechecking...');
      await _checkLocation();
      return;
    }
    
    Log.i('User requested location permission...');
    state = state.copyWith(isRequestingLocation: true, error: null);
    
    try {
      // 먼저 위치 서비스가 활성화되어 있는지 확인
      final serviceEnabled = await _locationService.isLocationServiceEnabled();
      Log.i('Location service enabled: $serviceEnabled');
      
      if (!serviceEnabled) {
        Log.w('Location service is disabled');
        state = state.copyWith(
          isRequestingLocation: false,
          error: '위치 서비스가 비활성화되어 있습니다. 설정에서 활성화해주세요.',
        );
        return;
      }
      
      // 현재 권한 상태 확인
      LocationPermission permission = await Geolocator.checkPermission();
      Log.i('Current permission status before request: ${permission.toString()}');
      
      // 권한 요청이 필요한 경우
      if (permission == LocationPermission.denied) {
        Log.i('Requesting location permission...');
        permission = await Geolocator.requestPermission();
        Log.i('Permission request result: ${permission.toString()}');
        
        if (permission == LocationPermission.denied) {
          Log.w('Location permission denied by user');
          state = state.copyWith(
            isRequestingLocation: false,
            error: '위치 권한이 거부되었습니다.',
          );
          return;
        } else if (permission == LocationPermission.deniedForever) {
          Log.w('Location permission permanently denied');
          await Geolocator.openAppSettings();
          state = state.copyWith(
            isRequestingLocation: false,
            error: '위치 권한이 거부되었습니다. 설정에서 권한을 허용한 후 다시 시도해주세요.',
          );
          return;
        }
      } else if (permission == LocationPermission.deniedForever) {
        Log.w('Permission is permanently denied, opening settings...');
        await Geolocator.openAppSettings();
        state = state.copyWith(
          isRequestingLocation: false,
          error: '위치 권한이 거부되었습니다. 설정에서 권한을 허용한 후 다시 시도해주세요.',
        );
        return;
      } else if (permission != LocationPermission.always && 
                 permission != LocationPermission.whileInUse) {
        Log.w('Permission not granted: ${permission.toString()}');
        state = state.copyWith(
          isRequestingLocation: false,
          error: '위치 권한이 필요합니다.',
        );
        return;
      }
      
      Log.i('Location permission granted: $permission');
      
      // 위치 가져오기 (getCurrentPosition이 실패하면 getLastKnownPosition 시도)
      Log.i('Attempting to get current position...');
      Position? position = await _locationService.getCurrentPosition();
      
      if (position == null) {
        Log.w('Could not get current position, trying last known position...');
        position = await _locationService.getLastKnownPosition();
      }
      
      if (position != null) {
        Log.i('Location obtained: ${position.latitude}, ${position.longitude}');
        state = state.copyWith(
          currentLatitude: position.latitude,
          currentLongitude: position.longitude,
          hasLocation: true,
          isRequestingLocation: false,
          error: null,
        );
        
        // 내 주변 모드일 때 자동 검색
        if (state.filterMode == FilterMode.nearby) {
          await search();
        }
      } else {
        Log.w('No position available (neither current nor last known)');
        
        // 기본 위치 사용 시도
        final defaultPosition = _locationService.getDefaultPosition();
        Log.i('Using default position: ${defaultPosition.latitude}, ${defaultPosition.longitude}');
        
        state = state.copyWith(
          currentLatitude: defaultPosition.latitude,
          currentLongitude: defaultPosition.longitude,
          hasLocation: true,
          isRequestingLocation: false,
          error: '현재 위치를 가져올 수 없어 기본 위치(서울시청)를 사용합니다.',
        );
        
        // 내 주변 모드일 때 자동 검색
        if (state.filterMode == FilterMode.nearby) {
          await search();
        }
      }
    } catch (e) {
      Log.e('Failed to get location', error: e);
      state = state.copyWith(
        isRequestingLocation: false,
        error: '위치 정보를 가져올 수 없습니다: ${e.toString()}',
      );
    }
  }
  
  /// 검색 실행
  Future<void> search() async {
    if (state.isLoading) return;
    
    state = state.copyWith(
      isLoading: true,
      error: null,
      attractions: [],
      currentPage: 1,
      totalCount: 0,
    );
    
    try {
      List<TourAttraction> results = [];
      
      switch (state.filterMode) {
        case FilterMode.area:
          // 지역별 검색
          if (state.selectedAreaCodes.isEmpty) {
            state = state.copyWith(
              isLoading: false,
              error: '지역을 선택해주세요',
            );
            return;
          }
          
          // 각 지역별로 검색 (병렬 처리)
          final futures = <Future<List<TourAttraction>>>[];
          for (final areaCode in state.selectedAreaCodes) {
            final sigunguList = state.selectedSigunguCodes
                .where((code) => code.startsWith(areaCode))
                .toList();
            
            if (sigunguList.isEmpty) {
              // 시군구 선택 없으면 전체 지역 검색
              futures.add(_searchByArea(areaCode, null));
            } else {
              // 각 시군구별로 검색
              for (final sigunguCode in sigunguList) {
                futures.add(_searchByArea(areaCode, sigunguCode));
              }
            }
          }
          
          final allResults = await Future.wait(futures);
          results = allResults.expand((list) => list).toList();
          break;
          
        case FilterMode.theme:
          // 테마별 검색
          if (state.selectedThemes.isEmpty) {
            state = state.copyWith(
              isLoading: false,
              error: '테마를 선택해주세요',
            );
            return;
          }
          
          // 각 테마별로 검색 (병렬 처리)
          final futures = state.selectedThemes.map((theme) =>
            _searchByTheme(theme)
          ).toList();
          
          final allResults = await Future.wait(futures);
          results = allResults.expand((list) => list).toList();
          break;
          
        case FilterMode.nearby:
          // 내 주변 검색
          if (!state.hasLocation) {
            state = state.copyWith(
              isLoading: false,
              error: '위치 정보가 필요합니다',
            );
            return;
          }
          
          results = await _searchNearby();
          break;
      }
      
      // 검색어 필터링
      if (state.searchKeyword.isNotEmpty) {
        final keyword = state.searchKeyword.toLowerCase();
        results = results.where((item) =>
          item.title.toLowerCase().contains(keyword) ||
          (item.address1?.toLowerCase().contains(keyword) ?? false) ||
          (item.cat3?.toLowerCase().contains(keyword) ?? false)
        ).toList();
      }
      
      // 정렬
      _sortResults(results);
      
      // 페이지네이션 적용
      final paginatedResults = results.take(state.pageSize).toList();
      
      state = state.copyWith(
        isLoading: false,
        attractions: paginatedResults,
        totalCount: results.length,
        hasMore: results.length > state.pageSize,
      );
    } catch (e) {
      Log.e('Search failed', error: e);
      state = state.copyWith(
        isLoading: false,
        error: '검색 중 오류가 발생했습니다',
      );
    }
  }
  
  /// 지역별 검색
  Future<List<TourAttraction>> _searchByArea(String areaCode, String? sigunguCode) async {
    if (state.searchKeyword.isNotEmpty) {
      return await _repository.searchAttractions(
        keyword: state.searchKeyword,
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        pageNo: 1,
        numOfRows: 100,
      );
    } else {
      return await _repository.getAttractionsByArea(
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        pageNo: 1,
        numOfRows: 100,
      );
    }
  }
  
  /// 테마별 검색
  Future<List<TourAttraction>> _searchByTheme(int contentTypeId) async {
    if (state.searchKeyword.isNotEmpty) {
      return await _repository.searchAttractions(
        keyword: state.searchKeyword,
        contentTypeId: contentTypeId,
        pageNo: 1,
        numOfRows: 100,
      );
    } else {
      return await _repository.getAttractionsByArea(
        contentTypeId: contentTypeId,
        pageNo: 1,
        numOfRows: 100,
      );
    }
  }
  
  /// 내 주변 검색
  Future<List<TourAttraction>> _searchNearby() async {
    return await _repository.getNearbyAttractions(
      latitude: state.currentLatitude!,
      longitude: state.currentLongitude!,
      radius: state.radius,
      pageNo: 1,
      numOfRows: 100,
    );
  }
  
  /// 결과 정렬
  void _sortResults(List<TourAttraction> results) {
    switch (state.sortType) {
      case SortType.title:
        results.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortType.modified:
        results.sort((a, b) {
          final aTime = a.modifiedTime ?? '';
          final bTime = b.modifiedTime ?? '';
          return bTime.compareTo(aTime);
        });
        break;
      case SortType.distance:
        // 거리순은 API에서 이미 정렬됨
        break;
    }
  }
  
  /// 더 불러오기
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    
    state = state.copyWith(
      isLoadingMore: true,
      currentPage: state.currentPage + 1,
    );
    
    // TODO: 실제 페이지네이션 구현
    // 현재는 단순히 hasMore를 false로 설정
    await Future.delayed(const Duration(seconds: 1));
    
    state = state.copyWith(
      isLoadingMore: false,
      hasMore: false,
    );
  }
  
  /// 새로고침
  Future<void> refresh() async {
    await search();
  }
  
  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}