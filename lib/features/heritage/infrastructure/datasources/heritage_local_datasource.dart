import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/heritage.dart';
import '../../../../core/config/app_config.dart';

class HeritageLocalDataSource {
  final SupabaseClient _supabase;
  
  HeritageLocalDataSource({SupabaseClient? supabase})
    : _supabase = supabase ?? AppConfig.instance.supabaseClient;
  
  Future<List<Heritage>> getNearbyHeritages({
    required double latitude,
    required double longitude,
    required double radiusKm,
    String? lang = 'ko',
  }) async {
    try {
      final response = await _supabase
          .rpc('get_nearby_heritages', params: {
            'user_lat': latitude,
            'user_lng': longitude,
            'radius_km': radiusKm,
          });
      
      if (response == null) return [];
      
      final heritages = (response as List).map((data) async {
        final heritageData = data as Map<String, dynamic>;
        
        // Fetch images
        final images = await getHeritageImages(heritageData['id']);
        
        return Heritage(
          id: heritageData['id'],
          kdcd: heritageData['kdcd'] ?? '',
          ctcd: heritageData['ctcd'] ?? '',
          asno: heritageData['asno'] ?? '',
          nameKo: heritageData['name_ko'],
          nameHanja: heritageData['name_hanja'],
          nameEn: lang == 'en' ? heritageData['name_en'] : null,
          nameJa: lang == 'ja' ? heritageData['name_ja'] : null,
          nameZh: lang == 'zh' ? heritageData['name_zh'] : null,
          category: heritageData['category'],
          cityName: heritageData['city_name'],
          sigungu: heritageData['sigungu'],
          address: heritageData['address'],
          latitude: heritageData['latitude'],
          longitude: heritageData['longitude'],
          period: heritageData['period'],
          designatedDate: heritageData['designated_date'] != null 
            ? DateTime.parse(heritageData['designated_date']) 
            : null,
          descriptionKo: heritageData['description_ko'],
          descriptionEn: lang == 'en' ? heritageData['description_en'] : null,
          descriptionJa: lang == 'ja' ? heritageData['description_ja'] : null,
          descriptionZh: lang == 'zh' ? heritageData['description_zh'] : null,
          admin: heritageData['admin'],
          images: images,
          distanceKm: heritageData['distance_km'],
        );
      }).toList();
      
      return Future.wait(heritages);
    } catch (e) {
      throw Exception('Failed to get nearby heritages: $e');
    }
  }
  
  Future<Heritage?> getHeritageById(String id, {String? lang = 'ko'}) async {
    try {
      final response = await _supabase
          .from('heritage')
          .select()
          .eq('id', id)
          .single();
      
      final images = await getHeritageImages(id);
      
      return Heritage(
        id: response['id'],
        kdcd: response['kdcd'],
        ctcd: response['ctcd'],
        asno: response['asno'],
        nameKo: response['name_ko'],
        nameHanja: response['name_hanja'],
        nameEn: lang == 'en' ? response['name_en'] : null,
        nameJa: lang == 'ja' ? response['name_ja'] : null,
        nameZh: lang == 'zh' ? response['name_zh'] : null,
        category: response['category'],
        cityName: response['city_name'],
        sigungu: response['sigungu'],
        address: response['address'],
        latitude: response['latitude'],
        longitude: response['longitude'],
        period: response['period'],
        designatedDate: response['designated_date'] != null 
          ? DateTime.parse(response['designated_date']) 
          : null,
        descriptionKo: response['description_ko'],
        descriptionEn: lang == 'en' ? response['description_en'] : null,
        descriptionJa: lang == 'ja' ? response['description_ja'] : null,
        descriptionZh: lang == 'zh' ? response['description_zh'] : null,
        admin: response['admin'],
        images: images,
      );
    } catch (e) {
      return null;
    }
  }
  
  Future<List<HeritageImage>> getHeritageImages(String heritageId) async {
    try {
      final response = await _supabase
          .from('heritage_image')
          .select()
          .eq('heritage_id', heritageId)
          .order('display_order');
      
      return (response as List).map((data) => HeritageImage(
        id: data['id'],
        heritageId: data['heritage_id'],
        imageUrl: data['image_url'],
        thumbnailUrl: data['thumbnail_url'],
        description: data['description'],
        copyright: data['copyright'],
        displayOrder: data['display_order'] ?? 0,
        createdAt: data['created_at'] != null 
          ? DateTime.parse(data['created_at']) 
          : null,
      )).toList();
    } catch (e) {
      return [];
    }
  }
  
