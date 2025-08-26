import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/tour_attraction.dart';
import '../../infrastructure/datasources/tour_api_datasource.dart';

/// 관광지 아이템 카드 위젯
class TourItemCard extends StatelessWidget {
  final TourAttraction attraction;
  final bool showDistance;
  final VoidCallback onTap;

  const TourItemCard({
    super.key,
    required this.attraction,
    this.showDistance = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지
            if (attraction.firstImage != null && attraction.firstImage!.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: attraction.firstImage!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: theme.colorScheme.surfaceVariant,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: theme.colorScheme.surfaceVariant,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            
            // 컨텐츠
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카테고리 태그
                  if (attraction.contentTypeId != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTypeColor(attraction.contentTypeId)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        TourContentType.getName(attraction.contentTypeId),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getTypeColor(attraction.contentTypeId),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  
                  // 제목
                  Text(
                    attraction.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // 주소
                  if (attraction.address1 != null)
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            attraction.address1!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  
                  // 거리 표시 (dist 필드가 없으므로 주석 처리)
                  // TODO: API에서 거리 정보를 받아올 때 활성화
                  // if (showDistance && attraction.dist != null)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 4),
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           Icons.straighten,
                  //           size: 14,
                  //           color: theme.colorScheme.primary,
                  //         ),
                  //         const SizedBox(width: 4),
                  //         Text(
                  //           _getDistanceText(attraction.dist!),
                  //           style: theme.textTheme.bodySmall?.copyWith(
                  //             color: theme.colorScheme.primary,
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  
                  // 전화번호
                  if (attraction.tel != null && attraction.tel!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              attraction.tel!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(int typeId) {
    switch (typeId) {
      case TourContentType.attraction:
        return Colors.green;
      case TourContentType.culturalFacility:
        return Colors.purple;
      case TourContentType.festival:
        return Colors.orange;
      case TourContentType.tourCourse:
        return Colors.blue;
      case TourContentType.leisure:
        return Colors.teal;
      case TourContentType.accommodation:
        return Colors.indigo;
      case TourContentType.shopping:
        return Colors.pink;
      case TourContentType.restaurant:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // TODO: 거리 정보가 추가되면 활성화
  // String _getDistanceText(String dist) {
  //   try {
  //     final meters = double.parse(dist);
  //     if (meters < 1000) {
  //       return '${meters.toInt()}m';
  //     } else {
  //       final km = meters / 1000;
  //       if (km < 10) {
  //         return '${km.toStringAsFixed(1)}km';
  //       } else {
  //         return '${km.toInt()}km';
  //       }
  //     }
  //   } catch (e) {
  //     return dist;
  //   }
  // }
}