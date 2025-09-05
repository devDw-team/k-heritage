import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/config/app_config.dart';
import 'core/utils/logger.dart';
import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';
import 'features/ktour/application/tour_course_controller.dart';

void main() async {
  // Initialize Flutter binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // Preserve native splash screen until app is ready
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // Set preferred orientations (optional)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize app configuration and services
  final sharedPreferences = await _initializeApp();
  
  // Run app with Riverpod
  runApp(
    ProviderScope(
      overrides: [
        // Override SharedPreferences provider
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const KHeritageExplorerApp(),
    ),
  );
}

/// Initialize app configuration and services
Future<SharedPreferences> _initializeApp() async {
  try {
    Log.i('Starting app initialization...');
    
    // Initialize date formatting for Korean locale
    await initializeDateFormatting('ko_KR', null);
    Log.d('Date formatting initialized for Korean locale');
    
    // Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    Log.d('SharedPreferences initialized');
    
    // Initialize app configuration (includes Supabase and dotenv)
    await AppConfig.instance.initialize();
    
    // Log successful initialization
    Log.i('App initialization completed successfully');
    Log.d('Configuration: ${AppConfig.instance.toMap()}');
    
    // Remove native splash screen (Flutter 커스텀 스플래시가 표시됨)
    FlutterNativeSplash.remove();
    
    return prefs;
  } catch (e, stackTrace) {
    Log.f('Failed to initialize app', error: e, stackTrace: stackTrace);
    
    // Remove splash screen even on error
    FlutterNativeSplash.remove();
    
    // In production, you might want to show an error screen
    // For now, we'll rethrow to see the error during development
    rethrow;
  }
}

/// Main application widget
class KHeritageExplorerApp extends ConsumerWidget {
  const KHeritageExplorerApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'K-Heritage Explorer',
      debugShowCheckedModeBanner: AppConfig.instance.isDevelopment,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}