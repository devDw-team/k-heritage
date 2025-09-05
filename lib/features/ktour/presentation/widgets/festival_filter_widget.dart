import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../application/festival_controller.dart';

/// 축제 필터 위젯
class FestivalFilterWidget extends ConsumerStatefulWidget {
  const FestivalFilterWidget({super.key});

  @override
  ConsumerState<FestivalFilterWidget> createState() => _FestivalFilterWidgetState();
}

class _FestivalFilterWidgetState extends ConsumerState<FestivalFilterWidget> {
  String? _selectedAreaCode;
  String? _selectedSigunguCode;
  DateTime? _selectedMonth;
  String _selectedSortBy = 'R';
  
  // 지역 코드 목록
  final Map<String, String> _areaCodes = {
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
  
  @override
  void initState() {
    super.initState();
    final state = ref.read(festivalControllerProvider);
    _selectedAreaCode = state.filterAreaCode;
    _selectedSigunguCode = state.filterSigunguCode;
    _selectedMonth = state.filterMonth;
    _selectedSortBy = state.sortBy;
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = ref.read(festivalControllerProvider.notifier);
    
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
              // 핸들
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // 헤더
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '필터',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedAreaCode = null;
                          _selectedSigunguCode = null;
                          _selectedMonth = null;
                          _selectedSortBy = 'R';
                        });
                      },
                      child: const Text('초기화'),
                    ),
                  ],
                ),
              ),
              
              const Divider(height: 1),
              
              // 필터 옵션
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // 지역 선택
                    _buildSection(
                      title: '지역',
                      icon: Icons.location_on,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _areaCodes.entries.map((entry) {
                          final isSelected = _selectedAreaCode == entry.key;
                          return FilterChip(
                            label: Text(
                              entry.value,
                              style: TextStyle(
                                color: isSelected 
                                  ? theme.colorScheme.onPrimary 
                                  : theme.colorScheme.onSurface,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: theme.colorScheme.primary,
                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                            checkmarkColor: theme.colorScheme.onPrimary,
                            onSelected: (selected) {
                              setState(() {
                                _selectedAreaCode = selected ? entry.key : null;
                                _selectedSigunguCode = null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 월 선택
                    _buildSection(
                      title: '기간',
                      icon: Icons.calendar_month,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(12, (index) {
                                final month = index + 1;
                                final now = DateTime.now();
                                final targetDate = DateTime(now.year, month);
                                final isSelected = _selectedMonth != null &&
                                    _selectedMonth!.month == month;
                                
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(
                                      '${month}월',
                                      style: TextStyle(
                                        color: isSelected 
                                          ? theme.colorScheme.onPrimary 
                                          : theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    selected: isSelected,
                                    selectedColor: theme.colorScheme.primary,
                                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                    checkmarkColor: theme.colorScheme.onPrimary,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedMonth = selected ? targetDate : null;
                                      });
                                    },
                                  ),
                                );
                              }),
                            ),
                          ),
                          if (_selectedMonth != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              '${_selectedMonth!.year}년 ${_selectedMonth!.month}월 축제',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 정렬 옵션
                    _buildSection(
                      title: '정렬',
                      icon: Icons.sort,
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: Text(
                              '시작일순',
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontWeight: _selectedSortBy == 'R' ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            subtitle: Text(
                              '가장 빨리 시작하는 축제부터',
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            value: 'R',
                            groupValue: _selectedSortBy,
                            activeColor: theme.colorScheme.primary,
                            onChanged: (value) {
                              setState(() {
                                _selectedSortBy = value!;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                          RadioListTile<String>(
                            title: Text(
                              '제목순',
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontWeight: _selectedSortBy == 'O' ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            subtitle: Text(
                              '가나다순으로 정렬',
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            value: 'O',
                            groupValue: _selectedSortBy,
                            activeColor: theme.colorScheme.primary,
                            onChanged: (value) {
                              setState(() {
                                _selectedSortBy = value!;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // 적용 버튼
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        // 필터 적용
                        controller.setAreaFilter(_selectedAreaCode, _selectedSigunguCode);
                        controller.setMonthFilter(_selectedMonth);
                        controller.setSortBy(_selectedSortBy);
                        
                        Navigator.pop(context);
                      },
                      child: const Text('필터 적용'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          );
        },
      ),
    );
  }
  
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}