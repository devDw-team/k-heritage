import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/heritage.dart';
import '../../application/heritage_controller.dart';
import '../../../../core/utils/logger.dart';
import 'heritage_map_screen.dart';

/// 문화재 상세 화면
class HeritageDetailScreen extends ConsumerStatefulWidget {
  final String heritageId;

  const HeritageDetailScreen({
    super.key,
    required this.heritageId,
  });

  @override
  ConsumerState<HeritageDetailScreen> createState() =>
      _HeritageDetailScreenState();
}

class _HeritageDetailScreenState extends ConsumerState<HeritageDetailScreen> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  bool _isBookmarked = false;
  bool _isLoadingDetail = false;

  @override
  void initState() {
    super.initState();
    // Delay the provider modification to avoid modifying during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHeritageDetail();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadHeritageDetail() async {
    if (!mounted) return;
    
    setState(() {
      _isLoadingDetail = true;
    });

    try {
      // Load detailed heritage data
      await ref.read(heritageControllerProvider.notifier).selectHeritage(widget.heritageId);
    } catch (e) {
      Log.e('Failed to load heritage detail', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('문화재 정보를 불러오는데 실패했습니다: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingDetail = false;
        });
      }
    }
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    
    final message = _isBookmarked ? '북마크에 추가되었습니다' : '북마크가 해제되었습니다';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _share() {
    final heritage = ref.read(heritageControllerProvider).selectedHeritage;
    if (heritage != null) {
      // TODO: Implement share functionality
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('공유 기능은 준비 중입니다')),
      );
    }
  }

  void _openNavigation() {
    final heritage = ref.read(heritageControllerProvider).selectedHeritage;
    if (heritage != null) {
      // Navigate to map screen to show this heritage location
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HeritageMapScreen(heritage: heritage),
        ),
      );
    }
  }

  void _playAudioGuide() {
    final heritage = ref.read(heritageControllerProvider).selectedHeritage;
    if (heritage == null) return;

    // Find Korean narration
    final hasNarration = heritage.narrations.isNotEmpty;
    
    if (!hasNarration) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('오디오 가이드가 준비되지 않았습니다')),
      );
      return;
    }

    // For now, just show that narration is available
    // Audio playback can be implemented later with proper initialization
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('오디오 가이드 기능은 준비 중입니다')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heritageState = ref.watch(heritageControllerProvider);
    final heritage = heritageState.selectedHeritage;

    if (_isLoadingDetail || heritage == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 이미지 리스트 준비 (메인 이미지를 첫 번째로)
    final List<String> allImageUrls = [];
    if (heritage.mainImageUrl != null && heritage.mainImageUrl!.isNotEmpty) {
      allImageUrls.add(heritage.mainImageUrl!);
    }
    for (final image in heritage.images) {
      // 메인 이미지와 중복되지 않는 이미지만 추가
      if (image.imageUrl != heritage.mainImageUrl) {
        allImageUrls.add(image.imageUrl);
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 이미지 캐러셀이 있는 앱바
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: _share,
              ),
              IconButton(
                icon: Icon(
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
                onPressed: _toggleBookmark,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // 이미지 페이지뷰
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: allImageUrls.isEmpty ? 1 : allImageUrls.length,
                    itemBuilder: (context, index) {
                      if (allImageUrls.isEmpty) {
                        return _buildPlaceholderImage(heritage.nameKo);
                      }
                      
                      final imageUrl = allImageUrls[index];
                      return CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            _buildPlaceholderImage(heritage.nameKo),
                      );
                    },
                  ),
                  
                  // 페이지 인디케이터
                  if (allImageUrls.length > 1)
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusFull),
                        ),
                        child: Text(
                          '${_currentImageIndex + 1} / ${allImageUrls.length}',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // 상세 정보
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목 및 카테고리
                  _buildHeader(heritage),
                  const SizedBox(height: 24),
                  
                  // 메타 정보
                  _buildMetaInfo(heritage),
                  const SizedBox(height: 24),
                  
                  // 설명
                  _buildDescription(heritage),
                  const SizedBox(height: 24),
                  
                  // 액션 버튼들
                  _buildActionButtons(heritage),
                  const SizedBox(height: 24),
                  
                  // 관련 정보
                  _buildRelatedInfo(heritage),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(String name) {
    return Container(
      color: AppColors.celadonGreen.withOpacity(0.3),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.temple_buddhist,
              size: 64,
              color: Colors.white.withOpacity(0.7),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Heritage heritage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heritage.nameKo,
          style: AppTypography.h2,
        ),
        if (heritage.nameEn != null) ...[
          const SizedBox(height: 4),
          Text(
            heritage.nameEn!,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.grayMedium,
            ),
          ),
        ],
        if (heritage.nameHanja != null) ...[
          const SizedBox(height: 2),
          Text(
            heritage.nameHanja!,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.grayMedium,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMetaInfo(Heritage heritage) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        _MetaItem(
          icon: Icons.category_outlined,
          label: heritage.category,
        ),
        if (heritage.period != null)
          _MetaItem(
            icon: Icons.event_outlined,
            label: heritage.period!,
          ),
        _MetaItem(
          icon: Icons.location_on_outlined,
          label: heritage.address,
        ),
        if (heritage.designatedDate != null)
          _MetaItem(
            icon: Icons.calendar_today_outlined,
            label: '${heritage.designatedDate!.year}년 지정',
          ),
      ],
    );
  }

  Widget _buildDescription(Heritage heritage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '소개',
          style: AppTypography.h5,
        ),
        const SizedBox(height: 12),
        Text(
          heritage.descriptionKo ?? '설명이 없습니다.',
          style: AppTypography.bodyMedium.copyWith(
            height: 1.8,
            color: AppColors.grayDark,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Heritage heritage) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _openNavigation,
            icon: const Icon(Icons.map),
            label: const Text('지도에서 보기'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _playAudioGuide,
            icon: const Icon(Icons.volume_up),
            label: const Text('오디오 가이드'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedInfo(Heritage heritage) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.hanjiBeige,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '상세 정보',
            style: AppTypography.h6,
          ),
          const SizedBox(height: 12),
          if (heritage.cityName != null)
            _InfoRow(label: '지역', value: '${heritage.cityName} ${heritage.sigungu ?? ''}'),
          if (heritage.admin != null)
            _InfoRow(label: '관리처', value: heritage.admin!),
          if (heritage.distanceKm != null)
            _InfoRow(label: '거리', value: '${heritage.distanceKm!.toStringAsFixed(1)}km'),
          _InfoRow(label: '좌표', value: '${heritage.latitude.toStringAsFixed(4)}, ${heritage.longitude.toStringAsFixed(4)}'),
        ],
      ),
    );
  }
}

/// 메타 정보 아이템
class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.grayMedium,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.grayDark,
          ),
        ),
      ],
    );
  }
}

/// 정보 행
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.grayMedium,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}