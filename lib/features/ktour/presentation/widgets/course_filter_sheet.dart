import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/tour_course_controller.dart';

class CourseFilterSheet extends ConsumerStatefulWidget {
  const CourseFilterSheet({super.key});

  @override
  ConsumerState<CourseFilterSheet> createState() => _CourseFilterSheetState();
}

class _CourseFilterSheetState extends ConsumerState<CourseFilterSheet> {
  String? selectedAreaCode;
  String? selectedTheme;
  String? selectedDifficulty;
  RangeValues? durationRange;
  String sortBy = 'P';

  final Map<String, String> areas = {
    '1': '서울',
    '2': '인천',
    '3': '대전',
    '4': '대구',
    '5': '광주',
    '6': '부산',
    '7': '울산',
    '8': '세종',
    '31': '경기',
    '32': '강원',
    '33': '충북',
    '34': '충남',
    '35': '경북',
    '36': '경남',
    '37': '전북',
    '38': '전남',
    '39': '제주',
  };

  final List<String> themes = [
    '역사문화',
    '자연경관',
    '레저스포츠',
    '문화예술',
    '음식여행',
    '체험활동',
    '힐링휴식',
  ];

  final List<String> difficulties = ['쉬움', '보통', '어려움'];

  final Map<String, String> sortOptions = {
    'P': '인기순',
    'R': '최신순',
    'Q': '수정일순',
    'A': '제목순',
  };

  @override
  void initState() {
    super.initState();
    final state = ref.read(tourCourseControllerProvider);
    selectedAreaCode = state.selectedAreaCode;
    selectedTheme = state.selectedTheme;
    selectedDifficulty = state.selectedDifficulty;
    sortBy = state.sortBy;
    
    if (state.minDuration != null && state.maxDuration != null) {
      durationRange = RangeValues(
        state.minDuration!.toDouble(),
        state.maxDuration!.toDouble(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // 핸들 바
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // 헤더
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '필터 및 정렬',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _resetFilters,
                  child: const Text('초기화'),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // 필터 내용
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 정렬
                _buildSection(
                  title: '정렬',
                  child: Wrap(
                    spacing: 8,
                    children: sortOptions.entries.map((entry) {
                      final isSelected = sortBy == entry.key;
                      return ChoiceChip(
                        label: Text(
                          entry.value,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey[200],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              sortBy = entry.key;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 지역
                _buildSection(
                  title: '지역',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: areas.entries.map((entry) {
                      final isSelected = selectedAreaCode == entry.key;
                      return FilterChip(
                        label: Text(
                          entry.value,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey[200],
                        checkmarkColor: Colors.white,
                        onSelected: (selected) {
                          setState(() {
                            selectedAreaCode = selected ? entry.key : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 테마
                _buildSection(
                  title: '테마',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: themes.map((theme) {
                      final isSelected = selectedTheme == theme;
                      return FilterChip(
                        label: Text(
                          theme,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey[200],
                        checkmarkColor: Colors.white,
                        onSelected: (selected) {
                          setState(() {
                            selectedTheme = selected ? theme : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 난이도
                _buildSection(
                  title: '난이도',
                  child: Wrap(
                    spacing: 8,
                    children: difficulties.map((difficulty) {
                      final isSelected = selectedDifficulty == difficulty;
                      return FilterChip(
                        label: Text(
                          difficulty,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey[200],
                        checkmarkColor: Colors.white,
                        onSelected: (selected) {
                          setState(() {
                            selectedDifficulty = selected ? difficulty : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 소요시간
                _buildSection(
                  title: '소요시간',
                  child: Column(
                    children: [
                      if (durationRange != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${durationRange!.start.round()}분',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${durationRange!.end.round()}분',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        RangeSlider(
                          values: durationRange!,
                          min: 0,
                          max: 480,
                          divisions: 16,
                          labels: RangeLabels(
                            '${durationRange!.start.round()}분',
                            '${durationRange!.end.round()}분',
                          ),
                          onChanged: (values) {
                            setState(() {
                              durationRange = values;
                            });
                          },
                        ),
                      ] else ...[
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    durationRange = const RangeValues(0, 480);
                                  });
                                },
                                child: const Text('소요시간 설정'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // 하단 버튼
          Container(
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
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('취소'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('적용'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      selectedAreaCode = null;
      selectedTheme = null;
      selectedDifficulty = null;
      durationRange = null;
      sortBy = 'P';
    });
  }

  void _applyFilters() {
    final controller = ref.read(tourCourseControllerProvider.notifier);
    
    // 정렬 변경
    if (sortBy != ref.read(tourCourseControllerProvider).sortBy) {
      controller.changeSortBy(sortBy);
    }
    
    // 필터 적용
    controller.applyFilters(
      areaCode: selectedAreaCode,
      theme: selectedTheme,
      difficulty: selectedDifficulty,
      minDuration: durationRange?.start.round(),
      maxDuration: durationRange?.end.round(),
    );
    
    Navigator.pop(context);
  }
}