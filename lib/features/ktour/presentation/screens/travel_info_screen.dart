import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../application/travel_info_controller.dart';
import '../../application/travel_info_state.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/accommodation_card.dart';
import '../widgets/shopping_card.dart';
import '../widgets/travel_filter_sheet.dart';

/// 여행정보 메인 화면
class TravelInfoScreen extends ConsumerStatefulWidget {
  const TravelInfoScreen({super.key});

  @override
  ConsumerState<TravelInfoScreen> createState() => _TravelInfoScreenState();
}

class _TravelInfoScreenState extends ConsumerState<TravelInfoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final categories = TravelCategory.values;
      ref.read(travelInfoControllerProvider.notifier)
          .selectCategory(categories[_tabController.index]);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(travelInfoControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(travelInfoControllerProvider);
    final controller = ref.read(travelInfoControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('여행정보'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: theme.colorScheme.primary,
          tabs: TravelCategory.values.map((category) {
            return Tab(
              text: category.label,
              icon: _getCategoryIcon(category),
            );
          }).toList(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllTab(state, controller),
          _buildRestaurantTab(state, controller),
          _buildAccommodationTab(state, controller),
          _buildShoppingTab(state, controller),
          _buildTransportTab(),
        ],
      ),
    );
  }

  Widget _getCategoryIcon(TravelCategory category) {
    switch (category) {
      case TravelCategory.all:
        return const Icon(Icons.dashboard, size: 20);
      case TravelCategory.restaurant:
        return const Icon(Icons.restaurant, size: 20);
      case TravelCategory.accommodation:
        return const Icon(Icons.hotel, size: 20);
      case TravelCategory.shopping:
        return const Icon(Icons.shopping_bag, size: 20);
      case TravelCategory.transport:
        return const Icon(Icons.directions_bus, size: 20);
    }
  }

  /// 전체 탭
  Widget _buildAllTab(TravelInfoState state, TravelInfoController controller) {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 빠른 필터 칩
            _buildFilterChips(state, controller),

            // 맛집 섹션
            if (state.restaurants.isNotEmpty) ...[
              _buildSectionHeader('맛집 추천', () {
                _tabController.animateTo(1);
              }),
              _buildHorizontalList(
                items: state.restaurants.take(10).toList(),
                itemBuilder: (context, restaurant) => RestaurantCard(
                  restaurant: restaurant,
                  onTap: () => _navigateToDetail(restaurant.contentId, '39'),
                  onBookmarkTap: () => controller.toggleBookmark(
                    contentId: restaurant.contentId,
                    contentTypeId: '39',
                    title: restaurant.title,
                    address: restaurant.address1,
                    imageUrl: restaurant.firstImage,
                  ),
                ),
              ),
            ],

            // 숙박 섹션
            if (state.accommodations.isNotEmpty) ...[
              _buildSectionHeader('숙박 특가', () {
                _tabController.animateTo(2);
              }),
              _buildHorizontalList(
                items: state.accommodations.take(10).toList(),
                itemBuilder: (context, stay) => AccommodationCard(
                  stay: stay,
                  onTap: () => _navigateToDetail(stay.contentId, '32'),
                  onBookmarkTap: () => controller.toggleBookmark(
                    contentId: stay.contentId,
                    contentTypeId: '32',
                    title: stay.title,
                    address: stay.address1,
                    imageUrl: stay.firstImage,
                  ),
                ),
              ),
            ],

            // 쇼핑 섹션
            if (state.shopping.isNotEmpty) ...[
              _buildSectionHeader('쇼핑 명소', () {
                _tabController.animateTo(3);
              }),
              _buildHorizontalList(
                items: state.shopping.take(10).toList(),
                itemBuilder: (context, shop) => ShoppingCard(
                  shop: shop,
                  onTap: () => _navigateToDetail(shop.contentId, '38'),
                  onBookmarkTap: () => controller.toggleBookmark(
                    contentId: shop.contentId,
                    contentTypeId: '38',
                    title: shop.title,
                    address: shop.address1,
                    imageUrl: shop.firstImage,
                  ),
                ),
              ),
            ],

            // 로딩 인디케이터
            if (state.isLoadingRestaurants ||
                state.isLoadingAccommodations ||
                state.isLoadingShopping)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  /// 맛집 탭
  Widget _buildRestaurantTab(TravelInfoState state, TravelInfoController controller) {
    if (state.isLoadingRestaurants && state.restaurants.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.restaurantsError != null && state.restaurants.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(state.restaurantsError!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.loadRestaurants(isRefresh: true),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (state.restaurants.isEmpty) {
      return const Center(
        child: Text('맛집 정보가 없습니다.'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => controller.loadRestaurants(isRefresh: true),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.restaurants.length + (state.hasMoreRestaurants ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.restaurants.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final restaurant = state.restaurants[index];
          return RestaurantCard(
            restaurant: restaurant,
            onTap: () => _navigateToDetail(restaurant.contentId, '39'),
            onBookmarkTap: () => controller.toggleBookmark(
              contentId: restaurant.contentId,
              contentTypeId: '39',
              title: restaurant.title,
              address: restaurant.address1,
              imageUrl: restaurant.firstImage,
            ),
          );
        },
      ),
    );
  }

  /// 숙박 탭
  Widget _buildAccommodationTab(TravelInfoState state, TravelInfoController controller) {
    if (state.isLoadingAccommodations && state.accommodations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.accommodationsError != null && state.accommodations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(state.accommodationsError!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.loadAccommodations(isRefresh: true),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (state.accommodations.isEmpty) {
      return const Center(
        child: Text('숙박 정보가 없습니다.'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => controller.loadAccommodations(isRefresh: true),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.accommodations.length + (state.hasMoreAccommodations ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.accommodations.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final stay = state.accommodations[index];
          return AccommodationCard(
            stay: stay,
            onTap: () => _navigateToDetail(stay.contentId, '32'),
            onBookmarkTap: () => controller.toggleBookmark(
              contentId: stay.contentId,
              contentTypeId: '32',
              title: stay.title,
              address: stay.address1,
              imageUrl: stay.firstImage,
            ),
          );
        },
      ),
    );
  }

  /// 쇼핑 탭
  Widget _buildShoppingTab(TravelInfoState state, TravelInfoController controller) {
    if (state.isLoadingShopping && state.shopping.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.shoppingError != null && state.shopping.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(state.shoppingError!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.loadShopping(isRefresh: true),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (state.shopping.isEmpty) {
      return const Center(
        child: Text('쇼핑 정보가 없습니다.'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => controller.loadShopping(isRefresh: true),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.shopping.length + (state.hasMoreShopping ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.shopping.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final shop = state.shopping[index];
          return ShoppingCard(
            shop: shop,
            onTap: () => _navigateToDetail(shop.contentId, '38'),
            onBookmarkTap: () => controller.toggleBookmark(
              contentId: shop.contentId,
              contentTypeId: '38',
              title: shop.title,
              address: shop.address1,
              imageUrl: shop.firstImage,
            ),
          );
        },
      ),
    );
  }

  /// 교통 탭
  Widget _buildTransportTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            '교통 정보 서비스 준비 중',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '빠른 시일 내에 서비스를 제공하겠습니다.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// 필터 칩 빌드
  Widget _buildFilterChips(TravelInfoState state, TravelInfoController controller) {
    final theme = Theme.of(context);
    
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          FilterChip(
            label: Text(
              '내 주변',
              style: TextStyle(
                color: state.filter.maxDistance != null 
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: state.filter.maxDistance != null,
            selectedColor: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.surfaceVariant,
            checkmarkColor: theme.colorScheme.onPrimary,
            onSelected: (selected) {
              controller.updateFilter(
                state.filter.copyWith(maxDistance: selected ? 5.0 : null),
              );
            },
          ),
          const SizedBox(width: 8),
          ...SortBy.values.map((sortBy) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(
                    sortBy.label,
                    style: TextStyle(
                      color: state.filter.sortBy == sortBy
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: state.filter.sortBy == sortBy,
                  selectedColor: theme.colorScheme.primary,
                  backgroundColor: theme.colorScheme.surfaceVariant,
                  onSelected: (selected) {
                    if (selected) controller.changeSortBy(sortBy);
                  },
                ),
              )),
        ],
      ),
    );
  }

  /// 섹션 헤더 빌드
  Widget _buildSectionHeader(String title, VoidCallback onSeeMore) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onSeeMore,
            child: const Text('더보기 >'),
          ),
        ],
      ),
    );
  }

  /// 횡스크롤 리스트 빌드
  Widget _buildHorizontalList<T>({
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
  }) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < items.length - 1 ? 12 : 0),
            child: SizedBox(
              width: 200,
              child: itemBuilder(context, items[index]),
            ),
          );
        },
      ),
    );
  }

  /// 필터 시트 표시
  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const TravelFilterSheet(),
    );
  }

  /// 상세 화면으로 이동
  void _navigateToDetail(String contentId, String contentTypeId) {
    context.push('/ktour/detail/$contentId?contentTypeId=$contentTypeId');
  }
}