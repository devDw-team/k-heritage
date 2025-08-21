import 'package:dio/dio.dart';
import 'package:xml/xml.dart' as xml;
import '../../domain/entities/heritage.dart';
import '../../../../core/utils/logger.dart';

class HeritageRemoteDataSource {
  final Dio _dio;
  static const String baseUrl = 'http://www.khs.go.kr/cha';
  
  HeritageRemoteDataSource({Dio? dio}) 
    : _dio = dio ?? Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/xml',
          'User-Agent': 'K-Heritage Explorer/1.0',
        },
      ));
  
  Future<List<Heritage>> fetchHeritageList({
    String? cityCode,
    String? keyword,
    int page = 1,
    int pageSize = 50,
    bool fetchImages = true,
  }) async {
    try {
      Log.i('Fetching heritage list - cityCode: $cityCode, keyword: $keyword, page: $page, pageSize: $pageSize');
      
      final response = await _dio.get(
        '/SearchKindOpenapiList.do',
        queryParameters: {
          'pageUnit': pageSize,
          'pageIndex': page,
          'ccbaCncl': 'N',
          if (cityCode != null) 'ccbaCtcd': cityCode,
          if (keyword != null) 'ccbaMnm1': keyword,
        },
      );
      
      Log.d('API Response status: ${response.statusCode}');
      
      if (response.data == null || response.data.toString().isEmpty) {
        Log.w('Empty response from API');
        return [];
      }
      
      final document = xml.XmlDocument.parse(response.data.toString());
      final items = document.findAllElements('item');
      
      Log.i('Found ${items.length} heritage items');
      
      // Parse all heritages first
      final parsedHeritages = items.map((item) {
        try {
          return _parseHeritage(item);
        } catch (e) {
          Log.e('Error parsing heritage item', error: e);
          return null;
        }
      }).where((h) => h != null).cast<Heritage>().toList();
      
      Log.i('Parsed ${parsedHeritages.length} heritages, now fetching images...');
      
      // Fetch images for a limited number of heritages to avoid too many requests
      final heritages = <Heritage>[];
      for (var i = 0; i < parsedHeritages.length && i < 10; i++) { // Limit to first 10 for performance
        final heritage = parsedHeritages[i];
        
        if (fetchImages) {
          try {
            Log.d('Fetching images for ${heritage.nameKo}...');
            final images = await fetchHeritageImages(
              kdcd: heritage.kdcd,
              asno: heritage.asno,
              ctcd: heritage.ctcd,
            );
            
            if (images.isNotEmpty) {
              Log.d('Found ${images.length} images for ${heritage.nameKo}');
              heritages.add(heritage.copyWith(images: images.take(1).toList())); // Take only 1 image per heritage
            } else {
              Log.d('No images found for ${heritage.nameKo}, using placeholder');
              heritages.add(heritage.copyWith(images: [
                HeritageImage(
                  id: '${heritage.id}_placeholder',
                  heritageId: heritage.id,
                  imageUrl: 'https://via.placeholder.com/400x300.png?text=${Uri.encodeComponent(heritage.nameKo)}',
                  thumbnailUrl: 'https://via.placeholder.com/400x300.png?text=${Uri.encodeComponent(heritage.nameKo)}',
                  displayOrder: 0,
                ),
              ]));
            }
          } catch (e) {
            Log.w('Failed to fetch images for ${heritage.nameKo}: $e');
            heritages.add(heritage.copyWith(images: [
              HeritageImage(
                id: '${heritage.id}_placeholder',
                heritageId: heritage.id,
                imageUrl: 'https://via.placeholder.com/400x300.png?text=${Uri.encodeComponent(heritage.nameKo)}',
                thumbnailUrl: 'https://via.placeholder.com/400x300.png?text=${Uri.encodeComponent(heritage.nameKo)}',
                displayOrder: 0,
              ),
            ]));
          }
        } else {
          heritages.add(heritage);
        }
      }
      
      // Add remaining heritages without images
      for (var i = 10; i < parsedHeritages.length; i++) {
        final heritage = parsedHeritages[i];
        heritages.add(heritage.copyWith(images: [
          HeritageImage(
            id: '${heritage.id}_placeholder',
            heritageId: heritage.id,
            imageUrl: 'https://via.placeholder.com/400x300.png?text=${Uri.encodeComponent(heritage.nameKo)}',
            thumbnailUrl: 'https://via.placeholder.com/400x300.png?text=${Uri.encodeComponent(heritage.nameKo)}',
            displayOrder: 0,
          ),
        ]));
      }
      
      Log.i('Successfully parsed ${heritages.length} heritage items with images');
      return heritages;
    } on DioException catch (e) {
      Log.e('DioException in fetchHeritageList', error: e);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('연결 시간 초과. 네트워크를 확인해주세요.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('서버에 연결할 수 없습니다.');
      } else if (e.response?.statusCode == 404) {
        throw Exception('API 엔드포인트를 찾을 수 없습니다.');
      }
      throw Exception('문화재 정보를 가져오는데 실패했습니다: ${e.message}');
    } catch (e) {
      Log.e('Unexpected error in fetchHeritageList', error: e);
      throw Exception('문화재 정보를 가져오는데 실패했습니다: $e');
    }
  }
  
  Future<Heritage> fetchHeritageDetail({
    required String kdcd,
    required String asno,
    required String ctcd,
  }) async {
    try {
      final response = await _dio.get(
        '/SearchKindOpenapiDt.do',
        queryParameters: {
          'ccbaKdcd': kdcd,
          'ccbaAsno': asno,
          'ccbaCtcd': ctcd,
        },
      );
      
      final document = xml.XmlDocument.parse(response.data);
      final item = document.findAllElements('item').firstOrNull;
      
      if (item == null) {
        throw Exception('Heritage not found');
      }
      
      final heritage = _parseDetailHeritage(item);
      
      // Fetch images
      final images = await fetchHeritageImages(
        kdcd: kdcd,
        asno: asno,
        ctcd: ctcd,
      );
      
      return heritage.copyWith(images: images);
    } catch (e) {
      throw Exception('Failed to fetch heritage detail: $e');
    }
  }
  
  Future<List<HeritageImage>> fetchHeritageImages({
    required String kdcd,
    required String asno,
    required String ctcd,
  }) async {
    try {
      Log.d('Fetching images for heritage: kdcd=$kdcd, asno=$asno, ctcd=$ctcd');
      
      final response = await _dio.get(
        '/SearchImageOpenapi.do',
        queryParameters: {
          'ccbaKdcd': kdcd,
          'ccbaAsno': asno,
          'ccbaCtcd': ctcd,
        },
      );
      
      final document = xml.XmlDocument.parse(response.data);
      final items = document.findAllElements('item');
      
      Log.d('Found ${items.length} images for heritage');
      
      final images = items.indexed.map((indexed) {
        final (index, item) = indexed;
        var imageUrl = _getElementText(item, 'imageUrl') ?? '';
        final imageNuri = _getElementText(item, 'imageNuri') ?? '';
        final ccimDesc = _getElementText(item, 'ccimDesc') ?? '';
        
        // 이미지 URL 검증 및 수정
        if (imageUrl.isNotEmpty) {
          // Remove any potential whitespace
          imageUrl = imageUrl.trim();
          
          // Log the original URL for debugging
          Log.d('Original image URL: $imageUrl');
          
          // If URL doesn't start with http, add the base URL
          if (!imageUrl.startsWith('http')) {
            imageUrl = 'http://www.khs.go.kr$imageUrl';
          }
          
          // Some URLs might be from the old heritage.go.kr domain
          // Try to fix common URL issues
          if (imageUrl.contains('heritage.go.kr')) {
            // Skip these as they're likely invalid
            Log.w('Skipping heritage.go.kr URL: $imageUrl');
            return null;
          }
        }
        
        if (imageUrl.isEmpty) {
          return null;
        }
        
        return HeritageImage(
          id: '${kdcd}_${asno}_${ctcd}_$index',
          heritageId: '${kdcd}_${asno}_${ctcd}',
          imageUrl: imageUrl,
          thumbnailUrl: imageUrl,
          description: ccimDesc,
          copyright: imageNuri,
          displayOrder: index,
        );
      }).where((image) => image != null).cast<HeritageImage>().toList();
      
      Log.d('Returning ${images.length} valid images');
      return images;
    } catch (e) {
      Log.e('Error fetching heritage images', error: e);
      return [];
    }
  }
  
  Heritage _parseHeritage(xml.XmlElement item) {
    final kdcd = _getElementText(item, 'ccbaKdcd') ?? '';
    final asno = _getElementText(item, 'ccbaAsno') ?? '';
    final ctcd = _getElementText(item, 'ccbaCtcd') ?? '';
    final nameKo = _getElementText(item, 'ccbaMnm1') ?? '';
    final lat = double.tryParse(_getElementText(item, 'latitude') ?? '0') ?? 0;
    final lng = double.tryParse(_getElementText(item, 'longitude') ?? '0') ?? 0;
    
    Log.d('Parsing heritage: $nameKo (kdcd: $kdcd, asno: $asno, ctcd: $ctcd, lat: $lat, lng: $lng)');
    
    return Heritage(
      id: '${kdcd}_${asno}_${ctcd}',
      kdcd: kdcd,
      ctcd: ctcd,
      asno: asno,
      nameKo: nameKo,
      nameHanja: _getElementText(item, 'ccbaMnm2'),
      category: _getElementText(item, 'ccbaKdcdNm') ?? '',
      cityName: _getElementText(item, 'ccbaCtcdNm'),
      sigungu: _getElementText(item, 'ccsiName'),
      address: _getElementText(item, 'ccbaLcad') ?? '',
      latitude: lat,
      longitude: lng,
      period: _getElementText(item, 'ccceName'),
      designatedDate: _parseDate(_getElementText(item, 'ccbaAsdt')),
      images: [], // Images will be fetched separately
    );
  }
  
  Heritage _parseDetailHeritage(xml.XmlElement item) {
    final heritage = _parseHeritage(item);
    final content = _getElementText(item, 'content');
    
    return heritage.copyWith(
      descriptionKo: content,
      admin: _getElementText(item, 'ccbaAdmin'),
    );
  }
  
  String? _getElementText(xml.XmlElement parent, String name) {
    final elements = parent.findElements(name);
    if (elements.isEmpty) return null;
    final text = elements.first.innerText;
    return text.isEmpty ? null : text;
  }
  
  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.length != 8) return null;
    try {
      final year = int.parse(dateStr.substring(0, 4));
      final month = int.parse(dateStr.substring(4, 6));
      final day = int.parse(dateStr.substring(6, 8));
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }
  
  static const Map<String, String> cityCodeMap = {
    '서울특별시': '11',
    '부산광역시': '21',
    '대구광역시': '22',
    '인천광역시': '23',
    '광주광역시': '24',
    '대전광역시': '25',
    '울산광역시': '26',
    '경기도': '31',
    '강원도': '32',
    '충청북도': '33',
    '충청남도': '34',
    '전라북도': '35',
    '전라남도': '36',
    '경상북도': '37',
    '경상남도': '38',
    '제주특별자치도': '39',
    '세종특별자치시': '45',
    '전국일원': 'ZZ',
  };
}