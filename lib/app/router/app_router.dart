import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/common/widgets/main_scaffold.dart';
import '../../features/heritage/presentation/screens/detail_screen.dart';
import '../../features/heritage/presentation/screens/home_screen.dart';
import '../../features/heritage/presentation/screens/theme_screen.dart';
import '../../features/heritage/presentation/screens/theme_heritage_list_screen.dart';
import '../../features/bookmarks/presentation/screens/bookmarks_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/ktour/presentation/screens/ktour_home_screen.dart';
import '../../features/ktour/presentation/screens/tour_explore_screen.dart';
import '../../features/ktour/presentation/screens/tour_detail_screen.dart';
import '../../features/ktour/presentation/screens/tour_course_screen.dart';
import '../../features/ktour/presentation/screens/course_detail_screen.dart';
import '../../features/ktour/presentation/screens/festival_list_screen.dart';
import '../../features/ktour/presentation/screens/festival_detail_screen.dart';
import '../../features/ktour/presentation/screens/festival_calendar_screen.dart';
import '../../features/ktour/presentation/screens/travel_info_screen.dart';
import '../../features/onboarding/presentation/screens/language_selection_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

/// 라우트 이름 상수
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String languageSelection = '/language-selection';
  static const String home = '/home';
  static const String themes = '/themes';
  static const String themeDetail = '/theme/:code';
  static const String ktour = '/ktour';
  static const String ktourExplore = '/ktour/explore';
  static const String ktourDetail = '/ktour/detail/:contentId';
  static const String ktourCourse = '/ktour/course';
  static const String courseDetail = '/ktour/course/:id';
  static const String myCourse = '/ktour/my-course';
  static const String courseCreate = '/ktour/course/create';
  static const String ktourFestival = '/ktour/festival';
  static const String festivalDetail = '/ktour/festival/:id';
  static const String ktourTravelInfo = '/ktour/travel-info';
  static const String bookmarks = '/bookmarks';
  static const String settings = '/settings';
  static const String heritageDetail = '/heritage/:id';
}

