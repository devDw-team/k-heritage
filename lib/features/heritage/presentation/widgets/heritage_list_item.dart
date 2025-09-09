import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/heritage.dart';

/// 문화재 리스트 아이템 위젯
class HeritageListItem extends StatelessWidget {
  final Heritage heritage;
  final VoidCallback? onTap;
  final bool showDistance;

  const HeritageListItem({
    super.key,
    required this.heritage,
    this.onTap,
    this.showDistance = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasImages = heritage.images.isNotEmpty;
    final displayImageUrl = hasImages 
        ? (heritage.images.first.thumbnailUrl ?? heritage.images.first.imageUrl)
        : null;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // 이미지
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _getCategoryColor(heritage.category),
                    _getCategoryColor(heritage.category).withOpacity(0.7),
                  ],
                ),
              ),
              child: displayImageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      child: CachedNetworkImage(
                        imageUrl: displayImageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => _buildPlaceholderImage(),
                      ),
                    )
                  : _buildPlaceholderImage(),
            ),
            const SizedBox(width: 16),
            
            // 컨텐츠
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카테고리 배지
                  if (heritage.category.isNotEmpty)
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
                  if (heritage.category.isNotEmpty)
                    const SizedBox(height: 4),
                  
                  // 제목
                  Text(
                    heritage.nameKo,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // 주소
                  if (heritage.address.isNotEmpty)
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
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
                  if (showDistance && heritage.distanceKm != null) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_walk,
                          size: 14,
                          color: AppColors.grayMedium,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${heritage.distanceKm}km',
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
            
            // 화살표
            const Icon(
              Icons.chevron_right,
              color: AppColors.grayMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Center(
      child: Icon(
        Icons.temple_buddhist,
        size: 32,
        color: Colors.white.withOpacity(0.7),
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