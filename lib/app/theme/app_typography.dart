import 'package:flutter/material.dart';

/// 앱 타이포그래피 정의
class AppTypography {
  AppTypography._();

  // 폰트 패밀리
  static const String fontFamilySans = 'NotoSansKR';
  static const String fontFamilySerif = 'NotoSerifKR';
  static const String fontFamilyInter = 'Inter';

  // Headline Styles - Serif 폰트 사용
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle h6 = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // Body Styles - Sans 폰트 사용
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // Button Styles
  static const TextStyle button = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // Caption Styles
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.4,
  );

  // Overline Styles
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 1.5,
  );

  // Number Styles - Inter 폰트 사용
  static const TextStyle numberLarge = TextStyle(
    fontFamily: fontFamilyInter,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const TextStyle numberMedium = TextStyle(
    fontFamily: fontFamilyInter,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static const TextStyle numberSmall = TextStyle(
    fontFamily: fontFamilyInter,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );
}