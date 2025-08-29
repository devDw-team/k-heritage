import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../core/utils/logger.dart';
import '../domain/entities/tour_course.dart';
import '../infrastructure/datasources/tour_api_datasource.dart';
import 'tour_course_state.dart';

class TourCourseController extends StateNotifier<TourCourseState> {
  final TourAPIDataSource _dataSource;
  final SharedPreferences _prefs;
  static const String _cacheKey = 'cached_tour_courses';
  static const String _myCourseKey = 'my_tour_courses';
  static const int _pageSize = 20;

  TourCourseController(this._dataSource, this._prefs)
      : super(const TourCourseState()) {
    _loadCachedData();
    loadRecommendedCourses();
    loadMyCourses();
  }

  /// 캐시된 데이터 로드
  void _loadCachedData() {
    try {
      final cachedJson = _prefs.getString(_cacheKey);
      if (cachedJson != null) {
        final cachedData = json.decode(cachedJson) as List;
        final courses = cachedData
            .map((item) => TourCourse.fromJson(item as Map<String, dynamic>))
            .toList();
        state = state.copyWith(courses: courses, filteredCourses: courses);
      }
    } catch (e) {
      Log.e('Failed to load cached courses', error: e);
    }
  }

  /// 데이터 캐싱
  Future<void> _cacheData(List<TourCourse> courses) async {
    try {
      final jsonData = courses.map((course) => course.toJson()).toList();
      await _prefs.setString(_cacheKey, json.encode(jsonData));
    } catch (e) {
      Log.e('Failed to cache courses', error: e);
    }
  }

  /// 추천 코스 로드
  Future<void> loadRecommendedCourses() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final courses = await _dataSource.getTourCourses(
        pageNo: 1,
        numOfRows: 10,
        arrange: 'P', // 인기순
      );

