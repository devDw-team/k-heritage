import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/heritage.dart';

class HeritageListTile extends StatelessWidget {
  final Heritage heritage;
  final VoidCallback? onTap;

  const HeritageListTile({
    super.key,
    required this.heritage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: AppColors.grayLight.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 카테고리 아이콘
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getCategoryColor(heritage.category).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Center(
                child: Icon(
                  _getCategoryIcon(heritage.category),
                  color: _getCategoryColor(heritage.category),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // 정보 영역
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목 행
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          heritage.nameKo,
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // 카테고리 배지
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(heritage.category).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        ),
                        child: Text(
                          heritage.category,
                          style: AppTypography.labelSmall.copyWith(
                            color: _getCategoryColor(heritage.category),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // 정보 행들
                  Row(
                    children: [
                      // 주소
                      if (heritage.sigungu != null) ...[
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.grayMedium,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          heritage.sigungu!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grayMedium,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      
                      // 시대
                      if (heritage.period != null) ...[
                        Icon(
                          Icons.history,
                          size: 14,
                          color: AppColors.grayMedium,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          heritage.period!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grayMedium,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      
                      // 거리
                      if (heritage.distanceKm != null) ...[
                        Icon(
                          Icons.directions_walk,
                          size: 14,
                          color: AppColors.grayMedium,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${heritage.distanceKm!.toStringAsFixed(1)}km',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grayMedium,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  // 지정일자
                  if (heritage.designatedDate != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '지정일: ${DateFormat('yyyy년 MM월 dd일').format(heritage.designatedDate!)}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.grayMedium,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // 화살표 아이콘
            Icon(
              Icons.chevron_right,
              color: AppColors.grayLight,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case '국보':
        return AppColors.nationalTreasure;
      case '보물':
        return AppColors.treasure;
      case '사적':
        return AppColors.historicSite;
      case '명승':
        return AppColors.scenicSite;
      case '천연기념물':
        return AppColors.naturalMonument;
      case '무형문화재':
      case '국가무형유산':
        return AppColors.intangibleHeritage;
      default:
        return AppColors.grayMedium;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '국보':
        return Icons.star;
      case '보물':
        return Icons.diamond;
      case '사적':
        return Icons.account_balance;
      case '명승':
        return Icons.landscape;
      case '천연기념물':
        return Icons.park;
      case '무형문화재':
      case '국가무형유산':
        return Icons.people;
      default:
        return Icons.museum;
    }
  }
}