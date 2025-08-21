import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/heritage.dart';

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

  // 더미 데이터
  late final Heritage _heritage = const Heritage(
    id: '1',
    kdcd: '13',  // 사적 코드
    ctcd: '11',  // 서울시 코드
    asno: '00117',  // 관리번호
    nameKo: '경복궁',
    nameEn: 'Gyeongbokgung Palace',
    category: '사적',
    cityName: '서울특별시',
    sigungu: '종로구',
    latitude: 37.5796,
    longitude: 126.9770,
    address: '서울특별시 종로구 사직로 161',
    period: '조선시대',
    designatedDate: null,  // DateTime 타입
    descriptionKo: '''경복궁은 조선왕조 제일의 법궁으로, 북으로 북악산을 기대어 자리 잡았습니다.

1395년 태조 이성계가 창건하였고, 1592년 임진왜란으로 불타 없어졌다가 고종 때인 1867년 중건되었습니다. 흥선대원군이 주도한 중건 공사는 경복궁을 다시 옛 모습으로 복원하는 대규모 사업이었습니다.

경복궁은 500년 조선왕조의 역사와 문화가 살아 숨 쉬는 곳으로, 근정전, 경회루, 향원정 등 아름다운 건축물들이 자리하고 있습니다.''',
    admin: '문화재청 경복궁관리소',
    images: [
      HeritageImage(
        id: '1',
        heritageId: '1',
        imageUrl: 'https://example.com/image1.jpg',
        description: '근정전 전경',
      ),
      HeritageImage(
        id: '2',
        heritageId: '1',
        imageUrl: 'https://example.com/image2.jpg',
        description: '경회루',
      ),
      HeritageImage(
        id: '3',
        heritageId: '1',
        imageUrl: 'https://example.com/image3.jpg',
        description: '향원정',
      ),
    ],
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
    // TODO: 공유 기능 구현
  }

  void _openNavigation() async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${_heritage.latitude},${_heritage.longitude}',
    );
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _playAudioGuide() {
    // TODO: 오디오 가이드 재생
  }

  @override
  Widget build(BuildContext context) {
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
                    itemCount: _heritage.images.isEmpty ? 1 : _heritage.images.length,
                    itemBuilder: (context, index) {
                      if (_heritage.images.isEmpty) {
                        return _buildPlaceholderImage();
                      }
                      
                      final image = _heritage.images[index];
                      return CachedNetworkImage(
                        imageUrl: image.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            _buildPlaceholderImage(),
                      );
                    },
                  ),
                  
                  // 페이지 인디케이터
                  if (_heritage.images.isNotEmpty)
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
                          '${_currentImageIndex + 1} / ${_heritage.images.length}',
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
                  _buildHeader(),
                  const SizedBox(height: 24),
                  
                  // 메타 정보
                  _buildMetaInfo(),
                  const SizedBox(height: 24),
                  
                  // 설명
                  _buildDescription(),
                  const SizedBox(height: 24),
                  
                  // 액션 버튼들
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                  
                  // 관련 정보
                  _buildRelatedInfo(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppColors.celadonGreen.withOpacity(0.3),
      child: Center(
        child: Icon(
          Icons.temple_buddhist,
          size: 64,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _heritage.nameKo,
          style: AppTypography.h2,
        ),
        if (_heritage.nameEn != null) ...[
          const SizedBox(height: 4),
          Text(
            _heritage.nameEn!,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.grayMedium,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMetaInfo() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        _MetaItem(
          icon: Icons.category_outlined,
          label: _heritage.category,
        ),
        if (_heritage.period != null)
          _MetaItem(
            icon: Icons.event_outlined,
            label: _heritage.period!,
          ),
        _MetaItem(
          icon: Icons.location_on_outlined,
          label: _heritage.address,
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '소개',
          style: AppTypography.h5,
        ),
        const SizedBox(height: 12),
        Text(
          _heritage.descriptionKo ?? '설명이 없습니다.',
          style: AppTypography.bodyMedium.copyWith(
            height: 1.8,
            color: AppColors.grayDark,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _openNavigation,
            icon: const Icon(Icons.directions),
            label: const Text('길찾기'),
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

  Widget _buildRelatedInfo() {
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
            '관람 정보',
            style: AppTypography.h6,
          ),
          const SizedBox(height: 12),
          _InfoRow(label: '관람 시간', value: '09:00 - 18:00'),
          _InfoRow(label: '입장료', value: '성인 3,000원'),
          _InfoRow(label: '휴관일', value: '매주 화요일'),
          _InfoRow(label: '문의', value: '02-3700-3900'),
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
          Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}