# 스플래시 화면 설정 가이드

## 🎨 스플래시 화면 디자인 컨셉

한국 전통 미학과 현대적 디자인을 조화롭게 표현한 스플래시 화면으로:
- **한지 질감 배경**: 따뜻하고 부드러운 그라데이션
- **앱 아이콘**: 한옥 처마선과 위치 마커의 조화
- **타이포그래피**: 세리프체와 산세리프체의 균형
- **로딩 애니메이션**: 단청 3색을 활용한 점진적 페이드

## 🎨 디자인 요소

### 색상 구성
- 배경: 한지 베이지 그라데이션 (#F5E6D3 → #FAFAFA → #F5E6D3)
- 단청 적색 (#D03A29): 지붕 처마선
- 오방색 청색 (#2B4C8C): 위치 마커
- 청자 녹색 (#7BA098): 장식 요소

### 구성 요소
1. **상단 장식**: 전통 구름 문양
2. **중앙 아이콘**: 1.5배 확대된 앱 아이콘
3. **타이틀**: 
   - 메인: 포켓 문화재 가이드 (Noto Serif KR)
   - 서브: K-HERITAGE EXPLORER (Inter)
4. **로딩 인디케이터**: 3색 원형 애니메이션
5. **하단 장식**: 단청 색상 바

## 🛠️ 스플래시 화면 생성 방법

### 1. SVG를 PNG로 변환

현재 SVG 파일이 준비되어 있으나, Flutter 스플래시 생성을 위해 PNG 변환이 필요합니다.

#### macOS
```bash
# librsvg 설치 (이미 설치된 경우 생략)
brew install librsvg

# 전체 스플래시 이미지 변환
rsvg-convert -w 375 -h 812 assets/images/splash.svg -o assets/images/splash_full.png

# 중앙 아이콘만 추출 (권장)
rsvg-convert -w 200 -h 200 assets/icons/app_icon.svg -o assets/images/splash_center.png
```

#### Linux
```bash
# librsvg 설치
sudo apt-get install librsvg2-bin

# SVG 변환
rsvg-convert -w 375 -h 812 assets/images/splash.svg -o assets/images/splash_full.png
rsvg-convert -w 200 -h 200 assets/icons/app_icon.svg -o assets/images/splash_center.png
```

#### Windows
1. [ImageMagick](https://imagemagick.org/script/download.php#windows) 설치
2. 명령 프롬프트:
```cmd
magick convert -background transparent -size 375x812 assets/images/splash.svg assets/images/splash_full.png
magick convert -background transparent -size 200x200 assets/icons/app_icon.svg assets/images/splash_center.png
```

### 2. Flutter Native Splash 생성

```bash
# 패키지 설치
flutter pub get

# 스플래시 화면 생성
flutter pub run flutter_native_splash:create
```

## 📂 파일 구조

```
assets/
├── images/
│   ├── splash.svg              # 전체 스플래시 디자인 SVG
│   ├── splash_center.png       # 중앙 아이콘 PNG (변환 필요)
│   └── splash_full.png         # 전체 스플래시 PNG (선택사항)
└── icons/
    └── app_icon.svg            # 앱 아이콘 SVG

flutter_native_splash.yaml      # 스플래시 설정 파일
lib/main.dart                  # 스플래시 제어 코드 포함
```

## ⚙️ 설정 파일

### flutter_native_splash.yaml
```yaml
flutter_native_splash:
  color: "#F5E6D3"              # 한지 베이지 배경색
  image: assets/images/splash_center.png
  android_12:
    color: "#F5E6D3"
    image: assets/images/splash_center.png
  ios: true
  web: true
  fullscreen: true
```

### main.dart 수정사항
```dart
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // 앱 초기화...
  await _initializeApp();
  
  runApp(const ProviderScope(child: KHeritageExplorerApp()));
}

Future<void> _initializeApp() async {
  // 초기화 작업...
  await AppConfig.instance.initialize();
  
  // 최소 로딩 시간 (UX 개선)
  await Future.delayed(const Duration(milliseconds: 500));
  
  // 스플래시 화면 제거
  FlutterNativeSplash.remove();
}
```

## ✅ 완료된 작업

1. ✅ SVG 스플래시 디자인 생성
2. ✅ flutter_native_splash 패키지 설정
3. ✅ 설정 파일 구성
4. ✅ main.dart 스플래시 제어 코드 추가

## 📋 남은 작업

1. SVG를 PNG로 변환 (위 가이드 참조)
2. `flutter pub run flutter_native_splash:create` 실행
3. 각 플랫폼에서 스플래시 화면 확인

## 🎬 애니메이션 효과

### 로딩 인디케이터
- 3개의 원이 순차적으로 페이드 인/아웃
- 단청 3색 (적색, 녹색, 청색) 사용
- 1.5초 주기로 반복

### 화면 전환
- 스플래시 → 메인: 페이드 아웃 효과
- 최소 500ms 유지로 깜빡임 방지

## 🔍 문제 해결

### PNG 파일이 없다는 오류
위 변환 가이드를 따라 PNG 생성

### 스플래시가 너무 빨리 사라짐
`_initializeApp()`에서 최소 지연 시간 조정:
```dart
await Future.delayed(const Duration(seconds: 1));
```

### Android 12+ 스플래시 문제
`android_12` 섹션에 별도 설정 필요

### iOS 스플래시 크기 문제
`ios_content_mode: center` 설정 확인

## 📱 테스트

```bash
# 스플래시 생성 후 앱 실행
flutter run

# iOS 시뮬레이터
flutter run -d ios

# Android 에뮬레이터
flutter run -d android
```

## 🌙 다크모드 지원

추후 다크모드용 스플래시 이미지 추가 가능:
```yaml
flutter_native_splash:
  color: "#F5E6D3"
  image: assets/images/splash_center.png
  color_dark: "#1A1A1A"
  image_dark: assets/images/splash_center_dark.png
```

## 📚 참고 자료

- [flutter_native_splash 문서](https://pub.dev/packages/flutter_native_splash)
- [Android 12 스플래시 스크린 가이드](https://developer.android.com/guide/topics/ui/splash-screen)
- [iOS Launch Screen 가이드](https://developer.apple.com/design/human-interface-guidelines/launching)