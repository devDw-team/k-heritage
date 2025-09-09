import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/entities/heritage.dart';
import '../domain/repositories/heritage_repository.dart';
import 'heritage_controller.dart';
import '../infrastructure/data/theme_data.dart';

part 'theme_controller.freezed.dart';

/// 테마 컨트롤러 Provider
final themeControllerProvider = 
    StateNotifierProvider<ThemeController, ThemeState>((ref) {
  final repository = ref.watch(heritageRepositoryProvider);
  return ThemeController(repository, ref);
});

/// 테마 상태
@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    @Default([]) List<Theme> themes,
    Theme? selectedTheme,
    @Default([]) List<Heritage> themeHeritages,
    @Default({}) Map<String, int> themeCounts,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingHeritages,
    String? error,
    @Default('ko') String language,
  }) = _ThemeState;
}

/// 테마 컨트롤러
class ThemeController extends StateNotifier<ThemeState> {
  final HeritageRepository _repository;
  final Ref _ref;
  
  ThemeController(this._repository, this._ref) : super(const ThemeState()) {
    loadThemes();
  }
  
  /// 모든 테마 로드
  Future<void> loadThemes() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // 테마 목록 가져오기
      final themes = await _repository.getAllThemes();
      
      // 테마별 카운트 가져오기
      final themeCounts = await _repository.getThemeCounts();
      
      state = state.copyWith(
        themes: themes,
        themeCounts: themeCounts,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load themes: $e',
      );
    }
  }
  
  /// 테마 선택 및 문화재 로드
  Future<void> selectTheme(String themeCode) async {
    state = state.copyWith(isLoadingHeritages: true, error: null);
    
    try {
      // 테마별 문화재 가져오기
      final heritages = await _repository.getHeritagesByTheme(
        themeCode,
        lang: state.language,
      );
      
      // 테마 정보 찾기 또는 생성
      Theme? theme;
      try {
        theme = state.themes.firstWhere((t) => t.code == themeCode);
      } catch (e) {
        // 테마가 없으면 생성
        final themeInfo = ThemeData.themeMapping.values
            .firstWhere((info) => info['code'] == themeCode);
        theme = Theme(
          id: themeCode, // ID로 코드 사용
          code: themeCode,
          nameKo: themeInfo['title'] as String,
          nameEn: themeInfo['title'] as String, // 영어 이름은 나중에 추가 가능
          icon: themeInfo['icon'] as String,
          heritageCount: heritages.length, // 실제 문화재 개수 사용
        );
      }
      
      // 실제 개수로 테마 업데이트
      if (theme.heritageCount != heritages.length) {
        theme = theme.copyWith(heritageCount: heritages.length);
        
        // 테마 리스트에서도 업데이트
        final updatedThemes = state.themes.map((t) {
          return t.code == themeCode ? theme! : t;
        }).toList();
        
        state = state.copyWith(themes: updatedThemes);
      }
      
      state = state.copyWith(
        selectedTheme: theme,
        themeHeritages: heritages,
        isLoadingHeritages: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingHeritages: false,
        error: 'Failed to load theme heritages: $e',
      );
    }
  }
  
  /// 테마 선택 해제
  void clearSelectedTheme() {
    state = state.copyWith(
      selectedTheme: null,
      themeHeritages: [],
    );
  }
  
  /// 테마별 카운트 업데이트
  Future<void> updateThemeCounts() async {
    try {
      final themeCounts = await _repository.getThemeCounts();
      state = state.copyWith(themeCounts: themeCounts);
    } catch (e) {
      // 카운트 업데이트 실패는 무시 (핵심 기능 아님)
    }
  }
  
  /// 언어 변경
  void changeLanguage(String lang) {
    state = state.copyWith(language: lang);
    
    // 선택된 테마가 있으면 해당 테마의 문화재 다시 로드
    if (state.selectedTheme != null) {
      selectTheme(state.selectedTheme!.code);
    }
  }
  
  /// 테마 색상 가져오기
  int getThemeColor(String themeKey) {
    return ThemeData.getThemeColor(themeKey);
  }
  
  /// 테마 정보 가져오기
  Map<String, dynamic>? getThemeInfo(String themeKey) {
    return ThemeData.themeMapping[themeKey];
  }
  
  /// 추천 테마 가져오기 (가장 많은 문화재를 가진 테마)
  Theme? getRecommendedTheme() {
    if (state.themes.isEmpty) return null;
    
    Theme? recommendedTheme;
    int maxCount = 0;
    
    for (final theme in state.themes) {
      if (theme.heritageCount > maxCount) {
        maxCount = theme.heritageCount;
        recommendedTheme = theme;
      }
    }
    
    return recommendedTheme;
  }
  
  /// 새로고침
  Future<void> refresh() async {
    await loadThemes();
    
    // 선택된 테마가 있으면 해당 테마의 문화재도 다시 로드
    if (state.selectedTheme != null) {
      await selectTheme(state.selectedTheme!.code);
    }
  }
}