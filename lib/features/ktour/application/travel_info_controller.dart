import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/utils/logger.dart';
import '../infrastructure/datasources/tour_api_datasource.dart';
import '../domain/entities/tour_restaurant.dart';
import '../domain/entities/tour_shopping.dart';
import '../domain/entities/tour_stay.dart';
import 'travel_info_state.dart';
import 'bookmark_controller.dart';

/// 여행정보 컨트롤러 프로바이더
final travelInfoControllerProvider = StateNotifierProvider<TravelInfoController, TravelInfoState>((ref) {
  final apiDataSource = ref.watch(tourAPIDataSourceProvider);
  final bookmarkController = ref.watch(bookmarkControllerProvider.notifier);
  return TravelInfoController(
    apiDataSource: apiDataSource,
    bookmarkController: bookmarkController,
  );
});

/// 여행정보 상태 관리 컨트롤러
class TravelInfoController extends StateNotifier<TravelInfoState> {
  final TourAPIDataSource _apiDataSource;
  final BookmarkController _bookmarkController;
  
  TravelInfoController({
    required TourAPIDataSource apiDataSource,
    required BookmarkController bookmarkController,
  })  : _apiDataSource = apiDataSource,
        _bookmarkController = bookmarkController,
        super(const TravelInfoState()) {
    _init();
  }

  /// 초기화
  Future<void> _init() async {
    await _getCurrentLocation();
    await loadInitialData();
  }

