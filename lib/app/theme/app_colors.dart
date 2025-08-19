import 'package:flutter/material.dart';

/// 한국 전통색을 활용한 앱 색상 팔레트
class AppColors {
  AppColors._();

  // 주요 색상 - 한국 전통색
  static const Color dancheongRed = Color(0xFFD03A29); // 단청 적색
  static const Color celadonGreen = Color(0xFF7BA098); // 청자 녹색
  static const Color obangBlue = Color(0xFF2B4C8C); // 오방색 청색
  static const Color hanjiBeige = Color(0xFFF5E6D3); // 한지 베이지
  static const Color inkBlack = Color(0xFF1A1A1A); // 먹색
  static const Color baekjaWhite = Color(0xFFFAFAFA); // 백자 흰색

  // 그레이 스케일
  static const Color grayLight = Color(0xFFE5E5E5);
  static const Color grayMedium = Color(0xFF999999);
  static const Color grayDark = Color(0xFF666666);

  // 의미론적 색상
  static const Color primary = dancheongRed;
  static const Color secondary = celadonGreen;
  static const Color accent = obangBlue;
  static const Color background = hanjiBeige;
  static const Color surface = baekjaWhite;
  static const Color onPrimary = baekjaWhite;
  static const Color onSecondary = baekjaWhite;
  static const Color onBackground = inkBlack;
  static const Color onSurface = inkBlack;

  // 상태 색상
  static const Color success = celadonGreen;
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE91E63);
  static const Color info = obangBlue;

  // 카테고리별 색상
  static const Color nationalTreasure = dancheongRed; // 국보
  static const Color treasure = obangBlue; // 보물
  static const Color historicSite = celadonGreen; // 사적
  static const Color scenicSite = Color(0xFF7B68EE); // 명승
  static const Color intangibleHeritage = Color(0xFFFF6B6B); // 무형문화재

  // 그라데이션
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [dancheongRed, Color(0xFFB53325)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [hanjiBeige, baekjaWhite],
  );

  static const LinearGradient mapGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [celadonGreen, obangBlue],
  );
}