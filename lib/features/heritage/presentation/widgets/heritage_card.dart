import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/heritage.dart';

/// 문화재 카드 위젯
class HeritageCard extends StatelessWidget {
  final Heritage heritage;
  final VoidCallback? onTap;
  final bool showDistance;

  const HeritageCard({
    super.key,
    required this.heritage,
    this.onTap,
    this.showDistance = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.grayLight),
          boxShadow: AppTheme.shadowSm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지
            _buildImage(),
            
            // 컨텐츠
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카테고리 배지
                  _buildCategoryBadge(),
                  const SizedBox(height: 8),
                  
                  // 제목
                  Text(
                    heritage.nameKo,
                    style: AppTypography.h5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // 주소
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.grayMedium,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          heritage.address,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grayMedium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  // 거리 표시
                  if (showDistance && heritage.distance != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_walk,
                          size: 16,
                          color: AppColors.grayMedium,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${heritage.distance}km',
                          style: AppTypography.numberSmall.copyWith(
                            color: AppColors.grayMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLg),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getCategoryColor(heritage.category),
            _getCategoryColor(heritage.category).withOpacity(0.7),
          ],
        ),
      ),
      child: heritage.images.isNotEmpty
          ? ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusLg),
              ),
              child: CachedNetworkImage(
                imageUrl: heritage.images.first.thumbnailUrl ??
                    heritage.images.first.url,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => _buildPlaceholderImage(),
              ),
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Center(
      child: Icon(
        Icons.temple_buddhist,
        size: 48,
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
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
      case '무형문화재':
        return AppColors.intangibleHeritage;
      default:
        return AppColors.grayMedium;
    }
  }
}