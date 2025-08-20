import 'dart:io';
import 'dart:convert';

/// 스플래시 화면용 PNG 이미지 생성 스크립트
void main() async {
  print('스플래시 화면 PNG 파일 생성 중...');
  
  // 임시 PNG 파일 생성 (실제로는 SVG를 PNG로 변환 필요)
  const base64Png = '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==
''';
  
  final pngBytes = base64Decode(base64Png.replaceAll('\n', ''));
  
  final splashFile = File('assets/images/splash_center.png');
  await splashFile.writeAsBytes(pngBytes);
  
  // 큰 크기 아이콘도 생성
  final splashLargeFile = File('assets/images/splash_center_large.png');
  await splashLargeFile.writeAsBytes(pngBytes);
  
  print('''
⚠️  임시 스플래시 PNG 파일이 생성되었습니다.
    
실제 스플래시 이미지를 생성하려면:

1. SVG를 PNG로 변환:
   rsvg-convert -w 375 -h 812 assets/images/splash.svg -o assets/images/splash_full.png
   
2. 중앙 아이콘만 추출 (크기별):
   # 작은 크기 (기존)
   rsvg-convert -w 200 -h 200 assets/icons/app_icon.svg -o assets/images/splash_center.png
   
   # 큰 크기 (권장)
   rsvg-convert -w 400 -h 400 assets/icons/app_icon.svg -o assets/images/splash_center_large.png

3. flutter_native_splash 실행:
   flutter pub get
   flutter pub run flutter_native_splash:create

4. 앱 초기화 코드에 추가:
   import 'package:flutter_native_splash/flutter_native_splash.dart';
   
   void main() {
     WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
     FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
     
     // 앱 초기화...
     
     FlutterNativeSplash.remove(); // 초기화 완료 후 호출
   }
''');
}