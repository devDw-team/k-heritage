import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/course_step.dart';

class CourseStepWidget extends StatelessWidget {
  final CourseStep step;
  final int stepNumber;
  final bool isLast;
  final VoidCallback? onTap;

  const CourseStepWidget({
    super.key,
    required this.step,
    required this.stepNumber,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 타임라인 인디케이터
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      stepNumber.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.grey[300],
                    ),
                  ),
              ],
            ),
            
            const SizedBox(width: 16),
            
            // 콘텐츠
            Expanded(
              child: Card(
                elevation: 2,
                margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목
                      Text(
                        step.subname,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // 이미지
                      if (step.subdetailimg != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CachedNetworkImage(
                              imageUrl: step.subdetailimg!,
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
                      
                      // 설명
                      if (step.subdetailoverview != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          step.subdetailoverview!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      
                      // 추가 정보
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (step.distance != null && step.distance! > 0) ...[
                            Icon(
                              Icons.directions_walk,
                              size: 16,
                              color: Colors.blue[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${step.distance!.toStringAsFixed(1)}km',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (step.duration != null && step.duration! > 0) ...[
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.green[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatDuration(step.duration!),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
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
}