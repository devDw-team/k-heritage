import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/tour_explore_controller.dart';
import '../../domain/repositories/ktour_repository.dart';

/// 지역별 필터 위젯
class AreaFilterWidget extends ConsumerStatefulWidget {
  final List<String> selectedAreaCodes;
  final List<String> selectedSigunguCodes;
  final Function(List<String>, List<String>) onAreaChanged;

  const AreaFilterWidget({
    super.key,
    required this.selectedAreaCodes,
    required this.selectedSigunguCodes,
    required this.onAreaChanged,
  });

  @override
  ConsumerState<AreaFilterWidget> createState() => _AreaFilterWidgetState();
}

class _AreaFilterWidgetState extends ConsumerState<AreaFilterWidget> {
  String? expandedAreaCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(tourExploreControllerProvider);
    
    // 주요 도시 리스트 (인기 순)
    final popularAreas = [
      const AreaCode(code: '1', name: '서울', rnum: 1),
      const AreaCode(code: '6', name: '부산', rnum: 2),
      const AreaCode(code: '39', name: '제주', rnum: 3),
      const AreaCode(code: '2', name: '인천', rnum: 4),
      const AreaCode(code: '31', name: '경기', rnum: 5),
      const AreaCode(code: '32', name: '강원', rnum: 6),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 빠른 선택 칩
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // 전체 선택/해제
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      widget.selectedAreaCodes.isEmpty ? '전체' : '초기화',
                      style: TextStyle(
                        color: widget.selectedAreaCodes.isEmpty
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    selected: widget.selectedAreaCodes.isEmpty,
                    onSelected: (selected) {
                      widget.onAreaChanged([], []);
                    },
                  ),
                ),
                
                // 인기 지역 칩
                ...popularAreas.map((area) {
                  final isSelected = widget.selectedAreaCodes.contains(area.code);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        area.name,
                        style: TextStyle(
                          color: isSelected
                              ? theme.colorScheme.onPrimaryContainer
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        final newAreaCodes = List<String>.from(widget.selectedAreaCodes);
                        final newSigunguCodes = List<String>.from(widget.selectedSigunguCodes);
                        
                        if (selected) {
                          newAreaCodes.add(area.code);
                        } else {
                          newAreaCodes.remove(area.code);
                          // 해당 지역의 시군구도 제거
                          newSigunguCodes.removeWhere((code) => code.startsWith(area.code));
                        }
                        
                        widget.onAreaChanged(newAreaCodes, newSigunguCodes);
                      },
                    ),
                  );
                }),
                
                // 더보기 버튼
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ActionChip(
                    avatar: Icon(
                      Icons.add,
                      size: 18,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    label: Text(
                      '더보기',
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    onPressed: () {
                      _showAreaSelectionDialog(context, state.areaCodes);
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // 선택된 지역 표시
          if (widget.selectedAreaCodes.isNotEmpty)
            Container(
              height: 32,
              margin: const EdgeInsets.only(top: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: widget.selectedAreaCodes.map((areaCode) {
                  final areaName = state.areaCodes
                      .firstWhere((a) => a.code == areaCode, 
                          orElse: () => AreaCode(code: areaCode, name: areaCode, rnum: 0))
                      .name;
                  
                  // 선택된 시군구 수
                  final sigunguCount = widget.selectedSigunguCodes
                      .where((code) => code.startsWith(areaCode))
                      .length;
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InputChip(
                      label: Text(
                        sigunguCount > 0 
                            ? '$areaName($sigunguCount)'
                            : areaName,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      deleteIcon: Icon(
                        Icons.close,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      onDeleted: () {
                        final newAreaCodes = List<String>.from(widget.selectedAreaCodes)
                          ..remove(areaCode);
                        final newSigunguCodes = List<String>.from(widget.selectedSigunguCodes)
                          ..removeWhere((code) => code.startsWith(areaCode));
                        widget.onAreaChanged(newAreaCodes, newSigunguCodes);
                      },
                      onPressed: () {
                        // 시군구 선택 다이얼로그
                        _showSigunguSelectionDialog(
                          context,
                          areaCode,
                          areaName,
                          state.sigunguCodes[areaCode] ?? [],
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  /// 지역 선택 다이얼로그
  void _showAreaSelectionDialog(BuildContext context, List<AreaCode> areaCodes) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('지역 선택'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: areaCodes.length,
              itemBuilder: (context, index) {
                final area = areaCodes[index];
                final isSelected = widget.selectedAreaCodes.contains(area.code);
                
                return CheckboxListTile(
                  title: Text(area.name),
                  value: isSelected,
                  onChanged: (selected) {
                    final newAreaCodes = List<String>.from(widget.selectedAreaCodes);
                    final newSigunguCodes = List<String>.from(widget.selectedSigunguCodes);
                    
                    if (selected == true) {
                      newAreaCodes.add(area.code);
                    } else {
                      newAreaCodes.remove(area.code);
                      newSigunguCodes.removeWhere((code) => code.startsWith(area.code));
                    }
                    
                    widget.onAreaChanged(newAreaCodes, newSigunguCodes);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  /// 시군구 선택 다이얼로그
  void _showSigunguSelectionDialog(
    BuildContext context,
    String areaCode,
    String areaName,
    List<AreaCode> sigunguList,
  ) {
    if (sigunguList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('시군구 정보를 불러오는 중입니다...')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$areaName 시군구 선택'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sigunguList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // 전체 선택 옵션
                  return CheckboxListTile(
                    title: const Text('전체'),
                    value: widget.selectedSigunguCodes
                        .where((code) => code.startsWith(areaCode))
                        .isEmpty,
                    onChanged: (selected) {
                      final newSigunguCodes = List<String>.from(widget.selectedSigunguCodes)
                        ..removeWhere((code) => code.startsWith(areaCode));
                      widget.onAreaChanged(widget.selectedAreaCodes, newSigunguCodes);
                      Navigator.pop(context);
                    },
                  );
                }
                
                final sigungu = sigunguList[index - 1];
                final sigunguCode = '$areaCode${sigungu.code}';
                final isSelected = widget.selectedSigunguCodes.contains(sigunguCode);
                
                return CheckboxListTile(
                  title: Text(sigungu.name),
                  value: isSelected,
                  onChanged: (selected) {
                    final newSigunguCodes = List<String>.from(widget.selectedSigunguCodes);
                    
                    if (selected == true) {
                      newSigunguCodes.add(sigunguCode);
                    } else {
                      newSigunguCodes.remove(sigunguCode);
                    }
                    
                    widget.onAreaChanged(widget.selectedAreaCodes, newSigunguCodes);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('완료'),
            ),
          ],
        );
      },
    );
  }
}