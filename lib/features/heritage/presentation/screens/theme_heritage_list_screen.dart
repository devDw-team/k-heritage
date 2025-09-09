import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/theme_controller.dart';
import '../../infrastructure/data/theme_data.dart' as heritage_theme;
import '../widgets/heritage_card.dart';
import '../widgets/heritage_list_item.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';

/// 테마별 문화재 목록 화면
class ThemeHeritageListScreen extends ConsumerStatefulWidget {
  final String themeCode;
  
  const ThemeHeritageListScreen({
    super.key,
    required this.themeCode,
  });

  @override
  ConsumerState<ThemeHeritageListScreen> createState() => _ThemeHeritageListScreenState();
}

class _ThemeHeritageListScreenState extends ConsumerState<ThemeHeritageListScreen> {
  bool _isGridView = false;
  
  @override
  void initState() {
    super.initState();
    // 테마 선택 및 문화재 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(themeControllerProvider.notifier).selectTheme(widget.themeCode);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeControllerProvider);
    final theme = Theme.of(context);
    
    // 테마 정보 가져오기
    String? themeKey;
    for (final entry in heritage_theme.ThemeData.themeMapping.entries) {
      if (entry.value['code'] == widget.themeCode) {
        themeKey = entry.key;
        break;
      }
    }
    
    final themeInfo = themeKey != null 
        ? heritage_theme.ThemeData.themeMapping[themeKey]
        : null;
    
    final themeColor = themeInfo != null 
        ? Color(themeInfo['color'] as int)
        : AppColors.primary;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(themeState.selectedTheme?.nameKo ?? '테마 문화재'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              // TODO: 지도 보기 화면으로 이동
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('지도 보기 기능은 준비 중입니다')),
              );
            },
          ),
        ],
      ),
      body: themeState.isLoadingHeritages
          ? const Center(child: CircularProgressIndicator())
          : themeState.error != null
              ? _buildErrorWidget(themeState.error!)
              : themeState.themeHeritages.isEmpty
                  ? _buildEmptyWidget(themeInfo)
                  : _buildContent(themeState, themeInfo, themeColor),
    );
  }
  
  Widget _buildContent(ThemeState state, Map<String, dynamic>? themeInfo, Color themeColor) {
    return Column(
      children: [
        // 테마 정보 헤더
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                themeColor.withValues(alpha: 0.1),
                themeColor.withValues(alpha: 0.05),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: themeColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: themeColor.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  _getThemeIcon(themeInfo?['icon'] as String? ?? 'museum'),
                  color: themeColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.selectedTheme?.nameKo ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${state.themeHeritages.length}개 문화재',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // 문화재 목록
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await ref.read(themeControllerProvider.notifier).selectTheme(widget.themeCode);
            },
            child: _isGridView
                ? _buildGridView(state)
                : _buildListView(state),
          ),
        ),
      ],
    );
  }
  
  Widget _buildGridView(ThemeState state) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: state.themeHeritages.length,
      itemBuilder: (context, index) {
        final heritage = state.themeHeritages[index];
        return HeritageCard(
          heritage: heritage,
          onTap: () {
            context.push('/heritage/${heritage.id}');
          },
        );
      },
    );
  }
  
  Widget _buildListView(ThemeState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.themeHeritages.length,
      itemBuilder: (context, index) {
        final heritage = state.themeHeritages[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: HeritageListItem(
            heritage: heritage,
            onTap: () {
              context.push('/heritage/${heritage.id}');
            },
          ),
        );
      },
    );
  }
  
  Widget _buildErrorWidget(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              '문화재를 불러올 수 없습니다',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.read(themeControllerProvider.notifier).selectTheme(widget.themeCode);
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyWidget(Map<String, dynamic>? themeInfo) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getThemeIcon(themeInfo?['icon'] as String? ?? 'museum'),
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              '이 테마에 속하는 문화재가 없습니다',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              themeInfo?['description'] as String? ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  IconData _getThemeIcon(String iconName) {
    switch (iconName) {
      case 'palace':
        return Icons.account_balance;
      case 'public':
        return Icons.public;
      case 'holiday_village':
        return Icons.holiday_village;
      case 'temple_buddhist':
        return Icons.temple_buddhist;
      case 'castle':
        return Icons.castle;
      case 'theater_comedy':
        return Icons.theater_comedy;
      default:
        return Icons.museum;
    }
  }
}