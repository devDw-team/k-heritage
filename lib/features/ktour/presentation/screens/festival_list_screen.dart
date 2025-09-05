import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/festival_controller.dart';
import '../../application/festival_state.dart';
import '../../domain/entities/tour_festival.dart';
import '../widgets/festival_card_widget.dart';
import '../widgets/festival_filter_widget.dart';

/// 축제 목록 화면
class FestivalListScreen extends ConsumerStatefulWidget {
  const FestivalListScreen({super.key});

  @override
  ConsumerState<FestivalListScreen> createState() => _FestivalListScreenState();
}

class _FestivalListScreenState extends ConsumerState<FestivalListScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
    _scrollController.addListener(_handleScroll);
  }
  
  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final controller = ref.read(festivalControllerProvider.notifier);
      switch (_tabController.index) {
        case 0: // 진행중
          controller.setFilterStatus(FestivalStatus.ongoing);
          break;
        case 1: // 예정
          controller.setFilterStatus(FestivalStatus.upcoming);
          break;
        case 2: // 종료
          controller.setFilterStatus(FestivalStatus.ended);
          break;
        case 3: // 전체
          controller.setFilterStatus(null);
          break;
      }
    }
  }
  
  void _handleScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(festivalControllerProvider.notifier).loadMore();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(festivalControllerProvider);
    final controller = ref.read(festivalControllerProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('행사/축제'),
        elevation: 0,
        actions: [
          // 캘린더 뷰 버튼
          IconButton(
            icon: Icon(
              state.viewMode == 'calendar' 
                  ? Icons.list 
                  : Icons.calendar_month,
            ),
            onPressed: () {
              if (state.viewMode == 'calendar') {
                controller.setViewMode('list');
              } else {
                context.push('/ktour/festival/calendar');
              }
            },
            tooltip: state.viewMode == 'calendar' ? '목록 보기' : '캘린더 보기',
          ),
          // 필터 버튼
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
            tooltip: '필터',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('진행중'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('예정'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('종료'),
                ],
              ),
            ),
            const Tab(text: '전체'),
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
                hintText: '축제명, 장소로 검색',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          controller.setSearchKeyword('');
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                setState(() {});
                controller.setSearchKeyword(value);
              },
              onSubmitted: (value) {
                controller.setSearchKeyword(value);
              },
            ),
          ),
          
          // 필터 정보 표시
          if (state.filterAreaCode != null || state.filterMonth != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, size: 16),
                  const SizedBox(width: 8),
                  if (state.filterAreaCode != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getAreaName(state.filterAreaCode!),
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  if (state.filterMonth != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${state.filterMonth!.year}년 ${state.filterMonth!.month}월',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  TextButton(
                    onPressed: controller.clearFilters,
                    child: const Text('초기화'),
                  ),
                ],
              ),
            ),
          
          // 축제 목록
          Expanded(
            child: state.isLoading && state.festivals.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : state.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: theme.colorScheme.error,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.error!,
                              style: TextStyle(
                                color: theme.colorScheme.error,
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.tonal(
                              onPressed: controller.refresh,
                              child: const Text('다시 시도'),
                            ),
                          ],
                        ),
                      )
                    : state.festivals.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.festival_outlined,
                                  size: 64,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '축제 정보가 없습니다',
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: controller.refresh,
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(16),
                              itemCount: state.festivals.length + 
                                  (state.isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index >= state.festivals.length) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                
                                final festival = state.festivals[index];
                                return FestivalCardWidget(
                                  festival: festival,
                                  onTap: () {
                                    context.push(
                                      '/ktour/festival/${festival.contentId}',
                                    );
                                  },
                                  onBookmarkTap: () {
                                    controller.toggleBookmark(festival.contentId);
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
  
  /// 필터 시트 표시
  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const FestivalFilterWidget(),
    );
  }
  
  /// 지역 코드를 이름으로 변환
  String _getAreaName(String areaCode) {
    final areaNames = {
      '1': '서울',
      '2': '인천',
      '3': '대전',
      '4': '대구',
      '5': '광주',
      '6': '부산',
      '7': '울산',
      '8': '세종',
      '31': '경기',
      '32': '강원',
      '33': '충북',
      '34': '충남',
      '35': '경북',
      '36': '경남',
      '37': '전북',
      '38': '전남',
      '39': '제주',
    };
    return areaNames[areaCode] ?? '기타';
  }
}