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
        icon: Icons.landscape,
        color: Colors.green,
      ),
      _ThemeItem(
        id: TourContentType.culturalFacility,
        name: '문화시설',
        icon: Icons.museum,
        color: Colors.purple,
      ),
      _ThemeItem(
        id: TourContentType.festival,
        name: '축제/행사',
        icon: Icons.festival,
        color: Colors.orange,
      ),
      _ThemeItem(
        id: TourContentType.tourCourse,
        name: '여행코스',
        icon: Icons.route,
        color: Colors.blue,
      ),
      _ThemeItem(
        id: TourContentType.leisure,
        name: '레포츠',
        icon: Icons.sports_tennis,
        color: Colors.teal,
      ),
      _ThemeItem(
        id: TourContentType.accommodation,
        name: '숙박',
        icon: Icons.hotel,
        color: Colors.indigo,
      ),
      _ThemeItem(
        id: TourContentType.shopping,
        name: '쇼핑',
        icon: Icons.shopping_bag,
        color: Colors.pink,
      ),
      _ThemeItem(
        id: TourContentType.restaurant,
        name: '음식점',
        icon: Icons.restaurant,
        color: Colors.red,
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
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
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? themeItem.color.withOpacity(0.2)
                                    : theme.colorScheme.surfaceVariant,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                themeItem.icon,
                                size: 20,
                                color: isSelected
                                    ? themeItem.color
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                themeItem.name,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  color: isSelected
                                      ? themeItem.color
                                      : theme.colorScheme.onSurface,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
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