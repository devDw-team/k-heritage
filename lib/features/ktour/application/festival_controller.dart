import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/logger.dart';
import '../domain/entities/tour_festival.dart';
import '../domain/repositories/ktour_repository.dart';
import '../infrastructure/repositories/ktour_repository_impl.dart';
import 'festival_state.dart';
import 'bookmark_controller.dart';

/// 축제 컨트롤러 프로바이더
final festivalControllerProvider = 
    StateNotifierProvider<FestivalController, FestivalState>((ref) {
  final repositoryAsync = ref.watch(ktourRepositoryProvider);
  final bookmarkController = ref.watch(bookmarkControllerProvider.notifier);
  
  return repositoryAsync.when(
    data: (repository) => FestivalController(repository, bookmarkController),
    loading: () => FestivalController.loading(null),
    error: (error, stack) => FestivalController.error(error.toString(), null),
  );
});

/// 축제 상태 관리 컨트롤러
class FestivalController extends StateNotifier<FestivalState> {
  final KTourRepository? _repository;
  final BookmarkController? _bookmarkController;
  
  FestivalController(this._repository, this._bookmarkController) 
      : super(const FestivalState()) {
    // 초기 데이터 로드
    if (_repository != null) {
      loadFestivals();
      _loadBookmarkedIds();
    }
  }
  
  // 로딩 상태 생성자
  FestivalController.loading(this._bookmarkController) 
      : _repository = null, 
        super(const FestivalState(isLoading: true));
  
  // 에러 상태 생성자
  FestivalController.error(String errorMessage, this._bookmarkController) 
      : _repository = null,
        super(FestivalState(isLoading: false, error: errorMessage));
  