      state = state.copyWith(
        recommendedCourses: courses,
        isLoading: false,
      );
    } catch (e) {
      Log.e('Failed to load recommended courses', error: e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// 코스 목록 로드
  Future<void> loadCourses({
    bool refresh = false,
  }) async {
    if (state.isLoading || (!refresh && state.isLoadingMore)) return;

    final pageNo = refresh ? 1 : state.currentPage;

    state = state.copyWith(
      isLoading: refresh && pageNo == 1,
      isLoadingMore: !refresh && pageNo > 1,
      error: null,
    );

    try {
      final courses = await _dataSource.getTourCourses(
        areaCode: state.selectedAreaCode,
        sigunguCode: state.selectedSigunguCode,
        pageNo: pageNo,
        numOfRows: _pageSize,
        arrange: state.sortBy,
      );

      final hasMore = courses.length >= _pageSize;

      if (refresh || pageNo == 1) {
        final sortedCourses = _sortCourses(courses, state.sortBy);
        state = state.copyWith(
          courses: sortedCourses,
          filteredCourses: _sortCourses(_applyLocalFilters(sortedCourses), state.sortBy),
          currentPage: 2,
          hasMore: hasMore,
          isLoading: false,
          isLoadingMore: false,
        );
        await _cacheData(sortedCourses);
      } else {
        final updatedCourses = [...state.courses, ...courses];
        final sortedCourses = _sortCourses(updatedCourses, state.sortBy);
        state = state.copyWith(
          courses: sortedCourses,
          filteredCourses: _sortCourses(_applyLocalFilters(sortedCourses), state.sortBy),
          currentPage: pageNo + 1,
          hasMore: hasMore,
          isLoading: false,
          isLoadingMore: false,
        );
        await _cacheData(sortedCourses);
      }
    } catch (e) {
      Log.e('Failed to load courses', error: e);
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  /// 더 많은 코스 로드
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    await loadCourses(refresh: false);
  }

  /// 코스 상세 정보 로드
  Future<void> loadCourseDetail(String contentId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final course = await _dataSource.getCourseDetail(contentId);
      state = state.copyWith(
        selectedCourse: course,
        isLoading: false,
      );
    } catch (e) {
      Log.e('Failed to load course detail', error: e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// 필터 적용
  void applyFilters({
    String? areaCode,
    String? sigunguCode,
    String? theme,
    String? difficulty,
    int? minDuration,
    int? maxDuration,
  }) {
    state = state.copyWith(
      selectedAreaCode: areaCode,
      selectedSigunguCode: sigunguCode,
      selectedTheme: theme,
      selectedDifficulty: difficulty,
      minDuration: minDuration,
      maxDuration: maxDuration,
    );

    // 모든 리스트에 로컬 필터 적용
    state = state.copyWith(
      filteredCourses: _applyLocalFilters(state.courses),
      recommendedCourses: _applyLocalFilters(state.recommendedCourses),
    );

    // 필터가 있는 경우에만 서버에서 새 데이터 로드
    if (areaCode != null || theme != null || difficulty != null) {
      loadCourses(refresh: true);
    }
  }

  /// 로컬 필터 적용
  List<TourCourse> _applyLocalFilters(List<TourCourse> courses) {
    return courses.where((course) {
      // 테마 필터
      if (state.selectedTheme != null && 
          course.theme != state.selectedTheme) {
        return false;
      }

      // 난이도 필터
      if (state.selectedDifficulty != null &&
          course.difficulty != state.selectedDifficulty) {
        return false;
      }

      // 소요시간 필터
      if (state.minDuration != null &&
          (course.totalDuration ?? 0) < state.minDuration!) {
        return false;
      }

      if (state.maxDuration != null &&
          (course.totalDuration ?? 0) > state.maxDuration!) {
        return false;
      }

      return true;
    }).toList();
  }

  /// 정렬 변경
  void changeSortBy(String sortBy) {
    if (state.sortBy == sortBy) return;
    
    state = state.copyWith(sortBy: sortBy);
    
    // 로컬 정렬 적용
    state = state.copyWith(
      filteredCourses: _sortCourses(state.filteredCourses, sortBy),
      recommendedCourses: _sortCourses(state.recommendedCourses, sortBy),
      courses: _sortCourses(state.courses, sortBy),
    );
    
    // API 호출로 새 데이터 로드
    loadCourses(refresh: true);
  }
  
  /// 코스 정렬
  List<TourCourse> _sortCourses(List<TourCourse> courses, String sortBy) {
    final sorted = List<TourCourse>.from(courses);
    
    switch (sortBy) {
      case 'A': // 제목순
        sorted.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'R': // 최신순 (contentid가 높을수록 최신)
        sorted.sort((a, b) => b.contentid.compareTo(a.contentid));
        break;
      case 'Q': // 수정일순 (modifiedtime)
        sorted.sort((a, b) {
          final aTime = a.modifiedtime;
          final bTime = b.modifiedtime;
          if (aTime == null && bTime == null) return 0;
          if (aTime == null) return 1;
          if (bTime == null) return -1;
          return bTime.compareTo(aTime);
        });
        break;
      case 'P': // 인기순 (readcount)
      default:
        sorted.sort((a, b) {
          final aCount = a.readcount ?? 0;
          final bCount = b.readcount ?? 0;
          return bCount.compareTo(aCount);
        });
        break;
    }
    
    return sorted;
  }

  /// 필터 초기화
  void clearFilters() {
    state = state.copyWith(
      selectedAreaCode: null,
      selectedSigunguCode: null,
      selectedTheme: null,
      selectedDifficulty: null,
      minDuration: null,
      maxDuration: null,
      filteredCourses: state.courses,
    );
  }

  /// 나만의 코스 로드
  Future<void> loadMyCourses() async {
    try {
      final myCoursesJson = _prefs.getString(_myCourseKey);
      if (myCoursesJson != null) {
        final myCoursesData = json.decode(myCoursesJson) as List;
        final myCourses = myCoursesData
            .map((item) => TourCourse.fromJson(item as Map<String, dynamic>))
            .toList();
        state = state.copyWith(myCourses: myCourses);
      }
    } catch (e) {
      Log.e('Failed to load my courses', error: e);
    }
  }

  /// 나만의 코스 저장
  Future<bool> saveMyCourse(TourCourse course) async {
    try {
      // 이미 저장된 코스인지 확인
      final isAlreadySaved = state.myCourses
          .any((c) => c.contentid == course.contentid);
      
      if (isAlreadySaved) {
        return false; // 이미 저장됨
      }

      final updatedCourses = [...state.myCourses, course];
      state = state.copyWith(myCourses: updatedCourses);

      final jsonData = updatedCourses.map((c) => c.toJson()).toList();
      await _prefs.setString(_myCourseKey, json.encode(jsonData));
      
      return true; // 저장 성공
    } catch (e) {
      Log.e('Failed to save my course', error: e);
      return false;
    }
  }

  /// 나만의 코스 삭제
  Future<void> deleteMyCourse(String contentId) async {
    try {
      final updatedCourses = state.myCourses
          .where((course) => course.contentid != contentId)
          .toList();
      state = state.copyWith(myCourses: updatedCourses);

      final jsonData = updatedCourses.map((c) => c.toJson()).toList();
      await _prefs.setString(_myCourseKey, json.encode(jsonData));
    } catch (e) {
      Log.e('Failed to delete my course', error: e);
    }
  }

  /// 북마크 토글
  Future<void> toggleBookmark(String contentId) async {
    // 현재 북마크 상태 찾기
    TourCourse? targetCourse;
    bool currentBookmarkState = false;
    
    // courses에서 찾기
    for (final course in state.courses) {
      if (course.contentid == contentId) {
        targetCourse = course;
        currentBookmarkState = course.isBookmarked ?? false;
        break;
      }
    }
    
    // recommendedCourses에서 찾기
    if (targetCourse == null) {
      for (final course in state.recommendedCourses) {
        if (course.contentid == contentId) {
          targetCourse = course;
          currentBookmarkState = course.isBookmarked ?? false;
          break;
        }
      }
    }
    
    // filteredCourses에서 찾기
    if (targetCourse == null) {
      for (final course in state.filteredCourses) {
        if (course.contentid == contentId) {
          targetCourse = course;
          currentBookmarkState = course.isBookmarked ?? false;
          break;
        }
      }
    }
    
    if (targetCourse == null) return;
    
    final newBookmarkState = !currentBookmarkState;

    // courses 리스트 업데이트
    final updatedCourses = state.courses.map((course) {
      if (course.contentid == contentId) {
        return course.copyWith(isBookmarked: newBookmarkState);
      }
      return course;
    }).toList();

    // recommendedCourses 리스트 업데이트
    final updatedRecommendedCourses = state.recommendedCourses.map((course) {
      if (course.contentid == contentId) {
        return course.copyWith(isBookmarked: newBookmarkState);
      }
      return course;
    }).toList();

    // filteredCourses 리스트 업데이트
    final updatedFilteredCourses = state.filteredCourses.map((course) {
      if (course.contentid == contentId) {
        return course.copyWith(isBookmarked: newBookmarkState);
      }
      return course;
    }).toList();

    // selectedCourse 업데이트 (상세 화면에서 북마크 토글 시)
    TourCourse? updatedSelectedCourse;
    if (state.selectedCourse != null && state.selectedCourse!.contentid == contentId) {
      updatedSelectedCourse = state.selectedCourse!.copyWith(isBookmarked: newBookmarkState);
    }

    // 상태 업데이트
    state = state.copyWith(
      courses: updatedCourses,
      recommendedCourses: updatedRecommendedCourses,
      filteredCourses: updatedFilteredCourses,
      selectedCourse: updatedSelectedCourse ?? state.selectedCourse,
    );

    // 북마크된 경우 나만의 코스에 추가
    final updatedTargetCourse = targetCourse.copyWith(isBookmarked: newBookmarkState);
    if (newBookmarkState) {
      await saveMyCourse(updatedTargetCourse);
    } else {
      await deleteMyCourse(contentId);
    }
  }
}

/// TourCourseController 프로바이더
final tourCourseControllerProvider =
    StateNotifierProvider<TourCourseController, TourCourseState>((ref) {
  final dataSource = ref.watch(tourAPIDataSourceProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return TourCourseController(dataSource, prefs);
});

/// SharedPreferences 프로바이더
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
});