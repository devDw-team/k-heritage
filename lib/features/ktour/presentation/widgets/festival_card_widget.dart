import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/tour_festival.dart';
import 'festival_status_chip.dart';

/// 축제 카드 위젯
class FestivalCardWidget extends StatelessWidget {
  final TourFestival festival;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  
  const FestivalCardWidget({
    super.key,
    required this.festival,
    this.onTap,
    this.onBookmarkTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnded = festival.status == FestivalStatus.ended;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Opacity(
          opacity: isEnded ? 0.6 : 1.0,
          child: SizedBox(
            height: 140,
            child: Row(
              children: [
                // 이미지
                AspectRatio(
                  aspectRatio: 1,
                  child: festival.hasImage
                      ? CachedNetworkImage(
                          imageUrl: festival.firstImage2 ?? festival.firstImage!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: Icon(
                              Icons.festival,
                              size: 40,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      : Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.festival,
                            size: 40,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                ),
                
                // 정보
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 제목 및 상태
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                festival.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            FestivalStatusChip(status: festival.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        
                        // 기간
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              festival.periodDisplay.isNotEmpty
                                  ? festival.periodDisplay
                                  : '날짜 정보 없음',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        
                        // 장소
                        if (festival.eventPlace != null) ...[
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
                                  festival.eventPlace!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                        
                        const Spacer(),
                        
                        // 하단 정보
                        Row(
                          children: [
                            // D-Day 또는 진행 상태
                            if (festival.dDayDisplay != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDDayColor(festival.status, theme),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  festival.dDayDisplay!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: _getDDayTextColor(festival.status, theme),
                                  ),
                                ),
                              ),
                            
                            const Spacer(),
                            
                            // 북마크 버튼
                            if (onBookmarkTap != null)
                              IconButton(
                                icon: Icon(
                                  festival.isBookmarked 
                                      ? Icons.bookmark 
                                      : Icons.bookmark_border,
                                  color: festival.isBookmarked
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                                iconSize: 20,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: onBookmarkTap,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Color _getDDayColor(FestivalStatus status, ThemeData theme) {
    switch (status) {
      case FestivalStatus.ongoing:
        return Colors.green.withOpacity(0.2);
      case FestivalStatus.upcoming:
        return Colors.blue.withOpacity(0.2);
      case FestivalStatus.ended:
        return Colors.grey.withOpacity(0.2);
      default:
        return theme.colorScheme.surfaceContainerHighest;
    }
  }
  
  Color _getDDayTextColor(FestivalStatus status, ThemeData theme) {
    switch (status) {
      case FestivalStatus.ongoing:
        return Colors.green.shade700;
      case FestivalStatus.upcoming:
        return Colors.blue.shade700;
      case FestivalStatus.ended:
        return Colors.grey.shade700;
      default:
        return theme.colorScheme.onSurfaceVariant;
    }
  }
}