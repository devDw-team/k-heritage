import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_step.freezed.dart';
part 'course_step.g.dart';

@freezed
class CourseStep with _$CourseStep {
  const factory CourseStep({
    required String subcontentid,
    required String subname,
    String? subdetailimg,
    String? subdetailoverview,
    int? subnum,
    double? distance,
    int? duration,
    double? latitude,
    double? longitude,
    String? address,
  }) = _CourseStep;

  factory CourseStep.fromJson(Map<String, dynamic> json) =>
      _$CourseStepFromJson(json);
}