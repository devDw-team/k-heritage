import 'package:freezed_annotation/freezed_annotation.dart';
import 'course_step.dart';

part 'tour_course.freezed.dart';
part 'tour_course.g.dart';

@freezed
class TourCourse with _$TourCourse {
  const factory TourCourse({
    required String contentid,
    required String contenttypeid,
    required String title,
    String? firstimage,
    String? firstimage2,
    String? addr1,
    String? addr2,
    String? areacode,
    String? sigungucode,
    String? cat1,
    String? cat2,
    String? cat3,
    double? mapx,
    double? mapy,
    String? overview,
    String? tel,
    String? zipcode,
    double? totalDistance,
    int? totalDuration,
    List<CourseStep>? steps,
    String? theme,
    String? difficulty,
    DateTime? createdtime,
    DateTime? modifiedtime,
    int? readcount,
    bool? isBookmarked,
  }) = _TourCourse;

  factory TourCourse.fromJson(Map<String, dynamic> json) =>
      _$TourCourseFromJson(json);
}