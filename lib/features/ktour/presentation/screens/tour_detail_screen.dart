import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/logger.dart';
import '../../application/bookmark_controller.dart';
import '../../infrastructure/repositories/ktour_repository_impl.dart';
import '../../domain/entities/tour_attraction.dart';
import '../../domain/entities/bookmark_item.dart';
import 'tour_map_screen.dart';

/// 여행지 상세 화면
class TourDetailScreen extends ConsumerStatefulWidget {
  final String contentId;
  final int? contentTypeId;
  
  const TourDetailScreen({
    super.key,
    required this.contentId,
    this.contentTypeId,
  });
  
  @override
  ConsumerState<TourDetailScreen> createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends ConsumerState<TourDetailScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;
  TourAttraction? _attraction;
  bool _isLoading = true;
  String? _error;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadAttractionDetail();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  Future<void> _loadAttractionDetail() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      // contentTypeId 검증 및 로그
      final effectiveContentTypeId = (widget.contentTypeId != null && widget.contentTypeId! > 0) 
          ? widget.contentTypeId 
          : null;
      
      Log.d('Loading detail for contentId: ${widget.contentId}, contentTypeId: ${widget.contentTypeId}, effective: $effectiveContentTypeId');
      
      final repositoryAsync = await ref.read(ktourRepositoryProvider.future);
      
      final attraction = await repositoryAsync.getAttractionDetail(
        contentId: widget.contentId,
        contentTypeId: effectiveContentTypeId,
      );
      
