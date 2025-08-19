import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';

/// 언어 선택 화면 (온보딩)
class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends ConsumerState<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedLanguage;
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;

  final List<LanguageOption> _languages = [
    LanguageOption(
      code: 'ko',
      name: '한국어',
      flag: '🇰🇷',
      description: '한국의 소중한 문화유산을 만나보세요',
      gradientColor: AppColors.dancheongRed,
    ),
    LanguageOption(
      code: 'en',
      name: 'English',
      flag: '🇬🇧',
      description: "Discover Korea's precious cultural heritage",
      gradientColor: AppColors.obangBlue,
    ),
    LanguageOption(
      code: 'zh',
      name: '中文',
      flag: '🇨🇳',
      description: '探索韩国珍贵的文化遗产',
      gradientColor: AppColors.celadonGreen,
    ),
    LanguageOption(
      code: 'ja',
      name: '日本語',
      flag: '🇯🇵',
      description: '韓国の貴重な文化遺産を発見',
      gradientColor: const Color(0xFFE91E63),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _cardAnimations = List.generate(
      _languages.length,
      (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            0.4 + index * 0.1,
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectLanguage(String code) {
    setState(() {
      _selectedLanguage = code;
    });
  }

  void _onStartPressed() {
    if (_selectedLanguage != null) {
      // TODO: Save language preference
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.hanjiBeige,
              AppColors.baekjaWhite,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // 로고 및 타이틀
              _buildHeader(),
              const SizedBox(height: 40),
              // 언어 선택 카드들
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _cardAnimations[index],
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            20 * (1 - _cardAnimations[index].value),
                          ),
                          child: Opacity(
                            opacity: _cardAnimations[index].value,
                            child: _buildLanguageCard(_languages[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // 시작 버튼
              _buildStartButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // 전통 문양 장식
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.dancheongRed,
              width: 3,
            ),
            shape: BoxShape.circle,
          ),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.celadonGreen,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.obangBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.temple_buddhist,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '포켓 문화재 가이드',
          style: AppTypography.h2.copyWith(
            color: AppColors.inkBlack,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'K-Heritage Explorer',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.grayMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageCard(LanguageOption language) {
    final isSelected = _selectedLanguage == language.code;

    return GestureDetector(
      onTap: () => _selectLanguage(language.code),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected ? AppTheme.shadowMd : AppTheme.shadowSm,
        ),
        child: Stack(
          children: [
            // 배경 그라데이션
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      language.gradientColor.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // 카드 내용
            Row(
              children: [
                // 국기
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.hanjiBeige,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Center(
                    child: Text(
                      language.flag,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // 텍스트
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language.name,
                        style: AppTypography.h6.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        language.description,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.grayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                // 화살표
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isSelected ? AppColors.primary : AppColors.grayLight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    final isEnabled = _selectedLanguage != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isEnabled ? _onStartPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isEnabled ? AppColors.primary : AppColors.grayLight,
          ),
          child: Text(
            _getStartButtonText(),
            style: AppTypography.button.copyWith(
              color: isEnabled ? AppColors.onPrimary : AppColors.grayMedium,
            ),
          ),
        ),
      ),
    );
  }

  String _getStartButtonText() {
    if (_selectedLanguage == null) {
      return '언어를 선택해주세요';
    }

    switch (_selectedLanguage) {
      case 'en':
        return 'Get Started';
      case 'zh':
        return '开始使用';
      case 'ja':
        return 'はじめる';
      default:
        return '시작하기';
    }
  }
}

/// 언어 옵션 모델
class LanguageOption {
  final String code;
  final String name;
  final String flag;
  final String description;
  final Color gradientColor;

  const LanguageOption({
    required this.code,
    required this.name,
    required this.flag,
    required this.description,
    required this.gradientColor,
  });
}