import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/logger.dart';
import '../domain/entities/bookmark_item.dart';
import '../domain/entities/tour_attraction.dart';
import '../domain/entities/tour_festival.dart';
import '../domain/repositories/ktour_repository.dart';
import '../infrastructure/repositories/ktour_repository_impl.dart';

/// 북마크 상태
class BookmarkState {
  final List<BookmarkItem> bookmarks;
  final bool isLoading;
  final String? error;

  const BookmarkState({
    this.bookmarks = const [],
    this.isLoading = false,
    this.error,
  });

  BookmarkState copyWith({
    List<BookmarkItem>? bookmarks,
    bool? isLoading,
    String? error,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 북마크 컨트롤러
class BookmarkController extends StateNotifier<BookmarkState> {
  final KTourRepository? _repository;

  BookmarkController(this._repository) : super(const BookmarkState()) {
    if (_repository != null) {
      loadBookmarks();
    }
  }

  /// 북마크 목록 로드
  Future<void> loadBookmarks() async {
    if (_repository == null) {
      state = state.copyWith(
        isLoading: false,
        error: '저장소가 초기화되지 않았습니다',
      );
      return;
    }
    
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final bookmarks = await _repository!.getBookmarkedAttractions();
      state = state.copyWith(
        bookmarks: bookmarks,
        isLoading: false,
      );
      Log.d('Loaded ${bookmarks.length} bookmarks');
    } catch (e) {
      Log.e('Failed to load bookmarks', error: e);
      state = state.copyWith(
        isLoading: false,
        error: '북마크를 불러오는데 실패했습니다',
      );
    }
  }

  /// 북마크 추가 (TourAttraction에서)
  Future<void> addBookmarkFromAttraction(TourAttraction attraction) async {
    if (_repository == null) return;
    
    try {
      final bookmarkItem = BookmarkItem(
        contentId: attraction.contentId,
        contentTypeId: attraction.contentTypeId,
        title: attraction.title,
        address1: attraction.address1,
        address2: attraction.address2,
        mapX: attraction.mapX,
        mapY: attraction.mapY,
        firstImage: attraction.firstImage,
        firstImage2: attraction.firstImage2,
        tel: attraction.tel,
        overview: attraction.overview,
        bookmarkedAt: DateTime.now(),
        bookmarkType: 'attraction',
      );
      
      await _repository!.saveBookmarkWithDetails(
        bookmarkItem: bookmarkItem,
      );
      
      // 목록 새로고침
      await loadBookmarks();
      
      Log.d('Added bookmark: ${attraction.contentId}');
    } catch (e) {
      Log.e('Failed to add bookmark', error: e);
      state = state.copyWith(
        error: '북마크 추가에 실패했습니다',
      );
    }
  }

  /// 북마크 제거
  Future<void> removeBookmark(String contentId) async {
    if (_repository == null) return;
    
    try {
      await _repository!.removeBookmark(contentId: contentId);
      
      // SharedPreferences에서 상세 정보도 제거
      final detailsKey = 'ktour_bookmark_details_$contentId';
      // TODO: SharedPreferences 직접 접근 필요
      
      // 목록 새로고침
      await loadBookmarks();
      
      Log.d('Removed bookmark: $contentId');
    } catch (e) {
      Log.e('Failed to remove bookmark', error: e);
      state = state.copyWith(
        error: '북마크 제거에 실패했습니다',
      );
    }
  }

  /// 축제 북마크 추가
  Future<void> addBookmarkFromFestival(TourFestival festival) async {
    if (_repository == null) return;
    
    try {
      final bookmarkItem = BookmarkItem(
        contentId: festival.contentId,
        contentTypeId: 15, // 축제 타입 ID
        title: festival.title,
        address1: festival.address1,
        address2: festival.address2,
        mapX: festival.mapX,
        mapY: festival.mapY,
        firstImage: festival.firstImage,
        firstImage2: festival.firstImage2,
        tel: festival.tel,
        overview: festival.overview,
        bookmarkedAt: DateTime.now(),
        bookmarkType: 'festival',
      );
      
      await _repository!.saveBookmarkWithDetails(
        bookmarkItem: bookmarkItem,
      );
      
      // 목록 새로고침
      await loadBookmarks();
      
      Log.d('Added festival bookmark: ${festival.contentId}');
    } catch (e) {
      Log.e('Failed to add festival bookmark', error: e);
      state = state.copyWith(
        error: '축제 북마크 추가에 실패했습니다',
      );
    }
  }

  /// 북마크 토글
  Future<void> toggleBookmark(TourAttraction attraction) async {
    if (_repository == null) return;
    
    final isBookmarked = await _repository!.isBookmarked(attraction.contentId);
    
    if (isBookmarked) {
      await removeBookmark(attraction.contentId);
    } else {
      await addBookmarkFromAttraction(attraction);
    }
  }
  
  /// 축제 북마크 토글
  Future<void> toggleFestivalBookmark(TourFestival festival) async {
    if (_repository == null) return;
    
    final isBookmarked = await _repository!.isBookmarked(festival.contentId);
    
    if (isBookmarked) {
      await removeBookmark(festival.contentId);
    } else {
      await addBookmarkFromFestival(festival);
    }
  }

  /// 북마크 여부 확인
  Future<bool> isBookmarked(String contentId) async {
    if (_repository == null) return false;
    return _repository!.isBookmarked(contentId);
  }

  /// 범용 북마크 토글
  Future<void> toggleBookmarkGeneric({
    required String contentId,
    required String contentTypeId,
    required String title,
    String? address,
    String? imageUrl,
  }) async {
    if (_repository == null) return;
    
    final isCurrentlyBookmarked = await _repository!.isBookmarked(contentId);
    
    if (isCurrentlyBookmarked) {
      await removeBookmark(contentId);
    } else {
      final bookmarkItem = BookmarkItem(
        contentId: contentId,
        contentTypeId: int.tryParse(contentTypeId) ?? 0,
        title: title,
        address1: address,
        firstImage: imageUrl,
        bookmarkedAt: DateTime.now(),
        bookmarkType: _getBookmarkType(contentTypeId),
      );
      
      await _repository!.saveBookmarkWithDetails(
        bookmarkItem: bookmarkItem,
      );
      
      // 목록 새로고침
      await loadBookmarks();
      
      Log.d('Added bookmark: $contentId');
    }
  }

  String _getBookmarkType(String contentTypeId) {
    switch (contentTypeId) {
      case '12':
        return 'attraction';
      case '15':
        return 'festival';
      case '32':
        return 'accommodation';
      case '39':
        return 'restaurant';
      case '38':
        return 'shopping';
      default:
        return 'other';
    }
  }

  /// 북마크 검색
  List<BookmarkItem> searchBookmarks(String query) {
    if (query.isEmpty) return state.bookmarks;
    
    final lowercaseQuery = query.toLowerCase();
    return state.bookmarks.where((bookmark) {
      return bookmark.title.toLowerCase().contains(lowercaseQuery) ||
          (bookmark.address1?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }
}

/// 북마크 컨트롤러 프로바이더
final bookmarkControllerProvider =
    StateNotifierProvider<BookmarkController, BookmarkState>((ref) {
  final repositoryAsync = ref.watch(ktourRepositoryProvider);
  
  // Repository가 로딩 중이면 기본 컨트롤러 반환
  return repositoryAsync.when(
    data: (repository) => BookmarkController(repository),
    loading: () => BookmarkController(null),
    error: (error, stack) => BookmarkController(null),
  );
});