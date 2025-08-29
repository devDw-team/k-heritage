// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TourCourseImpl _$$TourCourseImplFromJson(Map<String, dynamic> json) =>
    _$TourCourseImpl(
      contentid: json['contentid'] as String,
      contenttypeid: json['contenttypeid'] as String,
      title: json['title'] as String,
      firstimage: json['firstimage'] as String?,
      firstimage2: json['firstimage2'] as String?,
      addr1: json['addr1'] as String?,
      addr2: json['addr2'] as String?,
      areacode: json['areacode'] as String?,
      sigungucode: json['sigungucode'] as String?,
      cat1: json['cat1'] as String?,
      cat2: json['cat2'] as String?,
      cat3: json['cat3'] as String?,
      mapx: (json['mapx'] as num?)?.toDouble(),
      mapy: (json['mapy'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      tel: json['tel'] as String?,
      zipcode: json['zipcode'] as String?,
      totalDistance: (json['totalDistance'] as num?)?.toDouble(),
      totalDuration: (json['totalDuration'] as num?)?.toInt(),
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => CourseStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      theme: json['theme'] as String?,
      difficulty: json['difficulty'] as String?,
      createdtime: json['createdtime'] == null
          ? null
          : DateTime.parse(json['createdtime'] as String),
      modifiedtime: json['modifiedtime'] == null
          ? null
          : DateTime.parse(json['modifiedtime'] as String),
      readcount: (json['readcount'] as num?)?.toInt(),
      isBookmarked: json['isBookmarked'] as bool?,
    );

Map<String, dynamic> _$$TourCourseImplToJson(_$TourCourseImpl instance) =>
    <String, dynamic>{
      'contentid': instance.contentid,
      'contenttypeid': instance.contenttypeid,
      'title': instance.title,
      'firstimage': instance.firstimage,
      'firstimage2': instance.firstimage2,
      'addr1': instance.addr1,
      'addr2': instance.addr2,
      'areacode': instance.areacode,
      'sigungucode': instance.sigungucode,
      'cat1': instance.cat1,
      'cat2': instance.cat2,
      'cat3': instance.cat3,
      'mapx': instance.mapx,
      'mapy': instance.mapy,
      'overview': instance.overview,
      'tel': instance.tel,
      'zipcode': instance.zipcode,
      'totalDistance': instance.totalDistance,
      'totalDuration': instance.totalDuration,
      'steps': instance.steps,
      'theme': instance.theme,
      'difficulty': instance.difficulty,
      'createdtime': instance.createdtime?.toIso8601String(),
      'modifiedtime': instance.modifiedtime?.toIso8601String(),
      'readcount': instance.readcount,
      'isBookmarked': instance.isBookmarked,
    };
