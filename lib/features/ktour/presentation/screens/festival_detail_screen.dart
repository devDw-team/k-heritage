import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../application/festival_controller.dart';
import '../../domain/entities/tour_festival.dart';
import '../widgets/festival_status_chip.dart';
import 'festival_map_screen.dart';

/// 축제 상세 화면
class FestivalDetailScreen extends ConsumerStatefulWidget {
  final String contentId;
  
  const FestivalDetailScreen({
    super.key,
    required this.contentId,
  });
  
  @override
  ConsumerState<FestivalDetailScreen> createState() => _FestivalDetailScreenState();
}

class _FestivalDetailScreenState extends ConsumerState<FestivalDetailScreen> {
  TourFestival? _festival;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadFestivalDetail();
  }
  
  Future<void> _loadFestivalDetail() async {
    setState(() => _isLoading = true);
    
    final controller = ref.read(festivalControllerProvider.notifier);
    final festival = await controller.getFestivalDetail(widget.contentId);
    
    if (mounted) {
      setState(() {
        _festival = festival;
        _isLoading = false;
      });
      
      // 디버그 로그
      if (festival != null) {
        print('Festival detail loaded: ${festival.title}');
        print('Overview: ${festival.overview}');
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = ref.read(festivalControllerProvider.notifier);
    final state = ref.watch(festivalControllerProvider);
    
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if (_festival == null) {
      // 상태에서 축제 찾기
      final festivals = state.festivals.where((f) => f.contentId == widget.contentId);
      if (festivals.isNotEmpty) {
        _festival = festivals.first;
      } else {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 16),
                const Text('축제 정보를 불러올 수 없습니다'),
              ],
            ),
          ),
        );
      }
    }
    
    final festival = _festival!;
    final isBookmarked = state.bookmarkedIds.contains(festival.contentId);
    
    // 디버깅용 로그
    print('Festival: ${festival.title}');
    print('MapX: ${festival.mapX}, MapY: ${festival.mapY}');
    print('HasValidCoordinates: ${festival.hasValidCoordinates}');
    print('EventPlace: ${festival.eventPlace}');
    print('FullAddress: ${festival.fullAddress}');
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 앱바 및 이미지
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.toggleBookmark(festival.contentId);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () => _shareFestival(festival),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  festival.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 4.0,
                        color: Colors.black87,
                      ),
                      Shadow(
                        offset: Offset(-1, -1),
                        blurRadius: 4.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // 이미지
                  festival.hasImage
                      ? CachedNetworkImage(
                          imageUrl: festival.firstImage!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: Icon(
                              Icons.festival,
                              size: 80,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      : Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.festival,
                            size: 80,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                  // 그라데이션 오버레이 (하단)
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
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // 그라데이션 오버레이 (상단)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 컨텐츠
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상태 및 D-Day
                  Row(
                    children: [
                      FestivalStatusChip(status: festival.status),
                      const SizedBox(width: 8),
                      if (festival.dDayDisplay != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            festival.dDayDisplay!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 기간
                  _buildInfoSection(
                    icon: Icons.calendar_today,
                    title: '행사 기간',
                    content: festival.periodDisplay.isNotEmpty
                        ? festival.periodDisplay
                        : '날짜 정보 없음',
                  ),
                  
                  // 장소
                  if (festival.eventPlace != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.location_on,
                      title: '행사 장소',
                      content: festival.eventPlace!,
                    ),
                  ],
                  
                  // 주소
                  if (festival.fullAddress.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.pin_drop,
                      title: '주소',
                      content: festival.fullAddress,
                    ),
                  ],
                  
                  // 지도 및 길찾기 버튼
                  if (festival.hasValidCoordinates || festival.fullAddress.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (festival.hasValidCoordinates)
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.map),
                              label: const Text('지도에서 보기'),
                              onPressed: () => _navigateToMap(festival),
                            ),
                          ),
                        if (festival.hasValidCoordinates && festival.fullAddress.isNotEmpty)
                          const SizedBox(width: 12),
                        if (festival.fullAddress.isNotEmpty)
                          Expanded(
                            child: FilledButton.icon(
                              icon: const Icon(Icons.directions),
                              label: const Text('길찾기'),
                              onPressed: () => _openNavigation(festival),
                            ),
                          ),
                      ],
                    ),
                  ],
                  
                  // 이용요금
                  if (festival.useFee != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.payment,
                      title: '이용요금',
                      content: festival.useFee!,
                    ),
                  ],
                  
                  // 주최/주관
                  if (festival.sponsor1 != null || festival.sponsor2 != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.business,
                      title: '주최/주관',
                      content: [
                        if (festival.sponsor1 != null) '주최: ${festival.sponsor1}',
                        if (festival.sponsor2 != null) '주관: ${festival.sponsor2}',
                      ].join('\n'),
                    ),
                  ],
                  
                  // 연락처
                  if (festival.tel != null || 
                      festival.sponsor1Tel != null || 
                      festival.sponsor2Tel != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.phone,
                      title: '연락처',
                      content: [
                        if (festival.tel != null) festival.tel!,
                        if (festival.sponsor1Tel != null) '주최: ${festival.sponsor1Tel}',
                        if (festival.sponsor2Tel != null) '주관: ${festival.sponsor2Tel}',
                      ].join('\n'),
                      trailing: festival.tel != null
                          ? IconButton(
                              icon: const Icon(Icons.call),
                              onPressed: () => _makePhoneCall(festival.tel!),
                            )
                          : null,
                    ),
                  ],
                  
                  // 홈페이지
                  if (festival.homepage != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.language,
                      title: '홈페이지',
                      content: '홈페이지 바로가기',
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => _openWebsite(festival.homepage!),
                      ),
                    ),
                  ],
                  
                  // 개요 (상세 설명)
                  if (festival.overview != null && festival.overview!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.description,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '행사 소개',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            festival.overview!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
  
  void _shareFestival(TourFestival festival) {
    final text = '''
${festival.title}

📅 ${festival.periodDisplay}
📍 ${festival.eventPlace ?? festival.fullAddress}
${festival.dDayDisplay != null ? '⏰ ${festival.dDayDisplay}' : ''}

${festival.overview ?? ''}
''';
    
    Share.share(text, subject: festival.title);
  }
  
  void _navigateToMap(TourFestival festival) {
    if (!festival.hasValidCoordinates) return;
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FestivalMapScreen(festival: festival),
      ),
    );
  }
  
  Future<void> _openNavigation(TourFestival festival) async {
    if (!festival.hasValidCoordinates) {
      // 주소로 검색
      final query = Uri.encodeComponent(festival.fullAddress);
      final url = Uri.parse('https://map.kakao.com/?q=$query');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } else {
      // 좌표로 네비게이션
      final url = Uri.parse(
        'kakaomap://look?p=${festival.mapY},${festival.mapX}',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // 카카오맵 앱이 없으면 웹으로
        final webUrl = Uri.parse(
          'https://map.kakao.com/link/map/${Uri.encodeComponent(festival.title)},${festival.mapY},${festival.mapX}',
        );
        if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        }
      }
    }
  }
  
  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
  
  Future<void> _openWebsite(String homepage) async {
    // HTML 태그 제거
    final cleanUrl = homepage.replaceAll(RegExp(r'<[^>]*>'), '').trim();
    final url = Uri.tryParse(cleanUrl);
    
    if (url != null && await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}