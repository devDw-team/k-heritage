import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _loadingController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _navigateToHome();
  }

  void _initAnimations() {
    // 페이드 인 애니메이션
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // 스케일 애니메이션
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // 로딩 인디케이터 애니메이션
    _loadingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_loadingController);

    // 애니메이션 시작
    _fadeController.forward();
    _scaleController.forward();
  }

  Future<void> _navigateToHome() async {
    // 최소 표시 시간
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      // 홈 화면으로 이동
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _loadingController.dispose();
    super.dispose();
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
              AppColors.hanjiBeige,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // 한지 질감 패턴 (선택사항)
            _buildTextureOverlay(),
            
            // 메인 콘텐츠
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 앱 아이콘
                      _buildAppIcon(),
                      const SizedBox(height: 48),
                      
                      // 앱 타이틀
                      _buildAppTitle(),
                      const SizedBox(height: 80),
                      
                      // 로딩 인디케이터
                      _buildLoadingIndicator(),
                      const SizedBox(height: 24),
                      
                      // 로딩 텍스트
                      _buildLoadingText(),
                    ],
                  ),
                ),
              ),
            ),
            
            // 하단 장식
            _buildBottomDecoration(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextureOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.dancheongRed.withOpacity(0.02),
      ),
    );
  }

  Widget _buildAppIcon() {
    return SizedBox(
      width: 150,
      height: 150,
      child: SvgPicture.asset(
        'assets/icons/app_icon.svg',
        width: 150,
        height: 150,
      ),
    );
  }

  Widget _buildAppTitle() {
    return Column(
      children: [
        Text(
          '포켓 문화재 가이드',
          style: TextStyle(
            fontFamily: 'NotoSerifKR',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.inkBlack,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'K-HERITAGE EXPLORER',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.grayMedium,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return AnimatedBuilder(
      animation: _loadingAnimation,
      builder: (context, child) {
        return SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLoadingDot(0, AppColors.dancheongRed),
              const SizedBox(width: 12),
              _buildLoadingDot(0.33, AppColors.celadonGreen),
              const SizedBox(width: 12),
              _buildLoadingDot(0.66, AppColors.obangBlue),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingDot(double delay, Color color) {
    final value = (_loadingAnimation.value - delay) % 1.0;
    final opacity = value < 0 ? 0.3 : (value < 0.5 ? 0.3 + value * 1.4 : 1.7 - value * 1.4);
    
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color.withOpacity(opacity.clamp(0.3, 1.0)),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildLoadingText() {
    return Text(
      '문화재 정보를 불러오는 중...',
      style: TextStyle(
        fontFamily: 'NotoSansKR',
        fontSize: 14,
        color: AppColors.grayMedium,
      ),
    );
  }

  Widget _buildBottomDecoration() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.celadonGreen.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.dancheongRed.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.obangBlue.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}