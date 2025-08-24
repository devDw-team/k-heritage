import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/heritage.dart';
import '../../application/heritage_controller.dart';
import '../widgets/heritage_list_tile.dart';
import '../widgets/category_chip.dart';

/// 홈 화면 (지도 + 하단 시트)
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  GoogleMapController? _mapController;
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  
  bool _isMapReady = false;
  
  // 서울 시청 기본 좌표
  static const LatLng _defaultLocation = LatLng(37.5665, 126.9780);

  final List<String> _categories = ['전체', '국보', '보물', '사적', '명승', '천연기념물', '무형문화재'];

  @override
  void initState() {
    super.initState();
    // Load heritage data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(heritageControllerProvider.notifier).loadNearbyHeritages();
    });
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  Set<Marker> _buildMarkers(List<Heritage> heritages) {
    final selectedHeritage = ref.read(heritageControllerProvider).selectedHeritage;
    
    return heritages.map((heritage) {
      final isSelected = selectedHeritage?.id == heritage.id;
      
      return Marker(
        markerId: MarkerId(heritage.id),
        position: LatLng(heritage.latitude, heritage.longitude),
        infoWindow: InfoWindow(
          title: heritage.nameKo,
          snippet: heritage.category,
        ),
        icon: isSelected 
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
          : BitmapDescriptor.defaultMarker,
        onTap: () => _onMarkerTapped(heritage.id),
      );
    }).toSet();
  }

  void _onMarkerTapped(String heritageId) {
    // Select heritage in controller
    ref.read(heritageControllerProvider.notifier).selectHeritage(heritageId);
    
    // 하단 시트 확장
    _sheetController.animateTo(
      0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _onMyLocationPressed() async {
    final state = ref.read(heritageControllerProvider);
    
    if (!state.hasLocationPermission) {
      // Request permission
      await ref.read(heritageControllerProvider.notifier).requestLocationPermission();
    }
    
    final position = ref.read(heritageControllerProvider).currentPosition;
    if (position != null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          15,
        ),
      );
    }
  }

  Widget _buildMap(HeritageState heritageState) {
    final markers = _buildMarkers(heritageState.filteredHeritages);
    
    // Google Maps API 키가 설정되지 않은 경우 플레이스홀더 표시
    return Container(
      color: AppColors.grayLight.withOpacity(0.3),
      child: Stack(
        children: [
          // 임시로 GoogleMap 위젯을 try-catch로 감싸기
          Builder(
            builder: (context) {
              try {
                return GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      _mapController = controller;
                      _isMapReady = true;
                    });
                    
                    // Move camera to current position if available
                    final position = heritageState.currentPosition;
                    if (position != null) {
                      _mapController?.animateCamera(
                        CameraUpdate.newLatLngZoom(
                          LatLng(position.latitude, position.longitude),
                          14,
                        ),
                      );
                    }
                  },
                  initialCameraPosition: CameraPosition(
                    target: heritageState.currentPosition != null
                        ? LatLng(heritageState.currentPosition!.latitude,
                                heritageState.currentPosition!.longitude)
                        : _defaultLocation,
                    zoom: 14,
                  ),
                  markers: markers,
                  myLocationEnabled: heritageState.hasLocationPermission,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                );
              } catch (e) {
                // Google Maps 초기화 실패 시 플레이스홀더
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        size: 64,
                        color: AppColors.grayMedium.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '지도를 불러오는 중...',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.grayDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Google Maps API 키 설정이 필요합니다',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.grayMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heritageState = ref.watch(heritageControllerProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('주변 문화재'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 검색 화면 이동
            },
          ),
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              // TODO: 언어 변경 다이얼로그
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 지도 (에러 처리 추가)
          _buildMap(heritageState),
          
          // Loading indicator
          if (heritageState.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          
          // Error message
          if (heritageState.error != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 80,
              left: 16,
              right: 16,
              child: Card(
                color: Colors.red.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          heritageState.error!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          ref.read(heritageControllerProvider.notifier).clearError();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          // FAB (현재 위치)
          Positioned(
            right: 16,
            bottom: MediaQuery.of(context).size.height * 0.48,
            child: FloatingActionButton(
              onPressed: _onMyLocationPressed,
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.primary,
              elevation: 4,
              child: const Icon(Icons.my_location),
            ),
          ),
          
          // 하단 시트
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.45,
            minChildSize: 0.25,
            maxChildSize: 0.9,
            snap: true,
            snapSizes: const [0.25, 0.45, 0.9],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppTheme.radiusXl),
                  ),
                  boxShadow: AppTheme.shadowLg,
                ),
                child: Column(
                  children: [
                    // 핸들
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.grayLight,
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      ),
                    ),
                    
                    // 카테고리 필터
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = category == '전체' 
                              ? heritageState.selectedCategory == null
                              : heritageState.selectedCategory == category;
                          return CategoryChip(
                            label: category,
                            isSelected: isSelected,
                            onTap: () {
                              ref.read(heritageControllerProvider.notifier)
                                  .setCategory(category == '전체' ? null : category);
                            },
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // 문화재 리스트
                    Expanded(
                      child: heritageState.filteredHeritages.isEmpty
                          ? Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_off,
                                      size: 48,
                                      color: AppColors.grayMedium.withOpacity(0.5),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '주변에 문화재가 없습니다',
                                      style: AppTypography.bodyLarge.copyWith(
                                        color: AppColors.grayDark,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        ref.read(heritageControllerProvider.notifier).refreshHeritages();
                                      },
                                      child: const Text('새로고침'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                await ref.read(heritageControllerProvider.notifier).refreshHeritages();
                              },
                              child: ListView.builder(
                                controller: scrollController,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                itemCount: heritageState.filteredHeritages.length,
                                itemBuilder: (context, index) {
                                  final heritage = heritageState.filteredHeritages[index];
                                  return HeritageListTile(
                                    heritage: heritage,
                                    onTap: () {
                                      context.push('/heritage/${heritage.id}');
                                    },
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}