  /// 현재 위치 가져오기
  Future<void> _getCurrentLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requested = await Geolocator.requestPermission();
        if (requested == LocationPermission.denied ||
            requested == LocationPermission.deniedForever) {
          // 서울시청 좌표 사용 (기본값)
          state = state.copyWith(
            currentLat: 37.5666,
            currentLng: 126.9784,
          );
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();
      state = state.copyWith(
        currentLat: position.latitude,
        currentLng: position.longitude,
      );
    } catch (e) {
      Log.e('Failed to get current location', error: e);
      // 서울시청 좌표 사용 (기본값)
      state = state.copyWith(
        currentLat: 37.5666,
        currentLng: 126.9784,
      );
    }
  }

  /// 초기 데이터 로드
  Future<void> loadInitialData() async {
    await Future.wait([
      loadRestaurants(),
      loadAccommodations(),
      loadShopping(),
    ]);
  }

  /// 맛집 데이터 로드
  Future<void> loadRestaurants({bool isRefresh = false}) async {
    if (state.isLoadingRestaurants) return;

    state = state.copyWith(
      isLoadingRestaurants: true,
      restaurantsError: null,
      restaurantsPage: isRefresh ? 1 : state.restaurantsPage,
      restaurants: isRefresh ? [] : state.restaurants,
    );

    try {
      final response = await _apiDataSource.searchRestaurants(
        areaCode: state.filter.areaCode,
        sigunguCode: state.filter.sigunguCode,
        mapX: state.currentLng,
        mapY: state.currentLat,
        radius: state.filter.maxDistance != null 
            ? (state.filter.maxDistance! * 1000).round() 
            : null,
        cat3: state.filter.foodType,
        pageNo: state.restaurantsPage,
        numOfRows: 20,
      );

      final restaurants = response
          .map((data) => TourRestaurant.fromApiResponse(data))
          .toList();

      // 북마크 상태 업데이트
      final updatedRestaurants = await Future.wait(restaurants.map((restaurant) async {
        final isBookmarked = await _bookmarkController.isBookmarked(restaurant.contentId);
        return restaurant.copyWith(isBookmarked: isBookmarked);
      }).toList());

      // 정렬 적용
      _sortList(updatedRestaurants);

      state = state.copyWith(
        restaurants: [...state.restaurants, ...updatedRestaurants],
        isLoadingRestaurants: false,
        hasMoreRestaurants: restaurants.length >= 20,
        restaurantsPage: state.restaurantsPage + 1,
      );
    } catch (e) {
      Log.e('Failed to load restaurants', error: e);
      state = state.copyWith(
        isLoadingRestaurants: false,
        restaurantsError: '맛집 정보를 불러오는데 실패했습니다.',
      );
    }
  }

  /// 숙박 데이터 로드
  Future<void> loadAccommodations({bool isRefresh = false}) async {
    if (state.isLoadingAccommodations) return;

    state = state.copyWith(
      isLoadingAccommodations: true,
      accommodationsError: null,
      accommodationsPage: isRefresh ? 1 : state.accommodationsPage,
      accommodations: isRefresh ? [] : state.accommodations,
    );

    try {
      final response = await _apiDataSource.searchStay(
        areaCode: state.filter.areaCode,
        sigunguCode: state.filter.sigunguCode,
        hanOk: state.filter.hanOk ? 'Y' : null,
        goodStay: state.filter.goodStay ? 'Y' : null,
        pageNo: state.accommodationsPage,
        numOfRows: 20,
      );

      final accommodations = response
          .map((data) => TourStay.fromApiResponse(data))
          .toList();

      // 북마크 상태 업데이트
      final updatedAccommodations = await Future.wait(accommodations.map((stay) async {
        final isBookmarked = await _bookmarkController.isBookmarked(stay.contentId);
        return stay.copyWith(isBookmarked: isBookmarked);
      }).toList());

      // 거리 계산 및 정렬
      if (state.currentLat != null && state.currentLng != null) {
        for (var accommodation in updatedAccommodations) {
          if (accommodation.mapX != null && accommodation.mapY != null) {
            final distance = Geolocator.distanceBetween(
              state.currentLat!,
              state.currentLng!,
              accommodation.mapY!,
              accommodation.mapX!,
            ) / 1000; // km 단위
            accommodation = accommodation.copyWith(distance: distance);
          }
        }
      }

      _sortList(updatedAccommodations);

      state = state.copyWith(
        accommodations: [...state.accommodations, ...updatedAccommodations],
        isLoadingAccommodations: false,
        hasMoreAccommodations: accommodations.length >= 20,
        accommodationsPage: state.accommodationsPage + 1,
      );
    } catch (e) {
      Log.e('Failed to load accommodations', error: e);
      state = state.copyWith(
        isLoadingAccommodations: false,
        accommodationsError: '숙박 정보를 불러오는데 실패했습니다.',
      );
    }
  }

  /// 쇼핑 데이터 로드
  Future<void> loadShopping({bool isRefresh = false}) async {
    if (state.isLoadingShopping) return;

    state = state.copyWith(
      isLoadingShopping: true,
      shoppingError: null,
      shoppingPage: isRefresh ? 1 : state.shoppingPage,
      shopping: isRefresh ? [] : state.shopping,
    );

    try {
      final response = await _apiDataSource.searchShopping(
        areaCode: state.filter.areaCode,
        sigunguCode: state.filter.sigunguCode,
        mapX: state.currentLng,
        mapY: state.currentLat,
        radius: state.filter.maxDistance != null 
            ? (state.filter.maxDistance! * 1000).round() 
            : null,
        cat3: state.filter.shopType,
        pageNo: state.shoppingPage,
        numOfRows: 20,
      );

      final shopping = response
          .map((data) => TourShopping.fromApiResponse(data))
          .toList();

      // 북마크 상태 업데이트
      final updatedShopping = await Future.wait(shopping.map((shop) async {
        final isBookmarked = await _bookmarkController.isBookmarked(shop.contentId);
        return shop.copyWith(isBookmarked: isBookmarked);
      }).toList());

      _sortList(updatedShopping);

      state = state.copyWith(
        shopping: [...state.shopping, ...updatedShopping],
        isLoadingShopping: false,
        hasMoreShopping: shopping.length >= 20,
        shoppingPage: state.shoppingPage + 1,
      );
    } catch (e) {
      Log.e('Failed to load shopping', error: e);
      state = state.copyWith(
        isLoadingShopping: false,
        shoppingError: '쇼핑 정보를 불러오는데 실패했습니다.',
      );
    }
  }

  /// 카테고리 선택
  void selectCategory(TravelCategory category) {
    state = state.copyWith(selectedCategory: category);
  }

  /// 필터 업데이트
  void updateFilter(TravelFilter filter) {
    state = state.copyWith(filter: filter);
    refresh();
  }

  /// 정렬 기준 변경
  void changeSortBy(SortBy sortBy) {
    state = state.copyWith(filter: state.filter.copyWith(sortBy: sortBy));
    
    // 현재 데이터 재정렬
    final sortedRestaurants = [...state.restaurants];
    final sortedAccommodations = [...state.accommodations];
    final sortedShopping = [...state.shopping];
    
    _sortList(sortedRestaurants);
    _sortList(sortedAccommodations);
    _sortList(sortedShopping);
    
    state = state.copyWith(
      restaurants: sortedRestaurants,
      accommodations: sortedAccommodations,
      shopping: sortedShopping,
    );
  }

  /// 리스트 정렬
  void _sortList<T>(List<T> list) {
    switch (state.filter.sortBy) {
      case SortBy.distance:
        if (T == TourRestaurant) {
          (list as List<TourRestaurant>).sort((a, b) =>
              (a.distance ?? double.infinity)
                  .compareTo(b.distance ?? double.infinity));
        } else if (T == TourStay) {
          (list as List<TourStay>).sort((a, b) =>
              (a.distance ?? double.infinity)
                  .compareTo(b.distance ?? double.infinity));
        } else if (T == TourShopping) {
          (list as List<TourShopping>).sort((a, b) =>
              (a.distance ?? double.infinity)
                  .compareTo(b.distance ?? double.infinity));
        }
        break;
      case SortBy.name:
        if (T == TourRestaurant) {
          (list as List<TourRestaurant>).sort((a, b) =>
              a.title.compareTo(b.title));
        } else if (T == TourStay) {
          (list as List<TourStay>).sort((a, b) =>
              a.title.compareTo(b.title));
        } else if (T == TourShopping) {
          (list as List<TourShopping>).sort((a, b) =>
              a.title.compareTo(b.title));
        }
        break;
      case SortBy.popular:
        // 인기순은 API에서 제공하는 순서 유지
        break;
    }
  }

  /// 북마크 토글
  Future<void> toggleBookmark({
    required String contentId,
    required String contentTypeId,
    required String title,
    String? address,
    String? imageUrl,
  }) async {
    await _bookmarkController.toggleBookmarkGeneric(
      contentId: contentId,
      contentTypeId: contentTypeId,
      title: title,
      address: address,
      imageUrl: imageUrl,
    );

    // 상태 업데이트
    if (contentTypeId == '39') {
      final updatedRestaurants = state.restaurants.map((restaurant) {
        if (restaurant.contentId == contentId) {
          return restaurant.copyWith(isBookmarked: !restaurant.isBookmarked);
        }
        return restaurant;
      }).toList();
      state = state.copyWith(restaurants: updatedRestaurants);
    } else if (contentTypeId == '32') {
      final updatedAccommodations = state.accommodations.map((stay) {
        if (stay.contentId == contentId) {
          return stay.copyWith(isBookmarked: !stay.isBookmarked);
        }
        return stay;
      }).toList();
      state = state.copyWith(accommodations: updatedAccommodations);
    } else if (contentTypeId == '38') {
      final updatedShopping = state.shopping.map((shop) {
        if (shop.contentId == contentId) {
          return shop.copyWith(isBookmarked: !shop.isBookmarked);
        }
        return shop;
      }).toList();
      state = state.copyWith(shopping: updatedShopping);
    }
  }

  /// 전체 새로고침
  Future<void> refresh() async {
    await Future.wait([
      loadRestaurants(isRefresh: true),
      loadAccommodations(isRefresh: true),
      loadShopping(isRefresh: true),
    ]);
  }

  /// 더 많은 데이터 로드
  Future<void> loadMore() async {
    switch (state.selectedCategory) {
      case TravelCategory.restaurant:
        if (state.hasMoreRestaurants) await loadRestaurants();
        break;
      case TravelCategory.accommodation:
        if (state.hasMoreAccommodations) await loadAccommodations();
        break;
      case TravelCategory.shopping:
        if (state.hasMoreShopping) await loadShopping();
        break;
      case TravelCategory.all:
        await Future.wait([
          if (state.hasMoreRestaurants) loadRestaurants(),
          if (state.hasMoreAccommodations) loadAccommodations(),
          if (state.hasMoreShopping) loadShopping(),
        ]);
        break;
      case TravelCategory.transport:
        // 교통 정보는 별도 처리
        break;
    }
  }
}