      if (attraction != null) {
        Log.d('Attraction detail loaded successfully');
        setState(() {
          _attraction = attraction;
          _isBookmarked = attraction.isBookmarked == true;
          _isLoading = false;
        });
      } else {
        Log.w('No attraction data found for contentId: ${widget.contentId}');
        setState(() {
          _error = '관광지 정보를 찾을 수 없습니다.\ncontentId: ${widget.contentId}';
          _isLoading = false;
        });
      }
    } catch (e) {
      Log.e('Failed to load attraction detail for ${widget.contentId}', error: e);
      
      String errorMessage = '정보를 불러오는 중 오류가 발생했습니다.';
      if (e.toString().contains('FORMAT_ERROR')) {
        errorMessage = 'API 응답 형식 오류가 발생했습니다.\n서비스 키를 확인해주세요.';
      } else if (e.toString().contains('AUTH_ERROR')) {
        errorMessage = '서비스 키 인증 오류가 발생했습니다.';
      } else if (e.toString().contains('SERVICE_KEY')) {
        errorMessage = '서비스 키가 등록되지 않았습니다.';
      }
      
      setState(() {
        _error = '$errorMessage\n\n상세: ${e.toString()}';
        _isLoading = false;
      });
    }
  }
  
  Future<void> _toggleBookmark() async {
    if (_attraction == null) return;
    
    try {
      final repositoryAsync = await ref.read(ktourRepositoryProvider.future);
      final bookmarkController = ref.read(bookmarkControllerProvider.notifier);
      final newBookmarkStatus = !_isBookmarked;
      
      if (newBookmarkStatus) {
        // 북마크 추가 - 상세 정보와 함께 저장
        final bookmarkItem = BookmarkItem(
          contentId: _attraction!.contentId,
          contentTypeId: _attraction!.contentTypeId,
          title: _attraction!.title,
          address1: _attraction!.address1,
          address2: _attraction!.address2,
          mapX: _attraction!.mapX,
          mapY: _attraction!.mapY,
          firstImage: _attraction!.firstImage,
          firstImage2: _attraction!.firstImage2,
          tel: _attraction!.tel,
          overview: _attraction!.overview,
          bookmarkedAt: DateTime.now(),
          bookmarkType: 'attraction',
        );
        
        await repositoryAsync.saveBookmarkWithDetails(
          bookmarkItem: bookmarkItem,
        );
      } else {
        // 북마크 제거
        await repositoryAsync.removeBookmark(
          contentId: widget.contentId,
        );
      }
      
      // 북마크 목록 새로고침
      await bookmarkController.loadBookmarks();
      
      setState(() {
        _isBookmarked = newBookmarkStatus;
      });
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(newBookmarkStatus ? '북마크에 추가되었습니다' : '북마크에서 제거되었습니다'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      Log.e('Failed to toggle bookmark', error: e);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('북마크 설정 중 오류가 발생했습니다'),
        ),
      );
    }
  }
  
  Future<void> _openMap() async {
    if (_attraction == null) return;
    
    // 앱 내부 지도 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TourMapScreen(
          attraction: _attraction!,
        ),
      ),
    );
  }
  
  Future<void> _share() async {
    // 공유 기능은 나중에 구현
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('공유 기능은 준비중입니다')),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    
    if (_error != null || _attraction == null) {
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
              Text(
                _error ?? '정보를 불러올 수 없습니다',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _loadAttractionDetail,
                icon: const Icon(Icons.refresh),
                label: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 이미지 앱바
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            leading: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _attraction!.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: _attraction!.firstImage != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: _attraction!.firstImage!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: theme.colorScheme.surfaceVariant,
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: theme.colorScheme.surfaceVariant,
                            child: const Icon(Icons.broken_image, size: 64),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      color: theme.colorScheme.primary,
                      child: const Icon(
                        Icons.landscape,
                        size: 64,
                        color: Colors.white54,
                      ),
                    ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                  onPressed: _toggleBookmark,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: _share,
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
                  // 주소
                  if (_attraction!.address1 != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${_attraction!.address1} ${_attraction!.address2 ?? ''}'.trim(),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  
                  // 전화번호
                  if (_attraction!.tel != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final url = 'tel:${_attraction!.tel}';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              }
                            },
                            child: Text(
                              _attraction!.tel!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  
                  // 홈페이지
                  if (_attraction!.homepage != null && _attraction!.homepage!.isNotEmpty) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              // Extract URL from HTML if needed
                              final url = _extractUrl(_attraction!.homepage!);
                              if (url != null && await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                              }
                            },
                            child: Text(
                              '홈페이지 방문',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  
                  // 거리 정보
                  if (_attraction!.distance != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.straighten,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _attraction!.distance! < 1000
                              ? '${_attraction!.distance!.toStringAsFixed(0)}m'
                              : '${(_attraction!.distance! / 1000).toStringAsFixed(1)}km',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ),
          
          // 탭바
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: '소개'),
                  Tab(text: '상세정보'),
                  Tab(text: '이용안내'),
                ],
              ),
              theme,
            ),
          ),
          
          // 탭 내용
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 소개 탭
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _attraction!.overview ?? '소개 정보가 없습니다.',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                
                // 상세정보 탭
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_attraction!.cat3 != null)
                        _buildInfoRow('분류', _attraction!.cat3!),
                      if (_attraction!.createdTime != null)
                        _buildInfoRow('등록일', _attraction!.createdTime!),
                      if (_attraction!.modifiedTime != null)
                        _buildInfoRow('수정일', _attraction!.modifiedTime!),
                      if (_attraction!.zipCode != null)
                        _buildInfoRow('우편번호', _attraction!.zipCode!),
                    ],
                  ),
                ),
                
                // 이용안내 탭
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '이용 안내',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '자세한 이용 안내는 관광지 홈페이지나 전화 문의를 통해 확인해주세요.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
      // 하단 버튼
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _openMap,
                  icon: const Icon(Icons.directions),
                  label: const Text('길찾기'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    if (_attraction!.tel != null) {
                      final url = 'tel:${_attraction!.tel}';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    }
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('전화하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
  
  String? _extractUrl(String homepage) {
    // Try to extract URL from HTML anchor tag
    final regex = RegExp(r'href="([^"]+)"');
    final match = regex.firstMatch(homepage);
    if (match != null) {
      return match.group(1);
    }
    // If no HTML, assume it's a plain URL
    if (homepage.startsWith('http')) {
      return homepage;
    }
    return null;
  }
}

/// 탭바 Delegate
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final ThemeData theme;
  
  _TabBarDelegate(this.tabBar, this.theme);
  
  @override
  double get minExtent => tabBar.preferredSize.height;
  
  @override
  double get maxExtent => tabBar.preferredSize.height;
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: theme.colorScheme.surface,
      child: tabBar,
    );
  }
  
  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return false;
  }
}