import 'package:flutter/material.dart';
import '../../domain/entities/tour_festival.dart';

/// 축제 상태 표시 칩
class FestivalStatusChip extends StatelessWidget {
  final FestivalStatus status;
  final bool showIcon;
  
  const FestivalStatusChip({
    super.key,
    required this.status,
    this.showIcon = true,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor(status).withOpacity(0.5),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              _getStatusIcon(status),
              size: 12,
              color: _getStatusColor(status),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            status.displayName,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _getStatusColor(status),
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getStatusColor(FestivalStatus status) {
    switch (status) {
      case FestivalStatus.ongoing:
        return Colors.green.shade700;
      case FestivalStatus.upcoming:
        return Colors.blue.shade700;
      case FestivalStatus.ended:
        return Colors.grey.shade600;
      case FestivalStatus.unknown:
        return Colors.grey.shade600;
    }
  }
  
  IconData _getStatusIcon(FestivalStatus status) {
    switch (status) {
      case FestivalStatus.ongoing:
        return Icons.play_circle_outline;
      case FestivalStatus.upcoming:
        return Icons.schedule;
      case FestivalStatus.ended:
        return Icons.check_circle_outline;
      case FestivalStatus.unknown:
        return Icons.help_outline;
    }
  }
}