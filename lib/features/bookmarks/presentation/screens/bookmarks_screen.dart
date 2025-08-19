import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../heritage/domain/entities/heritage.dart';
import '../../../heritage/presentation/widgets/heritage_card.dart';

/// 북마크 화면
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 더미 북마크 데이터
    final bookmarkedHeritages = [
      const Heritage(
        id: '1',
        nameKo: '경복궁',
        category: '사적',
        latitude: 37.5796,
        longitude: 126.9770,
        address: '서울특별시 종로구 사직로 161',
        designatedYear: '1395년',
        isBookmarked: true,
      ),
      const Heritage(
        id: '2',
        nameKo: '창덕궁',
        category: '사적',
        latitude: 37.5794,
        longitude: 126.9910,
        address: '서울특별시 종로구 율곡로 99',
        designatedYear: '1405년',
        isBookmarked: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('북마크'),
      ),
      body: bookmarkedHeritages.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarkedHeritages.length,
              itemBuilder: (context, index) {
                final heritage = bookmarkedHeritages[index];
                return HeritageCard(
                  heritage: heritage,
                  showDistance: false,
                  onTap: () {
                    context.push('/heritage/${heritage.id}');
                  },
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
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
            '관심 있는 문화재를 북마크에 추가해보세요',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.grayMedium,
            ),
          ),
        ],
      ),
    );
  }
}