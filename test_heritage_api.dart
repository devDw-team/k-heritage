import 'package:dio/dio.dart';
import 'package:xml/xml.dart' as xml;

void main() async {
  final dio = Dio();
  
  print('=== Testing Heritage API ===\n');
  
  // Test 1: Fetch heritage list
  print('1. Testing heritage list...');
  try {
    final listResponse = await dio.get(
      'http://www.khs.go.kr/cha/SearchKindOpenapiList.do',
      queryParameters: {
        'pageUnit': 5,
        'pageIndex': 1,
        'ccbaCncl': 'N',
        'ccbaCtcd': '11', // Seoul
      },
    );
    
    final listDoc = xml.XmlDocument.parse(listResponse.data.toString());
    final items = listDoc.findAllElements('item');
    
    print('Found ${items.length} heritage items\n');
    
    if (items.isNotEmpty) {
      final firstItem = items.first;
      final kdcd = firstItem.findElements('ccbaKdcd').first.text;
      final asno = firstItem.findElements('ccbaAsno').first.text;
      final ctcd = firstItem.findElements('ccbaCtcd').first.text;
      final name = firstItem.findElements('ccbaMnm1').first.text;
      
      print('First heritage: $name');
      print('  kdcd: $kdcd, asno: $asno, ctcd: $ctcd');
      
      // Check if imageUrl exists in list response
      final imageUrlElements = firstItem.findElements('imageUrl');
      if (imageUrlElements.isNotEmpty) {
        print('  Image URL in list: ${imageUrlElements.first.text}');
      } else {
        print('  No imageUrl in list response');
      }
      
      // Test 2: Fetch images for this heritage
      print('\n2. Testing image API for $name...');
      try {
        final imageResponse = await dio.get(
          'http://www.khs.go.kr/cha/SearchImageOpenapi.do',
          queryParameters: {
            'ccbaKdcd': kdcd,
            'ccbaAsno': asno,
            'ccbaCtcd': ctcd,
          },
        );
        
        final imageDoc = xml.XmlDocument.parse(imageResponse.data.toString());
        final imageItems = imageDoc.findAllElements('item');
        
        print('Found ${imageItems.length} images');
        
        for (var i = 0; i < imageItems.length && i < 3; i++) {
          final item = imageItems.elementAt(i);
          final imageUrl = item.findElements('imageUrl').firstOrNull?.text ?? 'N/A';
          final desc = item.findElements('ccimDesc').firstOrNull?.text ?? 'N/A';
          print('  Image ${i + 1}: $imageUrl');
          print('    Description: $desc');
        }
      } catch (e) {
        print('Error fetching images: $e');
      }
      
      // Test 3: Fetch detail
      print('\n3. Testing detail API for $name...');
      try {
        final detailResponse = await dio.get(
          'http://www.khs.go.kr/cha/SearchKindOpenapiDt.do',
          queryParameters: {
            'ccbaKdcd': kdcd,
            'ccbaAsno': asno,
            'ccbaCtcd': ctcd,
          },
        );
        
        final detailDoc = xml.XmlDocument.parse(detailResponse.data.toString());
        final detailItem = detailDoc.findAllElements('item').firstOrNull;
        
        if (detailItem != null) {
          final detailImageUrl = detailItem.findElements('imageUrl').firstOrNull?.text;
          if (detailImageUrl != null) {
            print('Image URL in detail: $detailImageUrl');
          } else {
            print('No imageUrl in detail response');
          }
        }
      } catch (e) {
        print('Error fetching detail: $e');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
  
  print('\n=== Test Complete ===');
}