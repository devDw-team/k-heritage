import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/tour_stay.dart';

/// 숙박 카드 위젯
class AccommodationCard extends StatelessWidget {
  final TourStay stay;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;

  const AccommodationCard({
    super.key,
    required this.stay,
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
                  if (stay.firstImage != null)
                    CachedNetworkImage(
                      imageUrl: stay.firstImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.hotel, size: 48),
                      ),
                    )
                  else
                    Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.hotel, size: 48),
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
                            stay.isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 20,
                            color: stay.isBookmarked
                                ? theme.colorScheme.primary
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 배지 (굿스테이, 한옥)
                  if (stay.goodStay == 'Y' || stay.hanOk == 'Y')
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Row(
                        children: [
                          if (stay.goodStay == 'Y')
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '굿스테이',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (stay.goodStay == 'Y' && stay.hanOk == 'Y')
                            const SizedBox(width: 4),
                          if (stay.hanOk == 'Y')
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '한옥',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
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
                        stay.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // 주소
                      if (stay.address1 != null)
                        Text(
                          stay.address1!,
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
                      if (stay.distance != null) ...[
                        Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 2),
                        Text(
                          '${stay.distance!.toStringAsFixed(1)}km',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],

                      // 주차
                      if (stay.parking != null &&
                          stay.parking!.isNotEmpty) ...[
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