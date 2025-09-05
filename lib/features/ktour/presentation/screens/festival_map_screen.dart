import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/tour_festival.dart';
import '../widgets/festival_status_chip.dart';
import '../../../../core/utils/logger.dart';

/// 축제 위치 지도 화면
class FestivalMapScreen extends ConsumerStatefulWidget {
  final TourFestival festival;

  const FestivalMapScreen({
    super.key,
    required this.festival,
  });

  @override
  ConsumerState<FestivalMapScreen> createState() => _FestivalMapScreenState();
}

class _FestivalMapScreenState extends ConsumerState<FestivalMapScreen> {
  GoogleMapController? _mapController;
  
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _openExternalNavigation() async {
    final lat = widget.festival.mapY ?? 37.5665;
    final lng = widget.festival.mapX ?? 126.9780;
    final name = Uri.encodeComponent(widget.festival.title);
    
    // Google Maps URL for navigation
    final googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';
    
    // Kakao Map URL
    final kakaoMapUrl = 'kakaomap://route?ep=$lat,$lng&by=CAR';
    
    // Naver Map URL
    final naverMapUrl = 'nmap://route/car?dlat=$lat&dlng=$lng&dname=$name&appname=com.example.kheritagexplorer';
    
    try {
      // Try Kakao Map first
      if (await canLaunchUrl(Uri.parse(kakaoMapUrl))) {
        await launchUrl(Uri.parse(kakaoMapUrl));
      } 
      // Try Naver Map
      else if (await canLaunchUrl(Uri.parse(naverMapUrl))) {
        await launchUrl(Uri.parse(naverMapUrl));
      }
      // Fallback to Google Maps
      else {
        await launchUrl(Uri.parse(googleMapsUrl), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      Log.e('Failed to open navigation', error: e);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('내비게이션을 열 수 없습니다')),
      );
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final festival = widget.festival;
    final position = LatLng(
      festival.mapY ?? 37.5665,
      festival.mapX ?? 126.9780,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(festival.title),
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        actions: [
          // 외부 내비게이션 열기
          IconButton(
            icon: const Icon(Icons.navigation),
            onPressed: _openExternalNavigation,
            tooltip: '내비게이션',
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
                markerId: MarkerId(festival.contentId),
                position: position,
                infoWindow: InfoWindow(
                  title: festival.title,
                  snippet: festival.eventPlace ?? festival.fullAddress,
                ),
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            mapToolbarEnabled: false,
            compassEnabled: true,
          ),
          
          // 하단 정보 카드
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 핸들바
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12, bottom: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outline.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  // 콘텐츠
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이미지와 정보
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 이미지
                            if (festival.hasImage)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: festival.firstImage2 ?? festival.firstImage!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: theme.colorScheme.surfaceVariant,
                                    child: const Center(
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    color: theme.colorScheme.surfaceVariant,
                                    child: const Icon(Icons.festival, size: 30),
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.festival,
                                  size: 30,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            
                            const SizedBox(width: 16),
                            
                            // 정보
                            Expanded(
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
                                  const SizedBox(height: 4),
                                  
                                  // D-Day
                                  if (festival.dDayDisplay != null)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
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
                                  const SizedBox(height: 4),
                                  
                                  // 기간
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 14,
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          festival.periodDisplay.isNotEmpty
                                              ? festival.periodDisplay
                                              : '날짜 정보 없음',
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  
                                  // 장소
                                  if (festival.eventPlace != null)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
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
                                  
                                  // 전화번호
                                  if (festival.tel != null) ...[
                                    const SizedBox(height: 4),
                                    GestureDetector(
                                      onTap: () => _makePhoneCall(festival.tel!),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone_outlined,
                                            size: 14,
                                            color: theme.colorScheme.primary,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              festival.tel!,
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                color: theme.colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // 버튼들
                        Row(
                          children: [
                            // 길찾기 버튼
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: _openExternalNavigation,
                                icon: const Icon(Icons.navigation, size: 18),
                                label: const Text('길찾기'),
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(0, 48),
                                ),
                              ),
                            ),
                            
                            const SizedBox(width: 12),
                            
                            // 상세보기 버튼
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.info_outline, size: 18),
                                label: const Text('상세 정보'),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(0, 48),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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