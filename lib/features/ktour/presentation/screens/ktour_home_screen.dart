import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// K-TOUR 메인 화면
class KTourHomeScreen extends ConsumerWidget {
  const KTourHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('K-TOUR'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          // TODO: 여행지 탐색 화면으로 이동
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('여행지 탐색 기능 준비중')),
                          );
                        },
                      ),
                      _buildMenuCard(
                        context: context,
                        icon: Icons.route,
                        title: '여행 코스',
                        subtitle: '추천 코스·나만의 코스',
                        color: Colors.green,
                        onTap: () {
                          // TODO: 여행 코스 화면으로 이동
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('여행 코스 기능 준비중')),
                          );
                        },
                      ),
                      _buildMenuCard(
                        context: context,
                        icon: Icons.festival,
                        title: '행사/축제',
                        subtitle: '지역별 축제·이벤트',
                        color: Colors.orange,
                        onTap: () {
                          // TODO: 행사/축제 화면으로 이동
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('행사/축제 기능 준비중')),
                          );
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
            _buildPopularSection(context),
            
            const SizedBox(height: 24),
            
            // 진행중인 축제 섹션
            _buildFestivalSection(context),
            
            const SizedBox(height: 80), // 하단 네비게이션 공간
          ],
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
  
  Widget _buildPopularSection(BuildContext context) {
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
                  // TODO: 전체보기
                },
                child: const Text('전체보기'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        color: Colors.grey.shade300,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '여행지 ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '서울특별시',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildFestivalSection(BuildContext context) {
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
                  // TODO: 전체보기
                },
                child: const Text('전체보기'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          itemBuilder: (context, index) {
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
                  child: Icon(
                    Icons.festival,
                    color: Colors.orange.shade700,
                  ),
                ),
                title: Text('축제 ${index + 1}'),
                subtitle: const Text('2025.01.01 ~ 2025.01.31'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: 축제 상세
                },
              ),
            );
          },
        ),
      ],
    );
  }
}