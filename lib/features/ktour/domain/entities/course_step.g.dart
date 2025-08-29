// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseStepImpl _$$CourseStepImplFromJson(Map<String, dynamic> json) =>
    _$CourseStepImpl(
      subcontentid: json['subcontentid'] as String,
      subname: json['subname'] as String,
      subdetailimg: json['subdetailimg'] as String?,
      subdetailoverview: json['subdetailoverview'] as String?,
      subnum: (json['subnum'] as num?)?.toInt(),
      distance: (json['distance'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$CourseStepImplToJson(_$CourseStepImpl instance) =>
    <String, dynamic>{
      'subcontentid': instance.subcontentid,
      'subname': instance.subname,
      'subdetailimg': instance.subdetailimg,
      'subdetailoverview': instance.subdetailoverview,
      'subnum': instance.subnum,
      'distance': instance.distance,
      'duration': instance.duration,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
