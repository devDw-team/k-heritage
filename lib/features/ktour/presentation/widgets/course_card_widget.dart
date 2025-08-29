import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/tour_course.dart';

class CourseCardWidget extends StatelessWidget {
  final TourCourse course;
  final VoidCallback onTap;
  final VoidCallback? onBookmarkTap;

  const CourseCardWidget({
    super.key,
    required this.course,
    required this.onTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 섹션
            if (course.firstimage != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: course.firstimage!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            
            // 정보 섹션
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목과 북마크
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          course.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (onBookmarkTap != null)
                        IconButton(
                          icon: Icon(
                            course.isBookmarked ?? false
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: course.isBookmarked ?? false
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          onPressed: onBookmarkTap,
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // 주소
                  if (course.addr1 != null)
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            course.addr1!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 8),
                  
                  // 코스 정보
                  Row(
                    children: [
                      // 거리
                      if (course.totalDistance != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_walk,
                                size: 14,
                                color: Colors.blue[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${course.totalDistance!.toStringAsFixed(1)}km',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      
                      // 소요시간
                      if (course.totalDuration != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.green[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _formatDuration(course.totalDuration!),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      
                      // 테마
                      if (course.theme != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            course.theme!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.purple[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      
                      // 난이도
                      if (course.difficulty != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(course.difficulty!).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            course.difficulty!,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getDifficultyColor(course.difficulty!),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  // 설명
                  if (course.overview != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      course.overview!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  // 코스 단계 수
                  if (course.steps != null && course.steps!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          size: 16,
                          color: Colors.orange[700],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${course.steps!.length}개 지점',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w500,
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

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes분';
    } else {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      if (mins == 0) {
        return '$hours시간';
      } else {
        return '$hours시간 $mins분';
      }
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case '쉬움':
        return Colors.green[700]!;
      case '보통':
        return Colors.orange[700]!;
      case '어려움':
        return Colors.red[700]!;
      default:
        return Colors.grey[700]!;
    }
  }
}