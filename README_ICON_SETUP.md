# 앱 아이콘 설정 가이드

## 📱 아이콘 디자인 컨셉

한국 전통 미학과 현대 디지털 디자인을 조화롭게 결합한 아이콘으로, 다음 요소들을 포함합니다:
- **한옥 처마선**: 한국 전통 건축의 아름다움
- **위치 마커**: 위치 기반 문화재 탐색 기능
- **태극 문양**: 한국의 정체성
- **단청 색상**: 전통 오방색 활용

## 🎨 색상 팔레트

- 단청 적색 (#D03A29): 주요 강조색
- 오방색 청색 (#2B4C8C): 마커 색상  
- 청자 녹색 (#7BA098): 보조 장식
- 한지 베이지 (#F5E6D3): 배경

## 🛠️ 아이콘 생성 방법

### 1. SVG를 PNG로 변환

현재 SVG 파일이 준비되어 있으나, Flutter 아이콘 생성을 위해 PNG 변환이 필요합니다.

#### macOS
```bash
# librsvg 설치
brew install librsvg

# SVG를 PNG로 변환
rsvg-convert -w 1024 -h 1024 assets/icons/app_icon.svg -o assets/icons/app_icon.png
rsvg-convert -w 1024 -h 1024 assets/icons/app_icon_foreground.svg -o assets/icons/app_icon_foreground.png
```

#### Linux
```bash
# librsvg 설치
sudo apt-get install librsvg2-bin

# SVG를 PNG로 변환
rsvg-convert -w 1024 -h 1024 assets/icons/app_icon.svg -o assets/icons/app_icon.png
rsvg-convert -w 1024 -h 1024 assets/icons/app_icon_foreground.svg -o assets/icons/app_icon_foreground.png
```

#### Windows
1. [ImageMagick](https://imagemagick.org/script/download.php#windows) 설치
2. 명령 프롬프트에서:
```cmd
magick convert -background transparent -size 1024x1024 assets/icons/app_icon.svg assets/icons/app_icon.png
magick convert -background transparent -size 1024x1024 assets/icons/app_icon_foreground.svg assets/icons/app_icon_foreground.png
```

### 2. Flutter 아이콘 생성

PNG 파일 생성 후:
```bash
flutter pub run flutter_launcher_icons
```

## 📂 파일 구조

```
assets/icons/
├── app_icon.svg                # 메인 아이콘 SVG
├── app_icon.png                # 메인 아이콘 PNG (변환 필요)
├── app_icon_foreground.svg     # Android Adaptive Icon 전경
└── app_icon_foreground.png     # Android Adaptive Icon 전경 PNG (변환 필요)

flutter_launcher_icons.yaml      # 아이콘 생성 설정 파일
```

## ⚙️ 설정 파일

`flutter_launcher_icons.yaml`:
- iOS, Android, Web, Windows, macOS 플랫폼 지원
- Android Adaptive Icon 설정 포함
- 배경색: 한지 베이지 (#F5E6D3)

## ✅ 완료된 작업

1. ✅ SVG 아이콘 디자인 생성
2. ✅ flutter_launcher_icons 패키지 설정
3. ✅ 플랫폼별 설정 파일 구성
4. ✅ Android colors.xml 추가

## 📋 남은 작업

1. SVG를 PNG로 변환 (위 가이드 참조)
2. `flutter pub run flutter_launcher_icons` 실행
3. 각 플랫폼에서 아이콘 확인

## 🔍 문제 해결

- **PNG 파일이 없다는 오류**: 위 변환 가이드를 따라 PNG 생성
- **아이콘이 흐릿하게 보임**: 1024x1024 이상의 해상도로 변환
- **Android에서 아이콘 모양이 이상함**: Adaptive Icon 설정 확인

## 📱 테스트

아이콘 생성 후 다음 명령으로 앱 실행:
```bash
flutter run
```

각 플랫폼의 홈 화면에서 앱 아이콘을 확인하세요.