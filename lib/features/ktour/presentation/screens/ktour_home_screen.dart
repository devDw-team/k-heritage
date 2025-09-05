import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../application/ktour_controller.dart';
import '../../application/ktour_state.dart';
import '../../domain/entities/tour_attraction.dart';
import '../../domain/entities/tour_festival.dart';

/// K-TOUR 메인 화면
class KTourHomeScreen extends ConsumerStatefulWidget {
  const KTourHomeScreen({super.key});

  @override
  ConsumerState<KTourHomeScreen> createState() => _KTourHomeScreenState();
}

class _KTourHomeScreenState extends ConsumerState<KTourHomeScreen> {
  @override
  void initState() {
    super.initState();
    // 초기 데이터 로드는 Controller의 생성자에서 처리
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(ktourControllerProvider);
    final controller = ref.read(ktourControllerProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('K-TOUR'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 초기화 중 표시
              if (state.isInitializing)
                const LinearProgressIndicator(),
            // 헤더 배너
            Container(
              height: 180,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2196F3),  // 파란색 (여행, 바다)
                    Color(0xFF1976D2),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // 패턴 배경
                  Positioned(
                    right: -30,
                    bottom: -30,
                    child: Icon(
                      Icons.luggage,
                      size: 150,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  // 텍스트
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '한국 여행의 모든 것',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '관광지, 맛집, 숙박, 축제 정보를\n한 곳에서 만나보세요',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // 메뉴 그리드
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '여행 정보',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _buildMenuCard(
                        context: context,
                        icon: Icons.map,
                        title: '여행지 탐색',
                        subtitle: '지역별·테마별 관광지',
                        color: Colors.blue,
                        onTap: () {
                          context.push('/ktour/explore');
                        },
                      ),
                      _buildMenuCard(
                        context: context,
                        icon: Icons.route,
                        title: '여행 코스',
                        subtitle: '추천 코스·나만의 코스',
                        color: Colors.green,
                        onTap: () {
                          context.push('/ktour/course');
                        },
                      ),
                      _buildMenuCard(
                        context: context,
                        icon: Icons.festival,
                        title: '행사/축제',
                        subtitle: '지역별 축제·이벤트',
                        color: Colors.orange,
                        onTap: () {
                          context.push('/ktour/festival');
                        },
                      ),
                      _buildMenuCard(
                        context: context,
                        icon: Icons.info,
                        title: '여행 정보',
                        subtitle: '맛집·숙박·교통',
                        color: Colors.purple,
                        onTap: () {
                          // TODO: 여행 정보 화면으로 이동
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('여행 정보 기능 준비중')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 인기 여행지 섹션
            _buildPopularSection(context, state),
            
            const SizedBox(height: 24),
            
            // 진행중인 축제 섹션
            _buildFestivalSection(context, state),
            
            const SizedBox(height: 80), // 하단 네비게이션 공간
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMenuCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPopularSection(BuildContext context, KTourState state) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '인기 여행지',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/ktour/explore');
                },
                child: const Text('전체보기'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: state.isLoadingPopular
              ? const Center(child: CircularProgressIndicator())
              : state.popularError != null
                  ? Center(
                      child: Text(
                        state.popularError!,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    )
                  : state.popularAttractions.isEmpty
                      ? const Center(child: Text('인기 여행지가 없습니다'))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.popularAttractions.length,
                          itemBuilder: (context, index) {
                            final attraction = state.popularAttractions[index];
                            return _buildAttractionCard(context, attraction);
                          },
                        ),
        ),
      ],
    );
  }
  
  Widget _buildAttractionCard(BuildContext context, TourAttraction attraction) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () {
          // TODO: 상세 화면으로 이동
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${attraction.title} 선택됨')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: Colors.grey.shade300,
                ),
                child: attraction.hasImage
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: attraction.firstImage2 ?? attraction.firstImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
              ),
              // 정보
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        attraction.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        attraction.address1?.split(' ').take(2).join(' ') ?? '',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFestivalSection(BuildContext context, KTourState state) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '진행중인 축제',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/ktour/festival');
                },
                child: const Text('전체보기'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        state.isLoadingFestivals
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              )
            : state.festivalsError != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        state.festivalsError!,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                  )
                : state.ongoingFestivals.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('진행중인 축제가 없습니다'),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.ongoingFestivals.take(3).length,
                        itemBuilder: (context, index) {
                          final festival = state.ongoingFestivals[index];
                          return _buildFestivalCard(context, festival);
                        },
                      ),
      ],
    );
  }
  
  Widget _buildFestivalCard(BuildContext context, TourFestival festival) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.orange.shade100,
          ),
          child: festival.hasImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: festival.firstImage2 ?? festival.firstImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Icon(
                      Icons.festival,
                      color: Colors.orange.shade700,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.festival,
                      color: Colors.orange.shade700,
                    ),
                  ),
                )
              : Icon(
                  Icons.festival,
                  color: Colors.orange.shade700,
                ),
        ),
        title: Text(
          festival.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          festival.periodDisplay.isNotEmpty 
            ? festival.periodDisplay
            : festival.eventPlace ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (festival.dDayDisplay != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  festival.dDayDisplay!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        onTap: () {
          context.push('/ktour/festival/${festival.contentId}');
        },
      ),
    );
  }
}