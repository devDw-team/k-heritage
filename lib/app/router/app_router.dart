import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/common/widgets/main_scaffold.dart';
import '../../features/heritage/presentation/screens/detail_screen.dart';
import '../../features/heritage/presentation/screens/home_screen.dart';
import '../../features/heritage/presentation/screens/theme_screen.dart';
import '../../features/bookmarks/presentation/screens/bookmarks_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/ktour/presentation/screens/ktour_home_screen.dart';
import '../../features/onboarding/presentation/screens/language_selection_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

/// 라우트 이름 상수
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String languageSelection = '/language-selection';
  static const String home = '/home';
  static const String themes = '/themes';
  static const String ktour = '/ktour';
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
      
      // 문화재 상세 화면 (전체 화면)
      GoRoute(
        path: AppRoutes.heritageDetail,
        name: 'heritageDetail',
        builder: (context, state) {
          final heritageId = state.pathParameters['id'] ?? '';
          return HeritageDetailScreen(heritageId: heritageId);
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
  
  /// 언어 선택 화면으로 이동
  void goLanguageSelection() => go(AppRoutes.languageSelection);
}