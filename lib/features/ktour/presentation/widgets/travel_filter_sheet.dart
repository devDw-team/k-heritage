import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/travel_info_controller.dart';
import '../../application/travel_info_state.dart';

/// 여행정보 필터 바텀시트
class TravelFilterSheet extends ConsumerStatefulWidget {
  const TravelFilterSheet({super.key});

  @override
  ConsumerState<TravelFilterSheet> createState() => _TravelFilterSheetState();
}

class _TravelFilterSheetState extends ConsumerState<TravelFilterSheet> {
  late TravelFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = ref.read(travelInfoControllerProvider).filter;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 핸들
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
                  '필터',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _resetFilter,
                  child: const Text('초기화'),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 필터 옵션들
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 정렬 기준
                  _buildSectionTitle('정렬 기준'),
                  Wrap(
                    spacing: 8,
                    children: SortBy.values.map((sortBy) {
                      return ChoiceChip(
                        label: Text(sortBy.label),
                        selected: _filter.sortBy == sortBy,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _filter = _filter.copyWith(sortBy: sortBy);
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // 거리 제한
                  _buildSectionTitle('거리 제한'),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _filter.maxDistance ?? 10.0,
                          min: 1.0,
                          max: 50.0,
                          divisions: 49,
                          label: '${(_filter.maxDistance ?? 10.0).toStringAsFixed(0)}km',
                          onChanged: (value) {
                            setState(() {
                              _filter = _filter.copyWith(maxDistance: value);
                            });
                          },
                        ),
                      ),
                      Text(
                        '${(_filter.maxDistance ?? 10.0).toStringAsFixed(0)}km',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SwitchListTile(
                    title: const Text('거리 제한 사용'),
                    value: _filter.maxDistance != null,
                    onChanged: (value) {
                      setState(() {
                        _filter = _filter.copyWith(
                          maxDistance: value ? 10.0 : null,
                        );
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: 24),

                  // 음식 종류 (맛집용)
                  _buildSectionTitle('음식 종류'),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildFilterChip('한식', 'A05020100'),
                      _buildFilterChip('중식', 'A05020200'),
                      _buildFilterChip('일식', 'A05020300'),
                      _buildFilterChip('양식', 'A05020400'),
                      _buildFilterChip('카페', 'A05020900'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 쇼핑 종류
                  _buildSectionTitle('쇼핑 종류'),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildFilterChip('백화점', 'A04010100', isShop: true),
                      _buildFilterChip('아울렛', 'A04010200', isShop: true),
                      _buildFilterChip('전통시장', 'A04010300', isShop: true),
                      _buildFilterChip('면세점', 'A04010400', isShop: true),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 숙박 옵션
                  _buildSectionTitle('숙박 옵션'),
                  CheckboxListTile(
                    title: const Text('굿스테이'),
                    value: _filter.goodStay,
                    onChanged: (value) {
                      setState(() {
                        _filter = _filter.copyWith(goodStay: value ?? false);
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                  CheckboxListTile(
                    title: const Text('한옥'),
                    value: _filter.hanOk,
                    onChanged: (value) {
                      setState(() {
                        _filter = _filter.copyWith(hanOk: value ?? false);
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: 24),

                  // 편의시설
                  _buildSectionTitle('편의시설'),
                  CheckboxListTile(
                    title: const Text('주차 가능'),
                    value: _filter.hasParking,
                    onChanged: (value) {
                      setState(() {
                        _filter = _filter.copyWith(hasParking: value ?? false);
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),

          // 하단 버튼
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('취소'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilter,
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, {bool isShop = false}) {
    final isSelected = isShop
        ? _filter.shopType == value
        : _filter.foodType == value;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (isShop) {
            _filter = _filter.copyWith(
              shopType: selected ? value : null,
            );
          } else {
            _filter = _filter.copyWith(
              foodType: selected ? value : null,
            );
          }
        });
      },
    );
  }

  void _resetFilter() {
    setState(() {
      _filter = const TravelFilter();
    });
  }

  void _applyFilter() {
    ref.read(travelInfoControllerProvider.notifier).updateFilter(_filter);
    Navigator.pop(context);
  }
}