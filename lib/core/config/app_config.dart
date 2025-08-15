import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/logger.dart';

/// Application configuration singleton class
/// Handles initialization of external services and environment variables
class AppConfig {
  AppConfig._();
  
  static final AppConfig _instance = AppConfig._();
  static AppConfig get instance => _instance;
  
  /// Supabase client instance
  late final SupabaseClient supabaseClient;
  
  /// App initialization status
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  
  /// Environment configuration
  String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
  bool get isDevelopment => environment == 'development';
  bool get isProduction => environment == 'production';
  bool get isStaging => environment == 'staging';
  
  /// API endpoints
  String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  String get googleMapsApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  String get googleTranslateApiKey => dotenv.env['GOOGLE_TRANSLATE_API_KEY'] ?? '';
  
  /// Feature flags
  bool get enableAnalytics => dotenv.env['ENABLE_ANALYTICS'] == 'true';
  bool get enableCrashlytics => dotenv.env['ENABLE_CRASHLYTICS'] == 'true';
  bool get enableDebugMode => dotenv.env['DEBUG_MODE'] == 'true' || !kReleaseMode;
  
  /// Cache configuration
  int get cacheExpiration => int.tryParse(dotenv.env['CACHE_EXPIRATION'] ?? '3600') ?? 3600;
  int get maxCacheSize => int.tryParse(dotenv.env['MAX_CACHE_SIZE'] ?? '100') ?? 100;
  
  /// Pagination configuration
  int get defaultPageSize => int.tryParse(dotenv.env['DEFAULT_PAGE_SIZE'] ?? '20') ?? 20;
  int get maxPageSize => int.tryParse(dotenv.env['MAX_PAGE_SIZE'] ?? '100') ?? 100;
  
  /// Initialize app configuration
  Future<void> initialize() async {
    if (_isInitialized) {
      Log.w('AppConfig already initialized');
      return;
    }
    
    try {
      Log.i('Initializing AppConfig...');
      
      // Load environment variables
      await _loadEnvironment();
      
      // Validate required configurations
      _validateConfiguration();
      
      // Initialize Supabase
      await _initializeSupabase();
      
      // Initialize other services if needed
      await _initializeServices();
      
      _isInitialized = true;
      Log.i('AppConfig initialized successfully');
    } catch (e, stackTrace) {
      Log.e('Failed to initialize AppConfig', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
  
  /// Load environment variables from .env file
  Future<void> _loadEnvironment() async {
    try {
      await dotenv.load(fileName: '.env');
      Log.d('Environment variables loaded');
      
      if (enableDebugMode) {
        Log.d('Running in ${environment.toUpperCase()} mode');
      }
    } catch (e) {
      Log.e('Failed to load .env file', error: e);
      // Continue with default values if .env file is not found
    }
  }
  
  /// Validate required configuration values
  void _validateConfiguration() {
    final List<String> missingConfigs = [];
    
    if (supabaseUrl.isEmpty) {
      missingConfigs.add('SUPABASE_URL');
    }
    
    if (supabaseAnonKey.isEmpty) {
      missingConfigs.add('SUPABASE_ANON_KEY');
    }
    
    if (googleMapsApiKey.isEmpty) {
      Log.w('GOOGLE_MAPS_API_KEY not configured - Maps features will be limited');
    }
    
    if (googleTranslateApiKey.isEmpty) {
      Log.w('GOOGLE_TRANSLATE_API_KEY not configured - Translation features will be disabled');
    }
    
    if (missingConfigs.isNotEmpty) {
      throw Exception('Missing required configurations: ${missingConfigs.join(', ')}');
    }
  }
  
  /// Initialize Supabase client
  Future<void> _initializeSupabase() async {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
        debug: enableDebugMode,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
      );
      
      supabaseClient = Supabase.instance.client;
      Log.i('Supabase initialized successfully');
      
      // Set up auth state listener
      supabaseClient.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;
        
        Log.d('Auth state changed: $event');
        
        switch (event) {
          case AuthChangeEvent.signedIn:
            Log.i('User signed in: ${session?.user.email}');
            break;
          case AuthChangeEvent.signedOut:
            Log.i('User signed out');
            break;
          case AuthChangeEvent.tokenRefreshed:
            Log.d('Token refreshed');
            break;
          case AuthChangeEvent.userUpdated:
            Log.d('User profile updated');
            break;
          default:
            Log.d('Auth event: $event');
        }
      });
    } catch (e, stackTrace) {
      Log.e('Failed to initialize Supabase', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
  
  /// Initialize additional services
  Future<void> _initializeServices() async {
    // Initialize analytics if enabled
    if (enableAnalytics && isProduction) {
      await _initializeAnalytics();
    }
    
    // Initialize crash reporting if enabled
    if (enableCrashlytics && isProduction) {
      await _initializeCrashlytics();
    }
  }
  
  /// Initialize analytics service
  Future<void> _initializeAnalytics() async {
    try {
      // TODO: Initialize your analytics service here
      // Example: await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
      Log.i('Analytics initialized');
    } catch (e) {
      Log.e('Failed to initialize analytics', error: e);
      // Don't throw - analytics failure shouldn't prevent app startup
    }
  }
  
  /// Initialize crash reporting service
  Future<void> _initializeCrashlytics() async {
    try {
      // TODO: Initialize your crash reporting service here
      // Example: await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      Log.i('Crashlytics initialized');
    } catch (e) {
      Log.e('Failed to initialize crashlytics', error: e);
      // Don't throw - crashlytics failure shouldn't prevent app startup
    }
  }
  
  /// Reset configuration (useful for testing)
  @visibleForTesting
  void reset() {
    _isInitialized = false;
    Log.d('AppConfig reset');
  }
  
  /// Get configuration as Map (useful for debugging)
  Map<String, dynamic> toMap() {
    return {
      'environment': environment,
      'isDevelopment': isDevelopment,
      'isProduction': isProduction,
      'isStaging': isStaging,
      'enableAnalytics': enableAnalytics,
      'enableCrashlytics': enableCrashlytics,
      'enableDebugMode': enableDebugMode,
      'cacheExpiration': cacheExpiration,
      'maxCacheSize': maxCacheSize,
      'defaultPageSize': defaultPageSize,
      'maxPageSize': maxPageSize,
      'hasSupabaseUrl': supabaseUrl.isNotEmpty,
      'hasSupabaseAnonKey': supabaseAnonKey.isNotEmpty,
      'hasGoogleMapsApiKey': googleMapsApiKey.isNotEmpty,
      'hasGoogleTranslateApiKey': googleTranslateApiKey.isNotEmpty,
    };
  }
}