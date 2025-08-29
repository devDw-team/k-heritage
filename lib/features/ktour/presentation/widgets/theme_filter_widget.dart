import 'package:flutter/material.dart';
import '../../infrastructure/datasources/tour_api_datasource.dart';

/// 테마별 필터 위젯
class ThemeFilterWidget extends StatelessWidget {
  final List<int> selectedThemes;
  final Function(List<int>) onThemesChanged;

  const ThemeFilterWidget({
    super.key,
    required this.selectedThemes,
    required this.onThemesChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 테마 목록
    final themes = [
      _ThemeItem(
        id: TourContentType.attraction,
        name: '관광지',
        icon: Icons.attractions,
        color: const Color(0xFF4CAF50),
      ),
      _ThemeItem(
        id: TourContentType.culturalFacility,
        name: '문화시설',
        icon: Icons.account_balance,
        color: const Color(0xFF9C27B0),
      ),
      _ThemeItem(
        id: TourContentType.festival,
        name: '축제/행사',
        icon: Icons.celebration,
        color: const Color(0xFFFF9800),
      ),
      _ThemeItem(
        id: TourContentType.tourCourse,
        name: '여행코스',
        icon: Icons.map,
        color: const Color(0xFF2196F3),
      ),
      _ThemeItem(
        id: TourContentType.leisure,
        name: '레포츠',
        icon: Icons.sports_soccer,
        color: const Color(0xFF009688),
      ),
      _ThemeItem(
        id: TourContentType.accommodation,
        name: '숙박',
        icon: Icons.bed,
        color: const Color(0xFF3F51B5),
      ),
      _ThemeItem(
        id: TourContentType.shopping,
        name: '쇼핑',
        icon: Icons.shopping_cart,
        color: const Color(0xFFE91E63),
      ),
      _ThemeItem(
        id: TourContentType.restaurant,
        name: '음식점',
        icon: Icons.restaurant_menu,
        color: const Color(0xFFF44336),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 전체 선택/해제
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '테마 선택',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (selectedThemes.isEmpty) {
                    // 전체 선택
                    onThemesChanged(themes.map((t) => t.id).toList());
                  } else {
                    // 전체 해제
                    onThemesChanged([]);
                  }
                },
                child: Text(
                  selectedThemes.isEmpty ? '전체 선택' : '선택 해제',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // 테마 그리드
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemCount: themes.length,
              itemBuilder: (context, index) {
                final themeItem = themes[index];
                final isSelected = selectedThemes.contains(themeItem.id);
                
                return GestureDetector(
                  onTap: () {
                    final newThemes = List<int>.from(selectedThemes);
                    if (isSelected) {
                      newThemes.remove(themeItem.id);
                    } else {
                      newThemes.add(themeItem.id);
                    }
                    onThemesChanged(newThemes);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? themeItem.color.withOpacity(0.15)
                          : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? themeItem.color
                            : theme.colorScheme.outline.withOpacity(0.3),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // 사용 가능한 공간에 맞춰 크기 조정
                        final availableHeight = constraints.maxHeight;
                        final availableWidth = constraints.maxWidth;
                        final iconSize = availableHeight > 80 ? 32.0 : availableHeight > 60 ? 26.0 : 22.0;
                        final fontSize = availableHeight > 80 ? 12.0 : availableHeight > 60 ? 11.0 : 10.0;
                        final spacing = availableHeight > 80 ? 6.0 : 4.0;
                        final padding = availableHeight > 80 ? 6.0 : 4.0;
                        
                        return Padding(
                          padding: EdgeInsets.all(padding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 아이콘 컨테이너
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: isSelected
                                          ? [
                                              themeItem.color.withOpacity(0.2),
                                              themeItem.color.withOpacity(0.1),
                                            ]
                                          : [
                                              theme.colorScheme.surfaceContainerHighest,
                                              theme.colorScheme.surface,
                                            ],
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? themeItem.color
                                          : theme.colorScheme.outline.withOpacity(0.2),
                                      width: isSelected ? 2.5 : 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: themeItem.color.withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      themeItem.icon,
                                      size: iconSize,
                                      color: isSelected
                                          ? themeItem.color
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: spacing),
                              // 텍스트 레이블
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  themeItem.name,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: isSelected
                                        ? themeItem.color
                                        : theme.colorScheme.onSurface,
                                    letterSpacing: -0.5,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 테마 아이템 모델
class _ThemeItem {
  final int id;
  final String name;
  final IconData icon;
  final Color color;

  const _ThemeItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}