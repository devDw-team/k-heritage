import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/entities/tour_attraction.dart';
import '../domain/entities/tour_festival.dart';
import '../domain/entities/tour_stay.dart';

part 'ktour_state.freezed.dart';

/// K-TOUR 상태
@freezed
class KTourState with _$KTourState {
  const factory KTourState({
    // 인기 관광지
    @Default([]) List<TourAttraction> popularAttractions,
    @Default(false) bool isLoadingPopular,
    String? popularError,
    
    // 진행중인 축제
    @Default([]) List<TourFestival> ongoingFestivals,
    @Default(false) bool isLoadingFestivals,
    String? festivalsError,
    
    // 내 주변 관광지
    @Default([]) List<TourAttraction> nearbyAttractions,
    @Default(false) bool isLoadingNearby,
    String? nearbyError,
    
    // 추천 숙박
    @Default([]) List<TourStay> recommendedStays,
    @Default(false) bool isLoadingStays,
    String? staysError,
    
    // 현재 위치
    double? currentLatitude,
    double? currentLongitude,
    
    // 선택된 지역 코드
    String? selectedAreaCode,
    String? selectedSigunguCode,
    
    // 검색 키워드
    String? searchKeyword,
    
    // 로딩 상태
    @Default(false) bool isInitializing,
    
    // 마지막 업데이트 시간
    DateTime? lastUpdated,
  }) = _KTourState;
  
  const KTourState._();
  
  /// 전체 로딩 상태
  bool get isLoading => 
    isLoadingPopular || isLoadingFestivals || isLoadingNearby || isLoadingStays;
  
  /// 에러 상태
  bool get hasError => 
    popularError != null || festivalsError != null || nearbyError != null || staysError != null;
  
  /// 위치 정보 사용 가능
  bool get hasLocation => 
    currentLatitude != null && currentLongitude != null;
}