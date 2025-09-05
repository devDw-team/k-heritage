import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../core/utils/logger.dart';
import '../domain/entities/tour_course.dart';

class CourseCacheController {
  static const String _courseKey = 'course_cache_courses';
  static const String _timestampKey = 'course_cache_timestamp';
  static const Duration _cacheValidity = Duration(hours: 24);
  static const int _maxCachedCourses = 10;

  SharedPreferences? _prefs;

  CourseCacheController() {
    _init();
  }

  Future<void> _init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      Log.e('Failed to initialize course cache', error: e);
    }
  }

  /// 캐시 유효성 검사
  bool isCacheValid() {
    try {
      if (_prefs == null) return false;
      final timestamp = _prefs!.getString(_timestampKey);
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
      if (_prefs == null) return;
      
      // 최근 조회한 코스만 캐싱 (LRU)
      final limitedCourses = courses.take(_maxCachedCourses).toList();
      
      final jsonData = limitedCourses.map((course) {
        return course.toJson();
      }).toList();

      await _prefs!.setString(_courseKey, json.encode(jsonData));
      await _prefs!.setString(_timestampKey, DateTime.now().toIso8601String());
      
      Log.i('Cached ${limitedCourses.length} courses');
    } catch (e) {
      Log.e('Failed to cache courses', error: e);
    }
  }

  /// 캐시된 코스 로드
  Future<List<TourCourse>?> getCachedCourses() async {
    try {
      if (_prefs == null) return null;
      if (!isCacheValid()) {
        Log.d('Cache is invalid or expired');
        return null;
      }

      final cachedJson = _prefs!.getString(_courseKey);
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
      if (_prefs == null) return;
      final key = 'course_${course.contentid}';
      await _prefs!.setString(key, json.encode(course.toJson()));
      await _prefs!.setString('${key}_timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      Log.e('Failed to cache course', error: e);
    }
  }

  /// 단일 코스 로드
  Future<TourCourse?> getCachedCourse(String contentId) async {
    try {
      if (_prefs == null) return null;
      final key = 'course_$contentId';
      final timestampKey = '${key}_timestamp';

      // 캐시 유효성 검사
      final timestamp = _prefs!.getString(timestampKey);
      if (timestamp != null) {
        final cachedTime = DateTime.parse(timestamp);
        if (DateTime.now().difference(cachedTime) > _cacheValidity) {
          return null;
        }
      }

      final cachedJson = _prefs!.getString(key);
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
      if (_prefs == null) return;
      final keys = _prefs!.getKeys().where((key) => 
        key.startsWith('course_') || 
        key == _courseKey || 
        key == _timestampKey
      ).toList();
      
      for (final key in keys) {
        await _prefs!.remove(key);
      }
      Log.i('Course cache cleared');
    } catch (e) {
      Log.e('Failed to clear course cache', error: e);
    }
  }

  /// 캐시 크기 확인
  int getCacheSize() {
    if (_prefs == null) return 0;
    return _prefs!.getKeys().where((key) => 
      key.startsWith('course_') || 
      key == _courseKey || 
      key == _timestampKey
    ).length;
  }

  /// 오래된 캐시 정리
  Future<void> cleanupOldCache() async {
    try {
      if (_prefs == null) return;
      final keys = _prefs!.getKeys().where((key) => key.contains('_timestamp'));
      final now = DateTime.now();
      final keysToDelete = <String>[];

      for (final key in keys) {
        final timestamp = _prefs!.getString(key);
        if (timestamp != null) {
          final cachedTime = DateTime.parse(timestamp);
          if (now.difference(cachedTime) > _cacheValidity) {
            final courseKey = key.replaceAll('_timestamp', '');
            keysToDelete.add(courseKey);
            keysToDelete.add(key);
          }
        }
      }

      if (keysToDelete.isNotEmpty) {
        for (final key in keysToDelete) {
          await _prefs!.remove(key);
        }
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