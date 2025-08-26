import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/entities/tour_attraction.dart';
import '../domain/repositories/ktour_repository.dart';

part 'tour_explore_state.freezed.dart';

/// 필터 모드
enum FilterMode {
  area,   // 지역별
  theme,  // 테마별
  nearby, // 내 주변
}

/// 정렬 타입
enum SortType {
  title,    // 제목순
  modified, // 수정일순
  distance, // 거리순
}

/// 여행지 탐색 화면 상태
@freezed
class TourExploreState with _$TourExploreState {
  const factory TourExploreState({
    // 필터 모드
    @Default(FilterMode.area) FilterMode filterMode,
    
    // 지역별 필터
    @Default([]) List<String> selectedAreaCodes,
    @Default([]) List<String> selectedSigunguCodes,
    @Default([]) List<AreaCode> areaCodes,
    @Default({}) Map<String, List<AreaCode>> sigunguCodes, // areaCode별 시군구 목록
    
    // 테마별 필터
    @Default([]) List<int> selectedThemes,
    
    // 내 주변 필터
    @Default(5000) int radius, // 미터 단위
    double? currentLatitude,
    double? currentLongitude,
    
    // 검색
    @Default('') String searchKeyword,
    
    // 정렬
    @Default(SortType.title) SortType sortType,
    
    // 결과
    @Default([]) List<TourAttraction> attractions,
    @Default(0) int totalCount,
    
    // 페이지네이션
    @Default(1) int currentPage,
    @Default(20) int pageSize,
    @Default(true) bool hasMore,
    
    // 로딩 상태
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
    
    // 위치 정보
    @Default(false) bool hasLocation,
    @Default(false) bool isRequestingLocation,
  }) = _TourExploreState;
  
  const TourExploreState._();
  
  /// 선택된 필터가 있는지 확인
  bool get hasActiveFilter {
    switch (filterMode) {
      case FilterMode.area:
        return selectedAreaCodes.isNotEmpty;
      case FilterMode.theme:
        return selectedThemes.isNotEmpty;
      case FilterMode.nearby:
        return hasLocation;
    }
  }
  
  /// 필터 설명 텍스트
  String get filterDescription {
    switch (filterMode) {
      case FilterMode.area:
        if (selectedAreaCodes.isEmpty) return '지역을 선택하세요';
        return '${selectedAreaCodes.length}개 지역 선택됨';
      case FilterMode.theme:
        if (selectedThemes.isEmpty) return '테마를 선택하세요';
        return '${selectedThemes.length}개 테마 선택됨';
      case FilterMode.nearby:
        if (!hasLocation) return '위치 정보가 필요합니다';
        return '내 위치 ${radius >= 1000 ? '${radius ~/ 1000}km' : '${radius}m'} 반경';
    }
  }
}