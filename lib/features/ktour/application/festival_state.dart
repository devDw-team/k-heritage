import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/entities/tour_festival.dart';

part 'festival_state.freezed.dart';

/// 축제 화면 상태 관리
@freezed
class FestivalState with _$FestivalState {
  const factory FestivalState({
    /// 축제 목록
    @Default([]) List<TourFestival> festivals,
    
    /// 전체 축제 목록 (필터링 전)
    @Default([]) List<TourFestival> allFestivals,
    
    /// 로딩 상태
    @Default(true) bool isLoading,
    
    /// 추가 데이터 로딩 중
    @Default(false) bool isLoadingMore,
    
    /// 에러 메시지
    String? error,
    
    /// 필터: 축제 상태
    FestivalStatus? filterStatus,
    
    /// 필터: 지역 코드
    String? filterAreaCode,
    
    /// 필터: 시군구 코드
    String? filterSigunguCode,
    
    /// 필터: 선택된 월
    DateTime? filterMonth,
    
    /// 검색 키워드
    String? searchKeyword,
    
    /// 정렬 옵션 (R=시작일순, O=제목순)
    @Default('R') String sortBy,
    
    /// 현재 페이지
    @Default(1) int currentPage,
    
    /// 더 많은 데이터 존재 여부
    @Default(false) bool hasMore,
    
    /// 보기 모드 (list, calendar, map)
    @Default('list') String viewMode,
    
    /// 선택된 날짜 (캘린더 뷰용)
    DateTime? selectedDate,
    
    /// 북마크된 축제 ID 목록
    @Default([]) List<String> bookmarkedIds,
  }) = _FestivalState;
  
  const FestivalState._();
  
  /// 진행중인 축제만 필터링
  List<TourFestival> get ongoingFestivals =>
      festivals.where((f) => f.status == FestivalStatus.ongoing).toList();
  
  /// 예정된 축제만 필터링
  List<TourFestival> get upcomingFestivals =>
      festivals.where((f) => f.status == FestivalStatus.upcoming).toList();
  
  /// 종료된 축제만 필터링
  List<TourFestival> get endedFestivals =>
      festivals.where((f) => f.status == FestivalStatus.ended).toList();
  
  /// 선택된 날짜의 축제 필터링 (캘린더 뷰용)
  List<TourFestival> getFestivalsForDate(DateTime date) {
    return festivals.where((festival) {
      if (festival.eventStartDate == null || festival.eventEndDate == null) {
        return false;
      }
      
      final startDate = _parseDate(festival.eventStartDate!);
      final endDate = _parseDate(festival.eventEndDate!);
      
      if (startDate == null || endDate == null) return false;
      
      // 날짜가 축제 기간에 포함되는지 확인
      return !date.isBefore(startDate) && !date.isAfter(endDate);
    }).toList();
  }
  
  /// 날짜 파싱 헬퍼 (YYYYMMDD -> DateTime)
  DateTime? _parseDate(String dateStr) {
    if (dateStr.length != 8) return null;
    
    try {
      final year = int.parse(dateStr.substring(0, 4));
      final month = int.parse(dateStr.substring(4, 6));
      final day = int.parse(dateStr.substring(6, 8));
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }
}

/// 축제 필터 옵션
class FestivalFilterOptions {
  final FestivalStatus? status;
  final String? areaCode;
  final String? sigunguCode;
  final DateTime? month;
  final String? keyword;
  final String sortBy;
  
  const FestivalFilterOptions({
    this.status,
    this.areaCode,
    this.sigunguCode,
    this.month,
    this.keyword,
    this.sortBy = 'R',
  });
  
  FestivalFilterOptions copyWith({
    FestivalStatus? status,
    String? areaCode,
    String? sigunguCode,
    DateTime? month,
    String? keyword,
    String? sortBy,
  }) {
    return FestivalFilterOptions(
      status: status ?? this.status,
      areaCode: areaCode ?? this.areaCode,
      sigunguCode: sigunguCode ?? this.sigunguCode,
      month: month ?? this.month,
      keyword: keyword ?? this.keyword,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}