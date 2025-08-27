import '../entities/tour_attraction.dart';
import '../entities/tour_festival.dart';
import '../entities/tour_stay.dart';
import '../entities/bookmark_item.dart';

/// K-TOUR Repository 인터페이스
abstract class KTourRepository {
  /// 지역별 관광지 조회
  Future<List<TourAttraction>> getAttractionsByArea({
    String? areaCode,
    String? sigunguCode,
    int? contentTypeId,
    String? cat1,
    String? cat2,
    String? cat3,
    int pageNo = 1,
    int numOfRows = 20,
  });
  
  /// 내 주변 관광지 조회
  Future<List<TourAttraction>> getNearbyAttractions({
    required double latitude,
    required double longitude,
    int radius = 5000,
    int? contentTypeId,
    int pageNo = 1,
    int numOfRows = 20,
  });
  
  /// 키워드로 관광지 검색
  Future<List<TourAttraction>> searchAttractions({
    required String keyword,
    String? areaCode,
    String? sigunguCode,
    int? contentTypeId,
    int pageNo = 1,
    int numOfRows = 20,
  });
  
  /// 관광지 상세 정보 조회
  Future<TourAttraction?> getAttractionDetail({
    required String contentId,
    int? contentTypeId,
  });
  
  /// 행사/축제 목록 조회
  Future<List<TourFestival>> getFestivals({
    required DateTime startDate,
    DateTime? endDate,
    String? areaCode,
    String? sigunguCode,
    int pageNo = 1,
    int numOfRows = 20,
  });
  
  /// 진행중인 행사/축제 조회
  Future<List<TourFestival>> getOngoingFestivals({
    String? areaCode,
    String? sigunguCode,
    int pageNo = 1,
    int numOfRows = 20,
  });
  
  /// 예정된 행사/축제 조회
  Future<List<TourFestival>> getUpcomingFestivals({
    String? areaCode,
    String? sigunguCode,
    int daysAhead = 30,
    int pageNo = 1,
    int numOfRows = 20,
  });
  
  /// 축제 상세 정보 조회
  Future<TourFestival?> getFestivalDetail({
    required String contentId,
  });
  
  /// 숙박 시설 목록 조회
  Future<List<TourStay>> getStays({
    String? areaCode,
    String? sigunguCode,
    bool? hanOk,
    bool? goodStay,
    int pageNo = 1,
    int numOfRows = 20,
  });
  
  /// 내 주변 숙박 시설 조회
  Future<List<TourStay>> getNearbyStays({
    required double latitude,
    required double longitude,
    int radius = 5000,
    bool? hanOk,
    bool? goodStay,
    int pageNo = 1,
    int numOfRows = 20,
  });
  
  /// 숙박 시설 상세 정보 조회
  Future<TourStay?> getStayDetail({
    required String contentId,
  });
  
  /// 지역 코드 목록 조회
  Future<List<AreaCode>> getAreaCodes({
    String? parentCode,
  });
  
  /// 카테고리 코드 목록 조회
  Future<List<CategoryCode>> getCategoryCodes({
    String? cat1,
    String? cat2,
  });
  
  /// 북마크 추가
  Future<void> addBookmark({
    required String contentId,
    required String contentType,
  });
  
  /// 북마크 제거
  Future<void> removeBookmark({
    required String contentId,
  });
  
  /// 북마크 목록 조회
  Future<List<String>> getBookmarkIds();
  
  /// 북마크 토글
  Future<void> toggleBookmark({
    required String contentId,
  });
  
  /// 북마크 설정
  Future<void> setBookmark({
    required String contentId,
    required bool isBookmarked,
  });
  
  /// 북마크와 상세 정보 저장
  Future<void> saveBookmarkWithDetails({
    required BookmarkItem bookmarkItem,
  });
  
  /// 북마크된 관광지 목록 조회
  Future<List<BookmarkItem>> getBookmarkedAttractions();
  
  /// 특정 항목이 북마크되었는지 확인
  Future<bool> isBookmarked(String contentId);
  
  /// 캐시 클리어
  Future<void> clearCache();
}

/// 지역 코드 모델
class AreaCode {
  final String code;
  final String name;
  final int rnum;
  
  const AreaCode({
    required this.code,
    required this.name,
    required this.rnum,
  });
  
  factory AreaCode.fromJson(Map<String, dynamic> json) {
    return AreaCode(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      rnum: int.tryParse(json['rnum']?.toString() ?? '0') ?? 0,
    );
  }
}

/// 카테고리 코드 모델
class CategoryCode {
  final String code;
  final String name;
  final int rnum;
  
  const CategoryCode({
    required this.code,
    required this.name,
    required this.rnum,
  });
  
  factory CategoryCode.fromJson(Map<String, dynamic> json) {
    return CategoryCode(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      rnum: int.tryParse(json['rnum']?.toString() ?? '0') ?? 0,
    );
  }
}