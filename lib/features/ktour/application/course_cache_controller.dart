import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import '../../../core/utils/logger.dart';
import '../domain/entities/tour_course.dart';

class CourseCacheController {
  static const String _boxName = 'course_cache';
  static const String _courseKey = 'courses';
  static const String _timestampKey = 'timestamp';
  static const Duration _cacheValidity = Duration(hours: 24);
  static const int _maxCachedCourses = 10;

  late Box _box;

  CourseCacheController() {
    _init();
  }

  Future<void> _init() async {
    try {
      _box = await Hive.openBox(_boxName);
    } catch (e) {
      Log.e('Failed to initialize course cache', error: e);
    }
  }

  /// 캐시 유효성 검사
  bool isCacheValid() {
    try {
      final timestamp = _box.get(_timestampKey);
      if (timestamp == null) return false;

      final cachedTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      return now.difference(cachedTime) < _cacheValidity;
    } catch (e) {
      Log.e('Failed to check cache validity', error: e);
      return false;
    }
  }

  /// 코스 캐싱
  Future<void> cacheCourses(List<TourCourse> courses) async {
    try {
      // 최근 조회한 코스만 캐싱 (LRU)
      final limitedCourses = courses.take(_maxCachedCourses).toList();
      
      final jsonData = limitedCourses.map((course) {
        return course.toJson();
      }).toList();

      await _box.put(_courseKey, json.encode(jsonData));
      await _box.put(_timestampKey, DateTime.now().toIso8601String());
      
      Log.i('Cached ${limitedCourses.length} courses');
    } catch (e) {
      Log.e('Failed to cache courses', error: e);
    }
  }

  /// 캐시된 코스 로드
  Future<List<TourCourse>?> getCachedCourses() async {
    try {
      if (!isCacheValid()) {
        Log.d('Cache is invalid or expired');
        return null;
      }

      final cachedJson = _box.get(_courseKey);
      if (cachedJson == null) return null;

      final List<dynamic> jsonData = json.decode(cachedJson);
      final courses = jsonData.map((item) {
        return TourCourse.fromJson(item as Map<String, dynamic>);
      }).toList();

      Log.i('Loaded ${courses.length} cached courses');
      return courses;
    } catch (e) {
      Log.e('Failed to load cached courses', error: e);
      return null;
    }
  }

  /// 단일 코스 캐싱
  Future<void> cacheCourse(TourCourse course) async {
    try {
      final key = 'course_${course.contentid}';
      await _box.put(key, json.encode(course.toJson()));
      await _box.put('${key}_timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      Log.e('Failed to cache course', error: e);
    }
  }

  /// 단일 코스 로드
  Future<TourCourse?> getCachedCourse(String contentId) async {
    try {
      final key = 'course_$contentId';
      final timestampKey = '${key}_timestamp';

      // 캐시 유효성 검사
      final timestamp = _box.get(timestampKey);
      if (timestamp != null) {
        final cachedTime = DateTime.parse(timestamp);
        if (DateTime.now().difference(cachedTime) > _cacheValidity) {
          return null;
        }
      }

      final cachedJson = _box.get(key);
      if (cachedJson == null) return null;

      return TourCourse.fromJson(json.decode(cachedJson));
    } catch (e) {
      Log.e('Failed to load cached course', error: e);
      return null;
    }
  }

  /// 캐시 초기화
  Future<void> clearCache() async {
    try {
      await _box.clear();
      Log.i('Course cache cleared');
    } catch (e) {
      Log.e('Failed to clear course cache', error: e);
    }
  }

  /// 캐시 크기 확인
  int getCacheSize() {
    return _box.length;
  }

  /// 오래된 캐시 정리
  Future<void> cleanupOldCache() async {
    try {
      final keys = _box.keys.where((key) => key.toString().contains('_timestamp'));
      final now = DateTime.now();
      final keysToDelete = <String>[];

      for (final key in keys) {
        final timestamp = _box.get(key);
        if (timestamp != null) {
          final cachedTime = DateTime.parse(timestamp);
          if (now.difference(cachedTime) > _cacheValidity) {
            final courseKey = key.toString().replaceAll('_timestamp', '');
            keysToDelete.add(courseKey);
            keysToDelete.add(key.toString());
          }
        }
      }

      if (keysToDelete.isNotEmpty) {
        await _box.deleteAll(keysToDelete);
        Log.i('Cleaned up ${keysToDelete.length ~/ 2} old cached courses');
      }
    } catch (e) {
      Log.e('Failed to cleanup old cache', error: e);
    }
  }
}

/// CourseCacheController 프로바이더
final courseCacheControllerProvider = Provider<CourseCacheController>((ref) {
  return CourseCacheController();
});