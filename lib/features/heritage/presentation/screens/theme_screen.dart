import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';

/// 테마 탐방 화면
class ThemeScreen extends ConsumerWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themes = [
      ThemeItem(
        icon: '🏛️',
        title: '궁궐 탐방',
        count: 5,
        color: AppColors.dancheongRed,
      ),
      ThemeItem(
        icon: '🌍',
        title: '세계유산',
        count: 14,
        color: AppColors.obangBlue,
      ),
      ThemeItem(
        icon: '🏘️',
        title: '전통마을',
        count: 7,
        color: AppColors.celadonGreen,
      ),
      ThemeItem(
        icon: '🛕',
        title: '불교 문화재',
        count: 23,
        color: const Color(0xFF9C27B0),
      ),
      ThemeItem(
        icon: '⛰️',
        title: '산성',
        count: 9,
        color: const Color(0xFF795548),
      ),
      ThemeItem(
        icon: '🎭',
        title: '무형문화재',
        count: 15,
        color: AppColors.intangibleHeritage,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('테마별 탐방'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '관심 있는 테마를 선택하여\n문화재를 탐방해보세요',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.grayMedium,
              ),
            ),
            const SizedBox(height: 24),
            
            // 테마 그리드
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: themes.length,
              itemBuilder: (context, index) {
                final theme = themes[index];
                return _ThemeCard(
                  theme: theme,
                  onTap: () {
                    // TODO: 테마별 문화재 리스트 화면으로 이동
                  },
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // 이달의 추천 코스
            _buildRecommendedCourse(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedCourse(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.hanjiBeige,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '이달의 추천 코스',
            style: AppTypography.h5,
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              // TODO: 추천 코스 상세 화면으로 이동
            },
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.dancheongRed,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    child: const Center(
                      child: Text(
                        '🌸',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '봄꽃과 함께하는 궁궐 나들이',
                          style: AppTypography.h6,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '창덕궁, 창경궁, 덕수궁',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grayMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grayMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 테마 카드 위젯
class _ThemeCard extends StatelessWidget {
  final ThemeItem theme;
  final VoidCallback? onTap;

  const _ThemeCard({
    required this.theme,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.grayLight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  theme.icon,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              theme.title,
              style: AppTypography.h6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${theme.count}개 문화재',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.grayMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 테마 아이템 모델
class ThemeItem {
  final String icon;
  final String title;
  final int count;
  final Color color;

  const ThemeItem({
    required this.icon,
    required this.title,
    required this.count,
    required this.color,
  });
}