  Future<void> upsertHeritage(Heritage heritage) async {
    try {
      await _supabase.from('heritage').upsert({
        'id': heritage.id,
        'kdcd': heritage.kdcd,
        'ctcd': heritage.ctcd,
        'asno': heritage.asno,
        'name_ko': heritage.nameKo,
        'name_hanja': heritage.nameHanja,
        'name_en': heritage.nameEn,
        'name_ja': heritage.nameJa,
        'name_zh': heritage.nameZh,
        'category': heritage.category,
        'city_name': heritage.cityName,
        'sigungu': heritage.sigungu,
        'address': heritage.address,
        'latitude': heritage.latitude,
        'longitude': heritage.longitude,
        'period': heritage.period,
        'designated_date': heritage.designatedDate?.toIso8601String(),
        'description_ko': heritage.descriptionKo,
        'description_en': heritage.descriptionEn,
        'description_ja': heritage.descriptionJa,
        'description_zh': heritage.descriptionZh,
        'admin': heritage.admin,
        'main_image_url': heritage.mainImageUrl,
      });
      
      // Upsert images
      if (heritage.images.isNotEmpty) {
        await _supabase.from('heritage_image').upsert(
          heritage.images.map((img) => {
            'id': img.id,
            'heritage_id': img.heritageId,
            'image_url': img.imageUrl,
            'thumbnail_url': img.thumbnailUrl,
            'description': img.description,
            'copyright': img.copyright,
            'display_order': img.displayOrder,
          }).toList()
        );
      }
    } catch (e) {
      print('🔴 [HeritageLocalDataSource] Failed to upsert heritage ${heritage.id}: $e');
      throw Exception('Failed to upsert heritage: $e');
    }
  }
  
  Future<void> upsertHeritages(List<Heritage> heritages) async {
    try {
      if (heritages.isEmpty) return;
      
      print('🔵 [HeritageLocalDataSource] Upserting ${heritages.length} heritages to Supabase...');
      
      // Upsert heritages
      await _supabase.from('heritage').upsert(
        heritages.map((h) => {
          'id': h.id,
          'kdcd': h.kdcd,
          'ctcd': h.ctcd,
          'asno': h.asno,
          'name_ko': h.nameKo,
          'name_hanja': h.nameHanja,
          'name_en': h.nameEn,
          'name_ja': h.nameJa,
          'name_zh': h.nameZh,
          'category': h.category,
          'city_name': h.cityName,
          'sigungu': h.sigungu,
          'address': h.address,
          'latitude': h.latitude,
          'longitude': h.longitude,
          'period': h.period,
          'designated_date': h.designatedDate?.toIso8601String(),
          'description_ko': h.descriptionKo,
          'description_en': h.descriptionEn,
          'description_ja': h.descriptionJa,
          'description_zh': h.descriptionZh,
          'admin': h.admin,
          'main_image_url': h.mainImageUrl,
        }).toList()
      );
      
      print('🔵 [HeritageLocalDataSource] Heritage upsert successful');
      
      // Upsert all images
      final allImages = heritages.expand((h) => h.images).toList();
      if (allImages.isNotEmpty) {
        print('🔵 [HeritageLocalDataSource] Upserting ${allImages.length} images...');
        
        await _supabase.from('heritage_image').upsert(
          allImages.map((img) => {
            'id': img.id,
            'heritage_id': img.heritageId,
            'image_url': img.imageUrl,
            'thumbnail_url': img.thumbnailUrl,
            'description': img.description,
            'copyright': img.copyright,
            'display_order': img.displayOrder,
          }).toList()
        );
        
        print('🔵 [HeritageLocalDataSource] Image upsert successful');
      }
      
      print('✅ [HeritageLocalDataSource] Successfully upserted ${heritages.length} heritages with ${allImages.length} images');
    } catch (e) {
      print('🔴 [HeritageLocalDataSource] Failed to upsert heritages: $e');
      print('🔴 [HeritageLocalDataSource] Stack trace: ${StackTrace.current}');
      throw Exception('Failed to upsert heritages: $e');
    }
  }
  
  Future<List<Heritage>> searchHeritages({
    String? keyword,
    String? category,
    String? cityCode,
    String? lang = 'ko',
  }) async {
    try {
      var query = _supabase.from('heritage').select();
      
      if (keyword != null && keyword.isNotEmpty) {
        query = query.or('name_ko.ilike.%$keyword%,address.ilike.%$keyword%');
      }
      
      if (category != null && category.isNotEmpty) {
        query = query.eq('category', category);
      }
      
      if (cityCode != null && cityCode.isNotEmpty) {
        query = query.eq('ctcd', cityCode);
      }
      
      final response = await query.limit(100);
      
      final heritages = (response as List).map((data) async {
        final images = await getHeritageImages(data['id']);
        
        return Heritage(
          id: data['id'],
          kdcd: data['kdcd'],
          ctcd: data['ctcd'],
          asno: data['asno'],
          nameKo: data['name_ko'],
          nameHanja: data['name_hanja'],
          nameEn: lang == 'en' ? data['name_en'] : null,
          nameJa: lang == 'ja' ? data['name_ja'] : null,
          nameZh: lang == 'zh' ? data['name_zh'] : null,
          category: data['category'],
          cityName: data['city_name'],
          sigungu: data['sigungu'],
          address: data['address'],
          latitude: data['latitude'],
          longitude: data['longitude'],
          period: data['period'],
          designatedDate: data['designated_date'] != null 
            ? DateTime.parse(data['designated_date']) 
            : null,
          descriptionKo: data['description_ko'],
          descriptionEn: lang == 'en' ? data['description_en'] : null,
          descriptionJa: lang == 'ja' ? data['description_ja'] : null,
          descriptionZh: lang == 'zh' ? data['description_zh'] : null,
          admin: data['admin'],
          images: images,
        );
      }).toList();
      
      return Future.wait(heritages);
    } catch (e) {
      throw Exception('Failed to search heritages: $e');
    }
  }
}