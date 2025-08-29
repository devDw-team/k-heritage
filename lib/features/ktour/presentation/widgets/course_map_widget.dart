import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/tour_course.dart';

class CourseMapWidget extends StatefulWidget {
  final TourCourse course;
  final Function(int)? onMarkerTap;

  const CourseMapWidget({
    super.key,
    required this.course,
    this.onMarkerTap,
  });

  @override
  State<CourseMapWidget> createState() => _CourseMapWidgetState();
}

class _CourseMapWidgetState extends State<CourseMapWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setupMarkers();
    _setupPolylines();
  }

  void _setupMarkers() {
    final markers = <Marker>{};

    // 메인 위치 마커
    if (widget.course.mapx != null && widget.course.mapy != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('main'),
          position: LatLng(widget.course.mapy!, widget.course.mapx!),
          infoWindow: InfoWindow(
            title: widget.course.title,
            snippet: widget.course.addr1,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      );
    }

    // 코스 단계별 마커
    if (widget.course.steps != null) {
      for (int i = 0; i < widget.course.steps!.length; i++) {
        final step = widget.course.steps![i];
        if (step.latitude != null && step.longitude != null) {
          markers.add(
            Marker(
              markerId: MarkerId('step_$i'),
              position: LatLng(step.latitude!, step.longitude!),
              infoWindow: InfoWindow(
                title: '${i + 1}. ${step.subname}',
                snippet: step.address,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
              onTap: () {
                widget.onMarkerTap?.call(i);
              },
            ),
          );
        }
      }
    }

    setState(() {
      _markers = markers;
    });
  }

  void _setupPolylines() {
    if (widget.course.steps == null || widget.course.steps!.isEmpty) return;

    final points = <LatLng>[];

    // 시작점
    if (widget.course.mapx != null && widget.course.mapy != null) {
      points.add(LatLng(widget.course.mapy!, widget.course.mapx!));
    }

    // 코스 단계별 경로점
    for (final step in widget.course.steps!) {
      if (step.latitude != null && step.longitude != null) {
        points.add(LatLng(step.latitude!, step.longitude!));
      }
    }

    if (points.length > 1) {
      setState(() {
        _polylines = {
          Polyline(
            polylineId: const PolylineId('course_route'),
            points: points,
            color: Theme.of(context).primaryColor,
            width: 4,
            patterns: [],
          ),
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialPosition = widget.course.mapx != null && widget.course.mapy != null
        ? LatLng(widget.course.mapy!, widget.course.mapx!)
        : const LatLng(37.5665, 126.9780); // 서울시청 기본 좌표

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 7, // 더 넓은 영역을 보기 위해 줌 레벨 추가 감소
          ),
          markers: _markers,
          polylines: _polylines,
          onMapCreated: (controller) {
            _mapController = controller;
            // 지도 로드 후 충분한 대기 후 bounds 적용
            Future.delayed(const Duration(seconds: 3), () {
              _fitBounds();
            });
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
        ),
        
        // 지도 컨트롤 버튼
        Positioned(
          right: 16,
          bottom: 16,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                heroTag: 'course_map_fit_bounds',
                backgroundColor: Colors.white,
                onPressed: _fitBounds,
                child: Icon(
                  Icons.crop_free,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                mini: true,
                heroTag: 'course_map_zoom_in',
                backgroundColor: Colors.white,
                onPressed: _zoomIn,
                child: Icon(
                  Icons.add,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                mini: true,
                heroTag: 'course_map_zoom_out',
                backgroundColor: Colors.white,
                onPressed: _zoomOut,
                child: Icon(
                  Icons.remove,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        
        // 범례
        Positioned(
          left: 16,
          top: 16,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '코스 경로',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '추천 경로',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '시작점',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '경유지',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _fitBounds() {
    if (_mapController == null || _markers.isEmpty) return;

    // 모든 마커를 포함하는 범위 계산
    double minLat = _markers.first.position.latitude;
    double maxLat = _markers.first.position.latitude;
    double minLng = _markers.first.position.longitude;
    double maxLng = _markers.first.position.longitude;

    for (final marker in _markers) {
      minLat = minLat > marker.position.latitude
          ? marker.position.latitude
          : minLat;
      maxLat = maxLat < marker.position.latitude
          ? marker.position.latitude
          : maxLat;
      minLng = minLng > marker.position.longitude
          ? marker.position.longitude
          : minLng;
      maxLng = maxLng < marker.position.longitude
          ? marker.position.longitude
          : maxLng;
    }

    // 경계에 여유 공간 추가
    final latPadding = (maxLat - minLat) * 0.2;
    final lngPadding = (maxLng - minLng) * 0.2;
    
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat - latPadding, minLng - lngPadding),
          northeast: LatLng(maxLat + latPadding, maxLng + lngPadding),
        ),
        150, // 화면 가장자리와의 여백 증가
      ),
    );
  }

  void _zoomIn() {
    _mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController?.animateCamera(CameraUpdate.zoomOut());
  }
}