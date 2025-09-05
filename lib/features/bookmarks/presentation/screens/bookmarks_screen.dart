import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../heritage/domain/entities/heritage.dart';
import '../../../heritage/presentation/widgets/heritage_card.dart';
import '../../../ktour/application/bookmark_controller.dart';
import '../../../ktour/presentation/widgets/tour_bookmark_card.dart';

/// 북마크 화면
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // K-TOUR 북마크 상태
    final bookmarkState = ref.watch(bookmarkControllerProvider);
    final bookmarkController = ref.read(bookmarkControllerProvider.notifier);
    
    // 더미 문화재 북마크 데이터 (나중에 실제 구현 필요)
    final bookmarkedHeritages = <Heritage>[];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('북마크'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '관광지'),
              Tab(text: '행사/축제'),
              Tab(text: '문화재'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 관광지 북마크 탭
            _buildTourBookmarks(context, bookmarkState, bookmarkController, 'attraction'),
            
            // 행사/축제 북마크 탭
            _buildTourBookmarks(context, bookmarkState, bookmarkController, 'festival'),
            
            // 문화재 북마크 탭
            _buildHeritageBookmarks(context, bookmarkedHeritages),
          ],
        ),
      ),
    );
  }

  Widget _buildTourBookmarks(
    BuildContext context,
    BookmarkState state,
    BookmarkController controller,
    String bookmarkType,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.error!,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.loadBookmarks,
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }
    
    // 타입별로 북마크 필터링
    final filteredBookmarks = state.bookmarks
        .where((bookmark) => bookmark.bookmarkType == bookmarkType)
        .toList();
    
    if (filteredBookmarks.isEmpty) {
      return _buildEmptyState(bookmarkType: bookmarkType);
    }
    
    return RefreshIndicator(
      onRefresh: controller.loadBookmarks,
      child: ListView.builder(
        itemCount: filteredBookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = filteredBookmarks[index];
          return TourBookmarkCard(
            key: ValueKey('${bookmark.contentId}_${bookmark.bookmarkedAt.millisecondsSinceEpoch}'),
            bookmark: bookmark,
            onRemove: () {
              // 비동기적으로 삭제 처리
              controller.removeBookmark(bookmark.contentId);
            },
          );
        },
      ),
    );
  }
  
  Widget _buildHeritageBookmarks(BuildContext context, List<Heritage> heritages) {
    if (heritages.isEmpty) {
      return _buildEmptyState(isForTour: false);
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: heritages.length,
      itemBuilder: (context, index) {
        final heritage = heritages[index];
        return HeritageCard(
          heritage: heritage,
          showDistance: false,
          onTap: () {
            context.push('/heritage/${heritage.id}');
          },
        );
      },
    );
  }

  Widget _buildEmptyState({String? bookmarkType, bool isForTour = true}) {
    String message;
    if (bookmarkType != null) {
      switch (bookmarkType) {
        case 'attraction':
          message = '관심 있는 관광지를 북마크에 추가해보세요';
          break;
        case 'festival':
          message = '관심 있는 행사/축제를 북마크에 추가해보세요';
          break;
        default:
          message = '관심 있는 항목을 북마크에 추가해보세요';
      }
    } else {
      message = isForTour 
        ? '관심 있는 관광지를 북마크에 추가해보세요'
        : '관심 있는 문화재를 북마크에 추가해보세요';
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 80,
            color: AppColors.grayLight,
          ),
          const SizedBox(height: 16),
          Text(
            '북마크가 비어있습니다',
            style: AppTypography.h5.copyWith(
              color: AppColors.grayMedium,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.grayMedium,
            ),
          ),
        ],
      ),
    );
  }
}