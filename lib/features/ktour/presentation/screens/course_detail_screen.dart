import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../application/tour_course_controller.dart';
import '../widgets/course_step_widget.dart';
import '../widgets/course_map_widget.dart';

class CourseDetailScreen extends ConsumerStatefulWidget {
  final String contentId;

  const CourseDetailScreen({
    super.key,
    required this.contentId,
  });

  @override
  ConsumerState<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends ConsumerState<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // 코스 상세 정보 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tourCourseControllerProvider.notifier)
          .loadCourseDetail(widget.contentId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tourCourseControllerProvider);
    final course = state.selectedCourse;

    if (state.isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (course == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                '코스 정보를 불러올 수 없습니다',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  ref.read(tourCourseControllerProvider.notifier)
                      .loadCourseDetail(widget.contentId);
                },
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 앱바 및 이미지
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                      Shadow(
                        blurRadius: 20,
                        color: Colors.black87,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // 이미지
                  course.firstimage != null
                      ? CachedNetworkImage(
                          imageUrl: course.firstimage!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 64,
                            ),
                          ),
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.route,
                            color: Colors.grey,
                            size: 64,
                          ),
                        ),
                  // 그라데이션 오버레이 (상단)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // 그라데이션 오버레이 (하단) - 제목 가시성 강화
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 120,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.3, 0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: Icon(
                    course.isBookmarked ?? false
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    ref.read(tourCourseControllerProvider.notifier)
                        .toggleBookmark(course.contentid);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: _shareCourse,
                ),
              ),
            ],
          ),

          // 기본 정보
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 코스 정보 태그
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (course.totalDistance != null)
                        _buildInfoChip(
                          icon: Icons.directions_walk,
                          label: '${course.totalDistance!.toStringAsFixed(1)}km',
                          color: Colors.blue,
                        ),
                      if (course.totalDuration != null)
                        _buildInfoChip(
                          icon: Icons.access_time,
                          label: _formatDuration(course.totalDuration!),
                          color: Colors.green,
                        ),
                      if (course.theme != null)
                        _buildInfoChip(
                          icon: Icons.category,
                          label: course.theme!,
                          color: Colors.purple,
                        ),
                      if (course.difficulty != null)
                        _buildInfoChip(
                          icon: Icons.trending_up,
                          label: course.difficulty!,
                          color: _getDifficultyColor(course.difficulty!),
                        ),
                      if (course.steps != null)
                        _buildInfoChip(
                          icon: Icons.flag,
                          label: '${course.steps!.length}개 지점',
                          color: Colors.orange,
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 주소
                  if (course.addr1 != null) ...[
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            course.addr1!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 설명
                  if (course.overview != null) ...[
                    Text(
                      '코스 소개',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedCrossFade(
                      firstChild: Text(
                        course.overview!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      secondChild: Text(
                        course.overview!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      crossFadeState: _isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 200),
                    ),
                    if (course.overview!.length > 100)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(_isExpanded ? '접기' : '더보기'),
                      ),
                  ],
                ],
              ),
            ),
          ),

          // 탭바
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(text: '코스 경로'),
                  Tab(text: '지도'),
                ],
              ),
            ),
          ),

          // 탭 내용
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 코스 경로 탭
                _buildCourseStepsTab(course),
                // 지도 탭
                _buildMapTab(course),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _launchNavigation(course),
                icon: const Icon(Icons.navigation),
                label: const Text('길찾기 시작'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _saveMyCourse(course),
                icon: const Icon(Icons.save_alt),
                label: const Text('내 코스 저장'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseStepsTab(course) {
    if (course.steps == null || course.steps!.isEmpty) {
      return Center(
        child: Text(
          '코스 단계 정보가 없습니다',
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: course.steps!.length,
      itemBuilder: (context, index) {
        final step = course.steps![index];
        final isLast = index == course.steps!.length - 1;
        
        return CourseStepWidget(
          step: step,
          stepNumber: index + 1,
          isLast: isLast,
          onTap: () {
            // TODO: 단계별 상세 정보 표시
          },
        );
      },
    );
  }

  Widget _buildMapTab(course) {
    if (course.mapx == null || course.mapy == null) {
      return Center(
        child: Text(
          '지도 정보가 없습니다',
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    return CourseMapWidget(
      course: course,
      onMarkerTap: (stepIndex) {
        // 해당 단계로 스크롤
        _tabController.animateTo(0);
      },
    );
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes분';
    } else {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      if (mins == 0) {
        return '$hours시간';
      } else {
        return '$hours시간 $mins분';
      }
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case '쉬움':
        return Colors.green;
      case '보통':
        return Colors.orange;
      case '어려움':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _shareCourse() {
    // TODO: 코스 공유 기능 구현
  }

  void _launchNavigation(course) async {
    if (course.mapx == null || course.mapy == null) return;

    final url = 'https://maps.google.com/?q=${course.mapy},${course.mapx}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _saveMyCourse(course) async {
    final result = await ref.read(tourCourseControllerProvider.notifier)
        .saveMyCourse(course);
    
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result 
            ? '내 코스에 저장되었습니다' 
            : '이미 저장된 코스입니다'),
        backgroundColor: result ? Colors.green : Colors.orange,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}