import 'package:flutter/material.dart';

/// 내 주변 필터 위젯
class NearbyFilterWidget extends StatelessWidget {
  final int radius;
  final bool hasLocation;
  final bool isRequestingLocation;
  final Function(int) onRadiusChanged;
  final VoidCallback onRequestLocation;

  const NearbyFilterWidget({
    super.key,
    required this.radius,
    required this.hasLocation,
    this.isRequestingLocation = false,
    required this.onRadiusChanged,
    required this.onRequestLocation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (!hasLocation) {
      // 위치 정보 없음
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_off,
                size: 28,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              const SizedBox(height: 6),
              Text(
                '위치 정보가 필요합니다',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 32,
                child: isRequestingLocation
                    ? const SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : FilledButton.icon(
                        onPressed: onRequestLocation,
                        icon: const Icon(Icons.my_location, size: 16),
                        label: const Text('위치 권한 요청', style: TextStyle(fontSize: 12)),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          minimumSize: const Size(0, 32),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    }

    // 반경 선택 슬라이더
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.my_location,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '검색 반경',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _getRadiusText(radius),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          
          // 슬라이더
          SizedBox(
            height: 30,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              ),
              child: Slider(
                value: _radiusToSliderValue(radius),
                min: 0,
                max: 6,
                divisions: 6,
                label: _getRadiusText(radius),
                onChanged: (value) {
                  onRadiusChanged(_sliderValueToRadius(value));
                },
              ),
            ),
          ),
          
          // 프리셋 버튼
          SizedBox(
            height: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPresetButton(context, 1000, '1km'),
                _buildPresetButton(context, 3000, '3km'),
                _buildPresetButton(context, 5000, '5km'),
                _buildPresetButton(context, 10000, '10km'),
                _buildPresetButton(context, 20000, '20km'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetButton(BuildContext context, int value, String label) {
    final theme = Theme.of(context);
    final isSelected = radius == value;
    
    return TextButton(
      onPressed: () => onRadiusChanged(value),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        minimumSize: const Size(0, 24),
        backgroundColor: isSelected 
            ? theme.colorScheme.primaryContainer
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: isSelected 
              ? theme.colorScheme.onPrimaryContainer
              : theme.colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  String _getRadiusText(int radius) {
    if (radius < 1000) {
      return '${radius}m';
    } else {
      final km = radius / 1000;
      if (km == km.toInt()) {
        return '${km.toInt()}km';
      } else {
        return '${km.toStringAsFixed(1)}km';
      }
    }
  }

  double _radiusToSliderValue(int radius) {
    // 500m, 1km, 2km, 3km, 5km, 10km, 20km
    if (radius <= 500) return 0;
    if (radius <= 1000) return 1;
    if (radius <= 2000) return 2;
    if (radius <= 3000) return 3;
    if (radius <= 5000) return 4;
    if (radius <= 10000) return 5;
    return 6;
  }

  int _sliderValueToRadius(double value) {
    switch (value.round()) {
      case 0: return 500;
      case 1: return 1000;
      case 2: return 2000;
      case 3: return 3000;
      case 4: return 5000;
      case 5: return 10000;
      case 6: return 20000;
      default: return 5000;
    }
  }
}