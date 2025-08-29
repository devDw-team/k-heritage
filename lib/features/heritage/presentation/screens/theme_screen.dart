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
        icon: '👑',
        title: '궁궐 탐방',
        subtitle: '조선의 왕실 문화',
        count: 5,
        color: AppColors.dancheongRed,
        description: '경복궁, 창덕궁, 창경궁 등',
      ),
      ThemeItem(
        icon: '🗺️',
        title: '세계유산',
        subtitle: 'UNESCO 등재 문화재',
        count: 14,
        color: AppColors.obangBlue,
        description: '석굴암, 해인사, 종묘 등',
      ),
      ThemeItem(
        icon: '🏘️',
        title: '전통마을',
        subtitle: '한옥과 고택의 정취',
        count: 7,
        color: AppColors.celadonGreen,
        description: '안동 하회마을, 양동마을 등',
      ),
      ThemeItem(
        icon: '🛕',
        title: '불교 문화재',
        subtitle: '사찰과 불탑',
        count: 23,
        color: const Color(0xFF9C27B0),
        description: '불국사, 통도사, 해인사 등',
      ),
      ThemeItem(
        icon: '🗿',
        title: '산성과 성곽',
        subtitle: '방어 유적지',
        count: 9,
        color: const Color(0xFF795548),
        description: '화성, 남한산성, 북한산성 등',
      ),
      ThemeItem(
        icon: '🎭',
        title: '무형문화재',
        subtitle: '전통 기예와 문화',
        count: 15,
        color: AppColors.intangibleHeritage,
        description: '판소리, 농악, 탈춤 등',
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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.hanjiBeige.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.explore,
                    color: AppColors.dancheongRed,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '테마별로 둘러보기',
                          style: AppTypography.h6.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '관심 있는 주제를 선택해 문화재를 탐방해보세요',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grayMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // 테마 그리드
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
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
  
  Widget _getThemeIcon(String title) {
    IconData iconData;
    switch (title) {
      case '궁궐 탐방':
        iconData = Icons.account_balance;
        break;
      case '세계유산':
        iconData = Icons.public;
        break;
      case '전통마을':
        iconData = Icons.holiday_village;
        break;
      case '불교 문화재':
        iconData = Icons.temple_buddhist;
        break;
      case '산성과 성곽':
        iconData = Icons.castle;
        break;
      case '무형문화재':
        iconData = Icons.theater_comedy;
        break;
      default:
        iconData = Icons.museum;
    }
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(12),
      child: Icon(
        iconData,
        size: 36,
        color: theme.color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        splashColor: theme.color.withValues(alpha: 0.1),
        highlightColor: theme.color.withValues(alpha: 0.05),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface,
                theme.color.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(
              color: theme.color.withValues(alpha: 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.color.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 아이콘 컨테이너 개선
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.color.withValues(alpha: 0.15),
                      theme.color.withValues(alpha: 0.08),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.color.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: _getThemeIcon(theme.title),
                ),
              ),
              const SizedBox(height: 16),
              // 제목 스타일 개선
              Text(
                theme.title,
                style: AppTypography.h6.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // 서브타이틀 추가
              Text(
                theme.subtitle,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.grayMedium,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // 카운트 배지 스타일
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 12,
                      color: theme.color.withValues(alpha: 0.8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${theme.count}개 문화재',
                      style: AppTypography.labelSmall.copyWith(
                        color: theme.color.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 테마 아이템 모델
class ThemeItem {
  final String icon;
  final String title;
  final String subtitle;
  final String description;
  final int count;
  final Color color;

  const ThemeItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.count,
    required this.color,
  });
}