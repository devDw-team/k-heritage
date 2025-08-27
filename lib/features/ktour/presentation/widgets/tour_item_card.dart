import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/utils/logger.dart';
import '../../application/ktour_controller.dart';
import '../../domain/entities/tour_attraction.dart';
import '../../infrastructure/datasources/tour_api_datasource.dart';

/// 관광지 아이템 카드 위젯
class TourItemCard extends ConsumerStatefulWidget {
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
  ConsumerState<TourItemCard> createState() => _TourItemCardState();
}

class _TourItemCardState extends ConsumerState<TourItemCard> {
  late bool _isBookmarked;
  
  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.attraction.isBookmarked == true;
  }
  
  Future<void> _toggleBookmark() async {
    try {
      final repository = ref.read(ktourRepositoryProvider);
      final newBookmarkStatus = !_isBookmarked;
      
      await repository.toggleBookmark(
        contentId: widget.attraction.contentId,
      );
      
      setState(() {
        _isBookmarked = newBookmarkStatus;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(newBookmarkStatus ? '북마크에 추가되었습니다' : '북마크에서 제거되었습니다'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      Log.e('Failed to toggle bookmark', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('북마크 설정 중 오류가 발생했습니다'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지와 북마크 버튼
            if (widget.attraction.firstImage != null && widget.attraction.firstImage!.isNotEmpty)
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: widget.attraction.firstImage!,
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
                  // 북마크 버튼
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white.withOpacity(0.9),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: _toggleBookmark,
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            size: 20,
                            color: _isBookmarked ? theme.colorScheme.primary : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            
            // 컨텐츠
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카테고리 태그
                  if (widget.attraction.contentTypeId != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTypeColor(widget.attraction.contentTypeId)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        TourContentType.getName(widget.attraction.contentTypeId),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getTypeColor(widget.attraction.contentTypeId),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  
                  // 제목
                  Text(
                    widget.attraction.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // 주소
                  if (widget.attraction.address1 != null)
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
                            widget.attraction.address1!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  
                  // 거리 표시
                  if (widget.showDistance && widget.attraction.distance != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.straighten,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getDistanceText(widget.attraction.distance!),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // 전화번호
                  if (widget.attraction.tel?.isNotEmpty == true)
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
                              widget.attraction.tel!,
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

  String _getDistanceText(double distance) {
    if (distance < 1000) {
      return '${distance.toInt()}m';
    } else {
      final km = distance / 1000;
      if (km < 10) {
        return '${km.toStringAsFixed(1)}km';
      } else {
        return '${km.toInt()}km';
      }
    }
  }
}