import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/heritage.dart';

/// 문화재 위치 지도 화면
class HeritageMapScreen extends ConsumerStatefulWidget {
  final Heritage heritage;

  const HeritageMapScreen({
    super.key,
    required this.heritage,
  });

  @override
  ConsumerState<HeritageMapScreen> createState() => _HeritageMapScreenState();
}

class _HeritageMapScreenState extends ConsumerState<HeritageMapScreen> {
  GoogleMapController? _mapController;
  
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heritage = widget.heritage;
    final position = LatLng(heritage.latitude, heritage.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text(heritage.nameKo),
        actions: [
          // 길찾기 버튼
          IconButton(
            icon: const Icon(Icons.directions),
            onPressed: _openNavigation,
            tooltip: '길찾기',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Google Maps
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: position,
              zoom: 16.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: {
              Marker(
                markerId: MarkerId(heritage.id),
                position: position,
                infoWindow: InfoWindow(
                  title: heritage.nameKo,
                  snippet: heritage.address,
                  onTap: () {
                    // 마커 정보창 클릭 시 상세 정보 표시
                    _showHeritageInfo();
                  },
                ),
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),
          
          // 하단 정보 카드
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 문화재 이름
                    Text(
                      heritage.nameKo,
                      style: AppTypography.h5,
                    ),
                    if (heritage.nameEn != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        heritage.nameEn!,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.grayMedium,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    
                    // 카테고리 및 주소
                    Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 16,
                          color: AppColors.grayMedium,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          heritage.category,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grayDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.grayMedium,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            heritage.address,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.grayDark,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // 액션 버튼들
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _openNavigation,
                            icon: const Icon(Icons.directions, size: 18),
                            label: const Text('길찾기'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _shareLocation,
                            icon: const Icon(Icons.share, size: 18),
                            label: const Text('공유'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHeritageInfo() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final heritage = widget.heritage;
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 핸들 바
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grayLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // 문화재 정보
              Text(
                heritage.nameKo,
                style: AppTypography.h4,
              ),
              const SizedBox(height: 12),
              
              if (heritage.descriptionKo != null) ...[
                Text(
                  heritage.descriptionKo!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.grayDark,
                    height: 1.6,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
              ],
              
              // 상세 정보
              _buildInfoRow('카테고리', heritage.category),
              _buildInfoRow('주소', heritage.address),
              if (heritage.period != null)
                _buildInfoRow('시대', heritage.period!),
              if (heritage.admin != null)
                _buildInfoRow('관리처', heritage.admin!),
              
              const SizedBox(height: 20),
              
              // 닫기 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('닫기'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.grayMedium,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.grayDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openNavigation() {
    final heritage = widget.heritage;
    // TODO: 외부 네비게이션 앱 연동
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${heritage.nameKo}까지의 경로 안내를 시작합니다'),
        action: SnackBarAction(
          label: '구글맵',
          onPressed: () {
            // Google Maps 앱 열기
          },
        ),
      ),
    );
  }

  void _shareLocation() {
    final heritage = widget.heritage;
    // TODO: 위치 공유 기능 구현
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${heritage.nameKo} 위치를 공유합니다'),
      ),
    );
  }
}