  /// 축제 목록 로드
  Future<void> loadFestivals({bool loadMore = false}) async {
    if (_repository == null) {
      state = state.copyWith(
        isLoading: false,
        error: 'Repository not initialized',
      );
      return;
    }
    
    if (state.isLoadingMore && loadMore) return;
    
    state = state.copyWith(
      isLoading: !loadMore,
      isLoadingMore: loadMore,
      error: null,
    );
    
    try {
      // 날짜 범위 설정
      final now = DateTime.now();
      final startDate = DateFormat('yyyyMMdd').format(
        state.filterMonth ?? now.subtract(const Duration(days: 30))
      );
      final endDate = DateFormat('yyyyMMdd').format(
        state.filterMonth?.add(const Duration(days: 30)) ?? 
        now.add(const Duration(days: 365))
      );
      
      Log.d('Loading festivals - Start: $startDate, End: $endDate, Page: ${loadMore ? state.currentPage + 1 : 1}');
      
      // API 호출
      final festivals = await _repository!.searchFestivals(
        eventStartDate: startDate,
        eventEndDate: endDate,
        areaCode: state.filterAreaCode,
        sigunguCode: state.filterSigunguCode,
        arrange: state.sortBy,
        pageNo: loadMore ? state.currentPage + 1 : 1,
        numOfRows: 20,
      );
      
      Log.d('Loaded ${festivals.length} festivals');
      
      // 상태별 필터링
      List<TourFestival> filteredFestivals = festivals;
      if (state.filterStatus != null) {
        filteredFestivals = _filterByStatus(festivals, state.filterStatus!);
      }
      
      // 키워드 검색 적용
      if (state.searchKeyword != null && state.searchKeyword!.isNotEmpty) {
        filteredFestivals = _searchByKeyword(filteredFestivals, state.searchKeyword!);
      }
      
      // 북마크 상태 업데이트
      final bookmarkedIds = state.bookmarkedIds;
      final festivalsWithBookmark = filteredFestivals.map((festival) {
        return festival.copyWith(
          isBookmarked: bookmarkedIds.contains(festival.contentId),
        );
      }).toList();
      
      final allFestivalsWithBookmark = festivals.map((festival) {
        return festival.copyWith(
          isBookmarked: bookmarkedIds.contains(festival.contentId),
        );
      }).toList();
      
      state = state.copyWith(
        festivals: loadMore 
            ? [...state.festivals, ...festivalsWithBookmark]
            : festivalsWithBookmark,
        allFestivals: loadMore
            ? [...state.allFestivals, ...allFestivalsWithBookmark]
            : allFestivalsWithBookmark,
        isLoading: false,
        isLoadingMore: false,
        currentPage: loadMore ? state.currentPage + 1 : 1,
        hasMore: festivals.length == 20,
      );
    } catch (e) {
      Log.e('Failed to load festivals', error: e);
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: '축제 정보를 불러올 수 없습니다',
      );
    }
  }
  
  /// 새로고침
  Future<void> refresh() async {
    state = state.copyWith(currentPage: 1, hasMore: false);
    await loadFestivals();
  }
  
  /// 더 많은 데이터 로드
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    await loadFestivals(loadMore: true);
  }
  
  /// 상태별 필터링
  List<TourFestival> _filterByStatus(List<TourFestival> festivals, FestivalStatus status) {
    return festivals.where((festival) => festival.status == status).toList();
  }
  
  /// 키워드 검색
  List<TourFestival> _searchByKeyword(List<TourFestival> festivals, String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    return festivals.where((festival) {
      return festival.title.toLowerCase().contains(lowerKeyword) ||
             (festival.eventPlace?.toLowerCase().contains(lowerKeyword) ?? false) ||
             (festival.overview?.toLowerCase().contains(lowerKeyword) ?? false);
    }).toList();
  }
  
  /// 필터 상태 설정
  void setFilterStatus(FestivalStatus? status) {
    state = state.copyWith(filterStatus: status);
    _applyFilters();
  }
  
  /// 지역 필터 설정
  void setAreaFilter(String? areaCode, String? sigunguCode) {
    state = state.copyWith(
      filterAreaCode: areaCode,
      filterSigunguCode: sigunguCode,
    );
    loadFestivals();
  }
  
  /// 월 필터 설정
  void setMonthFilter(DateTime? month) {
    state = state.copyWith(filterMonth: month);
    loadFestivals();
  }
  
  /// 검색 키워드 설정
  void setSearchKeyword(String? keyword) {
    state = state.copyWith(searchKeyword: keyword);
    _applyFilters();
  }
  
  /// 정렬 옵션 설정
  void setSortBy(String sortBy) {
    state = state.copyWith(sortBy: sortBy);
    loadFestivals();
  }
  
  /// 보기 모드 설정
  void setViewMode(String mode) {
    state = state.copyWith(viewMode: mode);
  }
  
  /// 날짜 선택 (캘린더 뷰용)
  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }
  
  /// 북마크된 축제 ID 로드
  Future<void> _loadBookmarkedIds() async {
    if (_repository == null) return;
    
    try {
      final bookmarkIds = await _repository!.getBookmarkIds();
      state = state.copyWith(bookmarkedIds: bookmarkIds);
    } catch (e) {
      Log.e('Failed to load bookmarked IDs', error: e);
    }
  }
  
  /// 북마크 토글
  Future<void> toggleBookmark(String contentId) async {
    // 현재 축제 찾기
    final festival = state.festivals.firstWhere(
      (f) => f.contentId == contentId,
      orElse: () => state.allFestivals.firstWhere(
        (f) => f.contentId == contentId,
        orElse: () => const TourFestival(contentId: '', title: ''),
      ),
    );
    
    if (festival.contentId.isEmpty) {
      Log.w('Festival not found for contentId: $contentId');
      return;
    }
    
    // BookmarkController를 통해 북마크 토글
    if (_bookmarkController != null) {
      await _bookmarkController!.toggleFestivalBookmark(festival);
      
      // 북마크 ID 목록 업데이트
      await _loadBookmarkedIds();
    } else {
      // Fallback: 로컬 상태만 업데이트
      final bookmarkedIds = List<String>.from(state.bookmarkedIds);
      if (bookmarkedIds.contains(contentId)) {
        bookmarkedIds.remove(contentId);
      } else {
        bookmarkedIds.add(contentId);
      }
      
      state = state.copyWith(bookmarkedIds: bookmarkedIds);
    }
    
    // 축제 목록 업데이트
    final isBookmarked = state.bookmarkedIds.contains(contentId);
    final updatedFestivals = state.festivals.map((f) {
      if (f.contentId == contentId) {
        return f.copyWith(isBookmarked: isBookmarked);
      }
      return f;
    }).toList();
    
    final updatedAllFestivals = state.allFestivals.map((f) {
      if (f.contentId == contentId) {
        return f.copyWith(isBookmarked: isBookmarked);
      }
      return f;
    }).toList();
    
    state = state.copyWith(
      festivals: updatedFestivals,
      allFestivals: updatedAllFestivals,
    );
  }
  
  /// 필터 적용
  void _applyFilters() {
    List<TourFestival> filteredFestivals = state.allFestivals;
    
    // 상태 필터
    if (state.filterStatus != null) {
      filteredFestivals = _filterByStatus(filteredFestivals, state.filterStatus!);
    }
    
    // 키워드 검색
    if (state.searchKeyword != null && state.searchKeyword!.isNotEmpty) {
      filteredFestivals = _searchByKeyword(filteredFestivals, state.searchKeyword!);
    }
    
    state = state.copyWith(festivals: filteredFestivals);
  }
  
  /// 필터 초기화
  void clearFilters() {
    state = state.copyWith(
      filterStatus: null,
      filterAreaCode: null,
      filterSigunguCode: null,
      filterMonth: null,
      searchKeyword: null,
      sortBy: 'R',
    );
    loadFestivals();
  }
  
  /// 축제 상세 정보 가져오기
  Future<TourFestival?> getFestivalDetail(String contentId) async {
    if (_repository == null) return null;
    
    try {
      // 먼저 목록에서 기본 정보를 확인
      final existing = state.festivals.firstWhere(
        (f) => f.contentId == contentId,
        orElse: () => state.allFestivals.firstWhere(
          (f) => f.contentId == contentId,
          orElse: () => const TourFestival(contentId: '', title: ''),
        ),
      );
      
      // overview가 이미 있는 경우 그대로 반환
      if (existing.contentId.isNotEmpty && existing.overview != null && existing.overview!.isNotEmpty) {
        return existing;
      }
      
      // API를 통해 상세 정보 가져오기 (overview 포함)
      final detail = await _repository!.getFestivalDetail(contentId: contentId);
      
      if (detail != null) {
        // 기존 데이터와 병합 - 날짜 정보 등 중요한 필드 보존
        final merged = existing.contentId.isNotEmpty 
          ? existing.copyWith(
              // 새로운 정보로 업데이트 (null이 아닌 경우에만)
              overview: detail.overview ?? existing.overview,
              address1: detail.address1 ?? existing.address1,
              address2: detail.address2 ?? existing.address2,
              tel: detail.tel ?? existing.tel,
              homepage: detail.homepage ?? existing.homepage,
              firstImage: detail.firstImage ?? existing.firstImage,
              firstImage2: detail.firstImage2 ?? existing.firstImage2,
              // 날짜 정보는 기존 것을 우선 사용 (searchFestival2에서 온 데이터)
              eventStartDate: existing.eventStartDate ?? detail.eventStartDate,
              eventEndDate: existing.eventEndDate ?? detail.eventEndDate,
              eventPlace: existing.eventPlace ?? detail.eventPlace,
              sponsor1: detail.sponsor1 ?? existing.sponsor1,
              sponsor1Tel: detail.sponsor1Tel ?? existing.sponsor1Tel,
              sponsor2: detail.sponsor2 ?? existing.sponsor2,
              sponsor2Tel: detail.sponsor2Tel ?? existing.sponsor2Tel,
              useFee: detail.useFee ?? existing.useFee,
              // 좌표는 더 정확한 값 사용
              mapX: detail.mapX ?? existing.mapX,
              mapY: detail.mapY ?? existing.mapY,
            )
          : detail;
        
        // 상태 업데이트 - 병합된 정보로 교체
        final updatedFestivals = state.festivals.map((f) {
          if (f.contentId == contentId) {
            return merged.copyWith(isBookmarked: f.isBookmarked);
          }
          return f;
        }).toList();
        
        final updatedAllFestivals = state.allFestivals.map((f) {
          if (f.contentId == contentId) {
            return merged.copyWith(isBookmarked: f.isBookmarked);
          }
          return f;
        }).toList();
        
        state = state.copyWith(
          festivals: updatedFestivals,
          allFestivals: updatedAllFestivals,
        );
        
        Log.d('Festival detail loaded - Overview: ${merged.overview != null ? "Yes" : "No"}, Dates: ${merged.eventStartDate ?? "N/A"} ~ ${merged.eventEndDate ?? "N/A"}');
        
        return merged;
      }
      
      return existing.contentId.isNotEmpty ? existing : null;
    } catch (e) {
      Log.e('Failed to get festival detail', error: e);
      // 에러 발생 시에도 기존 데이터가 있으면 반환
      final existing = state.festivals.firstWhere(
        (f) => f.contentId == contentId,
        orElse: () => const TourFestival(contentId: '', title: ''),
      );
      return existing.contentId.isNotEmpty ? existing : null;
    }
  }
}