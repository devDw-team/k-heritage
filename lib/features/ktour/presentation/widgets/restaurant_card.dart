import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/tour_restaurant.dart';

/// 맛집 카드 위젯
class RestaurantCard extends StatelessWidget {
  final TourRestaurant restaurant;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (restaurant.firstImage != null)
                    CachedNetworkImage(
                      imageUrl: restaurant.firstImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.restaurant, size: 48),
                      ),
                    )
                  else
                    Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.restaurant, size: 48),
                    ),
                  
                  // 북마크 버튼
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white.withOpacity(0.9),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onBookmarkTap,
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            restaurant.isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 20,
                            color: restaurant.isBookmarked
                                ? theme.colorScheme.primary
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 정보
            Container(
              height: 100, // 고정 높이
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 상단 정보
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목
                      Text(
                        restaurant.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // 대표 메뉴
                      if (restaurant.firstMenu != null) ...[
                        Text(
                          restaurant.firstMenu!,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                      ],

                      // 주소
                      if (restaurant.address1 != null)
                        Text(
                          restaurant.address1!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),

                  // 하단 정보
                  Row(
                    children: [
                      // 거리
                      if (restaurant.distance != null) ...[
                        Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 2),
                        Text(
                          '${restaurant.distance!.toStringAsFixed(1)}km',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],

                      // 주차
                      if (restaurant.parking != null &&
                          restaurant.parking!.isNotEmpty) ...[
                        Icon(Icons.local_parking, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 2),
                        Text(
                          '주차',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}