/// 라우터 프로바이더
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // 스플래시 화면
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // 언어 선택 화면 (온보딩)
      GoRoute(
        path: AppRoutes.languageSelection,
        name: 'languageSelection',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      
      // 메인 셸 라우트 (하단 네비게이션 포함)
      ShellRoute(
        builder: (context, state, child) {
          // 현재 라우트에서 탭 인덱스 계산
          final currentRoute = state.matchedLocation;
          int selectedIndex = 0;
          
          if (currentRoute.startsWith('/themes')) {
            selectedIndex = 1;
          } else if (currentRoute.startsWith('/ktour')) {
            selectedIndex = 2;
          } else if (currentRoute.startsWith('/bookmarks')) {
            selectedIndex = 3;
          } else if (currentRoute.startsWith('/settings')) {
            selectedIndex = 4;
          }
          
          return MainScaffold(
            currentIndex: selectedIndex,
            child: child,
          );
        },
        routes: [
          // 홈 화면
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          
          // 테마 화면
          GoRoute(
            path: AppRoutes.themes,
            name: 'themes',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ThemeScreen(),
            ),
          ),
          
          // K-TOUR 화면
          GoRoute(
            path: AppRoutes.ktour,
            name: 'ktour',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KTourHomeScreen(),
            ),
            routes: [
              // 여행지 탐색 화면
              GoRoute(
                path: 'explore',
                name: 'ktourExplore',
                builder: (context, state) => const TourExploreScreen(),
              ),
              // 여행코스 화면
              GoRoute(
                path: 'course',
                name: 'ktourCourse',
                builder: (context, state) => const TourCourseScreen(),
              ),
              // 나만의 코스 화면
              GoRoute(
                path: 'my-course',
                name: 'myCourse',
                builder: (context, state) => const TourCourseScreen(), // 탭 인덱스로 구분
              ),
              // 여행정보 화면
              GoRoute(
                path: 'travel-info',
                name: 'ktourTravelInfo',
                builder: (context, state) => const TravelInfoScreen(),
              ),
              // 행사/축제 화면
              GoRoute(
                path: 'festival',
                name: 'ktourFestival',
                builder: (context, state) => const FestivalListScreen(),
                routes: [
                  // 축제 캘린더 화면 (특정 경로를 먼저 매칭)
                  GoRoute(
                    path: 'calendar',
                    name: 'festivalCalendar',
                    builder: (context, state) => const FestivalCalendarScreen(),
                  ),
                  // 축제 상세 화면 (동적 경로는 나중에 매칭)
                  GoRoute(
                    path: ':id',
                    name: 'festivalDetail',
                    builder: (context, state) {
                      final contentId = state.pathParameters['id'] ?? '';
                      return FestivalDetailScreen(contentId: contentId);
                    },
                    routes: [
                      // 축제 지도 화면
                      GoRoute(
                        path: 'map',
                        name: 'festivalMap',
                        builder: (context, state) {
                          // 부모 라우트에서 contentId 가져오기
                          final contentId = state.pathParameters['id'] ?? '';
                          // 실제 구현 시 festival 데이터를 가져와야 함
                          // 여기서는 라우터 구조만 설정
                          return Container(); // FestivalMapScreen으로 교체 필요
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          // 북마크 화면
          GoRoute(
            path: AppRoutes.bookmarks,
            name: 'bookmarks',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookmarksScreen(),
            ),
          ),
          
          // 설정 화면
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
      
      // 테마별 문화재 목록 화면 (전체 화면)
      GoRoute(
        path: AppRoutes.themeDetail,
        name: 'themeDetail',
        builder: (context, state) {
          final themeCode = state.pathParameters['code'] ?? '';
          return ThemeHeritageListScreen(themeCode: themeCode);
        },
      ),
      
      // 문화재 상세 화면 (전체 화면)
      GoRoute(
        path: AppRoutes.heritageDetail,
        name: 'heritageDetail',
        builder: (context, state) {
          final heritageId = state.pathParameters['id'] ?? '';
          return HeritageDetailScreen(heritageId: heritageId);
        },
      ),
      
      // 관광지 상세 화면 (전체 화면)
      GoRoute(
        path: AppRoutes.ktourDetail,
        name: 'ktourDetail',
        builder: (context, state) {
          final contentId = state.pathParameters['contentId'] ?? '';
          final contentTypeIdStr = state.uri.queryParameters['contentTypeId'];
          
          // contentTypeId 파싱 및 검증
          int? contentTypeId;
          if (contentTypeIdStr != null) {
            final parsed = int.tryParse(contentTypeIdStr);
            // 0보다 큰 유효한 값만 사용
            if (parsed != null && parsed > 0) {
              contentTypeId = parsed;
            }
          }
          
          return TourDetailScreen(
            contentId: contentId,
            contentTypeId: contentTypeId,
          );
        },
      ),
      
      // 코스 상세 화면 (전체 화면)
      GoRoute(
        path: AppRoutes.courseDetail,
        name: 'courseDetail',
        builder: (context, state) {
          final contentId = state.pathParameters['id'] ?? '';
          return CourseDetailScreen(contentId: contentId);
        },
      ),
      
      // 코스 생성 화면 (전체 화면)
      GoRoute(
        path: AppRoutes.courseCreate,
        name: 'courseCreate',
        builder: (context, state) {
          // TODO: 코스 생성 화면 구현
          return const Scaffold(
            body: Center(
              child: Text('코스 생성 화면 - 개발 중'),
            ),
          );
        },
      ),
    ],
    
    // 에러 페이지
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              '페이지를 찾을 수 없습니다',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.error?.toString() ?? '잘못된 경로입니다',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('홈으로 돌아가기'),
            ),
          ],
        ),
      ),
    ),
    
    // 리다이렉트 로직 (첫 실행 시 언어 선택 화면으로)
    redirect: (context, state) async {
      // TODO: SharedPreferences로 첫 실행 여부 확인
      // 첫 실행이면 언어 선택 화면으로 리다이렉트
      // final prefs = await SharedPreferences.getInstance();
      // final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
      // final currentPath = state.matchedLocation;
      
      // if (isFirstLaunch && currentPath != AppRoutes.languageSelection) {
      //   return AppRoutes.languageSelection;
      // }
      
      return null;
    },
  );
});

/// 네비게이션 헬퍼 확장
extension NavigationHelper on BuildContext {
  /// 홈으로 이동
  void goHome() => go(AppRoutes.home);
  
  /// 테마 화면으로 이동
  void goThemes() => go(AppRoutes.themes);
  
  /// K-TOUR 화면으로 이동
  void goKTour() => go(AppRoutes.ktour);
  
  /// 북마크 화면으로 이동
  void goBookmarks() => go(AppRoutes.bookmarks);
  
  /// 설정 화면으로 이동
  void goSettings() => go(AppRoutes.settings);
  
  /// 문화재 상세 화면으로 이동
  void goHeritageDetail(String id) => push('/heritage/$id');
  
  /// 관광지 상세 화면으로 이동
  void goTourDetail(String contentId, {int? contentTypeId}) {
    final queryParams = contentTypeId != null ? '?contentTypeId=$contentTypeId' : '';
    push('/ktour/detail/$contentId$queryParams');
  }
  
  /// 언어 선택 화면으로 이동
  void goLanguageSelection() => go(AppRoutes.languageSelection);
}