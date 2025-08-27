import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/router/app_router.dart';
import '../../application/tour_explore_controller.dart';
import '../../application/tour_explore_state.dart';
import '../widgets/area_filter_widget.dart';
import '../widgets/theme_filter_widget.dart';
import '../widgets/nearby_filter_widget.dart';
import '../widgets/tour_item_card.dart';

/// 여행지 탐색 화면
class TourExploreScreen extends ConsumerStatefulWidget {
  const TourExploreScreen({super.key});

  @override
  ConsumerState<TourExploreScreen> createState() => _TourExploreScreenState();
}

class _TourExploreScreenState extends ConsumerState<TourExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // 탭 변경 시 필터 모드 업데이트
        final controller = ref.read(tourExploreControllerProvider.notifier);
        switch (_tabController.index) {
          case 0:
            controller.setFilterMode(FilterMode.area);
            break;
          case 1:
            controller.setFilterMode(FilterMode.theme);
            break;
          case 2:
            controller.setFilterMode(FilterMode.nearby);
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(tourExploreControllerProvider);
    final controller = ref.read(tourExploreControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('여행지 탐색'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.location_city),
              text: '지역별',
            ),
            Tab(
              icon: Icon(Icons.category),
              text: '테마별',
            ),
            Tab(
              icon: Icon(Icons.near_me),
              text: '내 주변',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 검색바
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.surface,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '관광지, 맛집, 숙박 등을 검색하세요',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          controller.setSearchKeyword('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant,
              ),
              onChanged: (value) {
                controller.setSearchKeyword(value);
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.search();
                }
              },
            ),
          ),

          // 필터 영역
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: state.filterMode != FilterMode.nearby ? 120 : 100,
            child: TabBarView(
              controller: _tabController,
              children: [
                // 지역별 필터
                AreaFilterWidget(
                  selectedAreaCodes: state.selectedAreaCodes,
                  selectedSigunguCodes: state.selectedSigunguCodes,
                  onAreaChanged: (areaCodes, sigunguCodes) {
                    controller.setAreaFilter(areaCodes, sigunguCodes);
                  },
                ),
                // 테마별 필터
                ThemeFilterWidget(
                  selectedThemes: state.selectedThemes,
                  onThemesChanged: (themes) {
                    controller.setThemeFilter(themes);
                  },
                ),
                // 내 주변 필터
                NearbyFilterWidget(
                  radius: state.radius,
                  hasLocation: state.hasLocation,
                  isRequestingLocation: state.isRequestingLocation,
                  onRadiusChanged: (radius) {
                    controller.setRadius(radius);
                  },
                  onRequestLocation: () {
                    controller.requestLocation();
                  },
                ),
              ],
            ),
          ),

          // 결과 카운트 및 정렬
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '검색 결과 ${state.totalCount}개',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButton<SortType>(
                  value: state.sortType,
                  underline: Container(),
                  style: theme.textTheme.bodyMedium,
                  items: const [
                    DropdownMenuItem(
                      value: SortType.title,
                      child: Text('제목순'),
                    ),
                    DropdownMenuItem(
                      value: SortType.modified,
                      child: Text('최신순'),
                    ),
                    DropdownMenuItem(
                      value: SortType.distance,
                      child: Text('거리순'),
                    ),
                  ],
                  onChanged: state.filterMode == FilterMode.nearby
                      ? null
                      : (value) {
                          if (value != null) {
                            controller.setSortType(value);
                          }
                        },
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 결과 리스트
          Expanded(
            child: state.isLoading && state.attractions.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.attractions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: theme.colorScheme.onSurface.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.error != null
                                  ? state.error!
                                  : state.searchKeyword.isNotEmpty
                                      ? '검색 결과가 없습니다'
                                      : '필터를 선택하여 여행지를 탐색하세요',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (state.error != null) ...[
                              const SizedBox(height: 16),
                              FilledButton.icon(
                                onPressed: () {
                                  if (state.filterMode == FilterMode.nearby && !state.hasLocation) {
                                    controller.requestLocation();
                                  } else {
                                    controller.search();
                                  }
                                },
                                icon: const Icon(Icons.refresh),
                                label: Text(
                                  state.filterMode == FilterMode.nearby && !state.hasLocation
                                      ? '위치 권한 요청'
                                      : '다시 시도',
                                ),
                              ),
                            ],
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await controller.refresh();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.attractions.length + (state.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            // 마지막 아이템에서 추가 로드
                            if (index == state.attractions.length) {
                              // 다음 페이지 로드
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                controller.loadMore();
                              });
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final attraction = state.attractions[index];
                            return TourItemCard(
                              attraction: attraction,
                              showDistance: state.filterMode == FilterMode.nearby,
                              onTap: () {
                                // 상세 화면으로 이동
                                context.goTourDetail(
                                  attraction.contentId,
                                  contentTypeId: attraction.contentTypeId,
                                );
                              },
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}