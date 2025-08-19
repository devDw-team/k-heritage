import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/heritage.dart';
import '../widgets/heritage_card.dart';
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
  
  String _selectedCategory = '전체';
  final Set<Marker> _markers = {};
  bool _isMapReady = false;
  
  // 서울 시청 기본 좌표
  static const LatLng _defaultLocation = LatLng(37.5665, 126.9780);
  LatLng _currentLocation = _defaultLocation;

  // 더미 데이터
  final List<Heritage> _heritages = [
    const Heritage(
      id: '1',
      nameKo: '숭례문',
      category: '국보',
      latitude: 37.5598,
      longitude: 126.9755,
      address: '서울특별시 중구 세종대로 40',
      designatedYear: '1962',
      descriptionKo: '서울의 남대문으로 알려진 조선시대 한양도성의 정문',
      distance: 0.8,
    ),
    const Heritage(
      id: '2',
      nameKo: '덕수궁 중화전',
      category: '보물',
      latitude: 37.5658,
      longitude: 126.9751,
      address: '서울특별시 중구 세종대로 99',
      designatedYear: '1985',
      descriptionKo: '덕수궁의 정전으로 왕의 즉위식과 중요한 의식이 거행되던 곳',
      distance: 1.2,
    ),
    const Heritage(
      id: '3',
      nameKo: '경복궁',
      category: '사적',
      latitude: 37.5796,
      longitude: 126.9770,
      address: '서울특별시 종로구 사직로 161',
      designatedYear: '1963',
      descriptionKo: '조선왕조 제일의 법궁',
      distance: 1.5,
    ),
  ];

  final List<String> _categories = ['전체', '국보', '보물', '사적', '명승'];

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  void _initializeMarkers() {
    for (final heritage in _heritages) {
      _markers.add(
        Marker(
          markerId: MarkerId(heritage.id),
          position: LatLng(heritage.latitude, heritage.longitude),
          infoWindow: InfoWindow(
            title: heritage.nameKo,
            snippet: heritage.category,
          ),
          onTap: () => _onMarkerTapped(heritage),
        ),
      );
    }
  }

  void _onMarkerTapped(Heritage heritage) {
    // 하단 시트 확장
    _sheetController.animateTo(
      0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
    
    // TODO: 선택된 문화재로 스크롤
  }

  void _onMyLocationPressed() {
    // TODO: 현재 위치로 이동
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLocation, 15),
    );
  }

  Widget _buildMap() {
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
                  },
                  initialCameraPosition: const CameraPosition(
                    target: _defaultLocation,
                    zoom: 14,
                  ),
                  markers: _markers,
                  myLocationEnabled: false, // 권한 처리 전까지 비활성화
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
          _buildMap(),
          
          // FAB (현재 위치)
          Positioned(
            right: 16,
            bottom: MediaQuery.of(context).size.height * 0.5,
            child: FloatingActionButton(
              onPressed: _onMyLocationPressed,
              child: const Icon(Icons.my_location),
            ),
          ),
          
          // 하단 시트
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.9,
            snap: true,
            snapSizes: const [0.1, 0.3, 0.9],
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
                          return CategoryChip(
                            label: category,
                            isSelected: _selectedCategory == category,
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // 문화재 리스트
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: _heritages.length,
                        itemBuilder: (context, index) {
                          final heritage = _heritages[index];
                          return HeritageCard(
                            heritage: heritage,
                            onTap: () {
                              context.push('/heritage/${heritage.id}');
                            },
                          );
                        },
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