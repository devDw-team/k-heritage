import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/tour_course_controller.dart';
import '../../application/tour_course_state.dart';
import '../widgets/course_card_widget.dart';
import '../widgets/course_filter_sheet.dart';

class TourCourseScreen extends ConsumerStatefulWidget {
  const TourCourseScreen({super.key});

  @override
  ConsumerState<TourCourseScreen> createState() => _TourCourseScreenState();
}

class _TourCourseScreenState extends ConsumerState<TourCourseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_onScroll);
    
    // 탭 변경 리스너 추가
    _tabController.addListener(() {
      if (_tabController.index == 3 && !_tabController.indexIsChanging) {
        // 나만의 코스 탭으로 전환 시 최신 데이터 로드
        ref.read(tourCourseControllerProvider.notifier).loadMyCourses();
      }
    });
    
    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tourCourseControllerProvider.notifier).loadCourses();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(tourCourseControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tourCourseControllerProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '여행코스',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: '추천 코스'),
            Tab(text: '테마별'),
            Tab(text: '지역별'),
            Tab(text: '나만의 코스'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black87),
            onPressed: () => _showFilterSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              // TODO: 검색 화면으로 이동
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecommendedTab(state),
          _buildThemeTab(state),
          _buildAreaTab(state),
          _buildMyCoursesTab(state),
        ],
      ),
      floatingActionButton: _tabController.index == 3
          ? FloatingActionButton.extended(
              heroTag: 'tour_course_create',
              onPressed: () {
                context.push('/ktour/course/create');
              },
              icon: const Icon(Icons.add),
              label: const Text('코스 만들기'),
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null,
    );
  }

  Widget _buildRecommendedTab(TourCourseState state) {
    if (state.isLoading && state.recommendedCourses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.recommendedCourses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              '코스를 불러올 수 없습니다',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                ref.read(tourCourseControllerProvider.notifier)
                    .loadRecommendedCourses();
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(tourCourseControllerProvider.notifier)
            .loadRecommendedCourses();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.recommendedCourses.length,
        itemBuilder: (context, index) {
          final course = state.recommendedCourses[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CourseCardWidget(
              course: course,
              onTap: () {
                context.push('/ktour/course/${course.contentid}');
              },
              onBookmarkTap: () {
                ref.read(tourCourseControllerProvider.notifier)
                    .toggleBookmark(course.contentid);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildThemeTab(TourCourseState state) {
    final themes = [
      {'name': '역사문화', 'icon': Icons.museum},
      {'name': '자연경관', 'icon': Icons.park},
      {'name': '레저스포츠', 'icon': Icons.sports_tennis},
      {'name': '문화예술', 'icon': Icons.palette},
      {'name': '음식여행', 'icon': Icons.restaurant},
      {'name': '체험활동', 'icon': Icons.touch_app},
      {'name': '힐링휴식', 'icon': Icons.spa},
    ];
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.category, size: 20, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(
                    '테마 선택',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  if (state.selectedTheme != null)
                    TextButton(
                      onPressed: () {
                        ref.read(tourCourseControllerProvider.notifier)
                            .applyFilters(theme: null);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        '초기화',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: themes.map((themeData) {
                  final theme = themeData['name'] as String;
                  final icon = themeData['icon'] as IconData;
                  final isSelected = state.selectedTheme == theme;
                  
                  return InkWell(
                    onTap: () {
                      ref.read(tourCourseControllerProvider.notifier)
                          .applyFilters(theme: isSelected ? null : theme);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300]!,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 16,
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            theme,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildCourseList(state),
        ),
      ],
    );
  }

  Widget _buildAreaTab(TourCourseState state) {
    final areas = [
      {'code': '1', 'name': '서울', 'icon': Icons.location_city},
      {'code': '6', 'name': '부산', 'icon': Icons.beach_access},
      {'code': '2', 'name': '인천', 'icon': Icons.flight},
      {'code': '39', 'name': '제주', 'icon': Icons.water},
      {'code': '31', 'name': '경기', 'icon': Icons.apartment},
      {'code': '32', 'name': '강원', 'icon': Icons.terrain},
      {'code': '36', 'name': '경남', 'icon': Icons.sailing},
      {'code': '35', 'name': '경북', 'icon': Icons.temple_buddhist},
      {'code': '38', 'name': '전남', 'icon': Icons.agriculture},
      {'code': '37', 'name': '전북', 'icon': Icons.rice_bowl},
      {'code': '33', 'name': '충북', 'icon': Icons.forest},
      {'code': '34', 'name': '충남', 'icon': Icons.castle},
      {'code': '3', 'name': '대전', 'icon': Icons.science},
      {'code': '4', 'name': '대구', 'icon': Icons.local_florist},
      {'code': '5', 'name': '광주', 'icon': Icons.wb_sunny},
      {'code': '7', 'name': '울산', 'icon': Icons.factory},
      {'code': '8', 'name': '세종', 'icon': Icons.account_balance},
    ];
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.map, size: 20, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(
                    '지역 선택',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  if (state.selectedAreaCode != null)
                    TextButton(
                      onPressed: () {
                        ref.read(tourCourseControllerProvider.notifier)
                            .applyFilters(areaCode: null);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        '초기화',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: areas.map((areaData) {
                  final areaCode = areaData['code'] as String;
                  final areaName = areaData['name'] as String;
                  final icon = areaData['icon'] as IconData;
                  final isSelected = state.selectedAreaCode == areaCode;
                  
                  return InkWell(
                    onTap: () {
                      ref.read(tourCourseControllerProvider.notifier)
                          .applyFilters(areaCode: isSelected ? null : areaCode);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300]!,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 14,
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            areaName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildCourseList(state),
        ),
      ],
    );
  }

  Widget _buildMyCoursesTab(TourCourseState state) {
    if (state.myCourses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.route, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              '저장된 코스가 없습니다',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '나만의 여행 코스를 만들어보세요',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.myCourses.length,
      itemBuilder: (context, index) {
        final course = state.myCourses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CourseCardWidget(
            course: course,
            onTap: () {
              context.push('/ktour/course/${course.contentid}');
            },
            onBookmarkTap: () {
              ref.read(tourCourseControllerProvider.notifier)
                  .toggleBookmark(course.contentid);
            },
          ),
        );
      },
    );
  }

  Widget _buildCourseList(TourCourseState state) {
    if (state.isLoading && state.filteredCourses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.filteredCourses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              '코스를 불러올 수 없습니다',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                ref.read(tourCourseControllerProvider.notifier)
                    .loadCourses(refresh: true);
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (state.filteredCourses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              '조건에 맞는 코스가 없습니다',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(tourCourseControllerProvider.notifier)
            .loadCourses(refresh: true);
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: state.filteredCourses.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.filteredCourses.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final course = state.filteredCourses[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CourseCardWidget(
              course: course,
              onTap: () {
                context.push('/ktour/course/${course.contentid}');
              },
              onBookmarkTap: () {
                ref.read(tourCourseControllerProvider.notifier)
                    .toggleBookmark(course.contentid);
              },
            ),
          );
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CourseFilterSheet(),
    );
  }
}