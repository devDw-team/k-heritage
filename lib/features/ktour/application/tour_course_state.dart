import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/entities/tour_course.dart';

part 'tour_course_state.freezed.dart';

@freezed
class TourCourseState with _$TourCourseState {
  const factory TourCourseState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default([]) List<TourCourse> courses,
    @Default([]) List<TourCourse> filteredCourses,
    @Default([]) List<TourCourse> recommendedCourses,
    @Default([]) List<TourCourse> myCourses,
    TourCourse? selectedCourse,
    String? error,
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
    
    // 필터 상태
    String? selectedAreaCode,
    String? selectedSigunguCode,
    String? selectedTheme,
    String? selectedDifficulty,
    int? minDuration,
    int? maxDuration,
    
    // 정렬 옵션
    @Default('P') String sortBy, // P: 인기순, R: 최신순, Q: 수정일순
  }) = _TourCourseState;
}