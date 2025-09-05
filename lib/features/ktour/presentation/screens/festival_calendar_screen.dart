import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../application/festival_controller.dart';
import '../../domain/entities/tour_festival.dart';
import '../widgets/festival_card_widget.dart';

/// 축제 캘린더 뷰 화면
class FestivalCalendarScreen extends ConsumerStatefulWidget {
  const FestivalCalendarScreen({super.key});

  @override
  ConsumerState<FestivalCalendarScreen> createState() => _FestivalCalendarScreenState();
}

class _FestivalCalendarScreenState extends ConsumerState<FestivalCalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  
  Map<DateTime, List<TourFestival>> _festivalEvents = {};
  
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = now;
    _selectedDay = now;
    _firstDay = DateTime(now.year - 1);
    _lastDay = DateTime(now.year + 1);
    
    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFestivalsForMonth(_focusedDay);
    });
  }
  
  void _loadFestivalsForMonth(DateTime month) {
    final controller = ref.read(festivalControllerProvider.notifier);
    controller.setMonthFilter(month);
    controller.loadFestivals();
  }
  
  List<TourFestival> _getEventsForDay(DateTime day) {
    // 날짜 정규화 (시간 제거)
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _festivalEvents[normalizedDay] ?? [];
  }
  
  void _updateFestivalEvents(List<TourFestival> festivals) {
    final events = <DateTime, List<TourFestival>>{};
    
    for (final festival in festivals) {
      // 시작일과 종료일 파싱
      DateTime? startDate;
      DateTime? endDate;
      
      if (festival.eventStartDate != null && festival.eventStartDate!.length == 8) {
        final year = int.parse(festival.eventStartDate!.substring(0, 4));
        final month = int.parse(festival.eventStartDate!.substring(4, 6));
        final day = int.parse(festival.eventStartDate!.substring(6, 8));
        startDate = DateTime(year, month, day);
      }
      
      if (festival.eventEndDate != null && festival.eventEndDate!.length == 8) {
        final year = int.parse(festival.eventEndDate!.substring(0, 4));
        final month = int.parse(festival.eventEndDate!.substring(4, 6));
        final day = int.parse(festival.eventEndDate!.substring(6, 8));
        endDate = DateTime(year, month, day);
      }
      
      // 날짜 범위 내 모든 날짜에 축제 추가
      if (startDate != null && endDate != null) {
        for (DateTime date = startDate;
             date.isBefore(endDate.add(const Duration(days: 1)));
             date = date.add(const Duration(days: 1))) {
          final normalizedDate = DateTime(date.year, date.month, date.day);
          events.putIfAbsent(normalizedDate, () => []).add(festival);
        }
      }
    }
    
    setState(() {
      _festivalEvents = events;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(festivalControllerProvider);
    final controller = ref.read(festivalControllerProvider.notifier);
    
    // 축제 데이터가 변경되면 이벤트 맵 업데이트
    if (!state.isLoading && state.festivals.isNotEmpty) {
      _updateFestivalEvents(state.allFestivals);
    }
    
    final selectedEvents = _getEventsForDay(_selectedDay);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('축제 캘린더'),
        elevation: 0,
        actions: [
          // 오늘 날짜로 이동
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
            },
            tooltip: '오늘',
          ),
          // 리스트 뷰로 전환
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              controller.setViewMode('list');
              context.pop();
            },
            tooltip: '목록 보기',
          ),
        ],
      ),
      body: Column(
        children: [
          // 캘린더
          Card(
            margin: const EdgeInsets.all(8),
            child: TableCalendar<TourFestival>(
              locale: 'ko',
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
                titleTextStyle: theme.textTheme.titleLarge!,
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(color: theme.colorScheme.error),
                holidayTextStyle: TextStyle(color: theme.colorScheme.error),
                selectedDecoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
                markersAlignment: Alignment.bottomCenter,
                markerSize: 6,
                markerMargin: const EdgeInsets.symmetric(horizontal: 0.5),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return null;
                  
                  // 축제 상태별 색상 결정
                  final colors = <Color>[];
                  final uniqueStatuses = <FestivalStatus>{};
                  
                  for (final event in events) {
                    uniqueStatuses.add(event.status);
                  }
                  
                  for (final status in uniqueStatuses) {
                    switch (status) {
                      case FestivalStatus.ongoing:
                        colors.add(Colors.green);
                        break;
                      case FestivalStatus.upcoming:
                        colors.add(Colors.blue);
                        break;
                      case FestivalStatus.ended:
                        colors.add(Colors.grey);
                        break;
                      default:
                        colors.add(theme.colorScheme.secondary);
                    }
                  }
                  
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: colors.take(3).map((color) => Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 0.5),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    )).toList(),
                  );
                },
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
                // 페이지 변경 시 해당 월의 데이터 로드
                _loadFestivalsForMonth(focusedDay);
              },
            ),
          ),
          
          // 범례
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('진행중', Colors.green),
                const SizedBox(width: 16),
                _buildLegendItem('예정', Colors.blue),
                const SizedBox(width: 16),
                _buildLegendItem('종료', Colors.grey),
              ],
            ),
          ),
          
          const Divider(),
          
          // 선택된 날짜 표시
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            child: Row(
              children: [
                Icon(Icons.calendar_today, 
                     size: 18, 
                     color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  DateFormat('yyyy년 MM월 dd일 (E)', 'ko').format(_selectedDay),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (selectedEvents.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${selectedEvents.length}개',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // 선택된 날짜의 축제 목록
          Expanded(
            child: state.isLoading && selectedEvents.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : selectedEvents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '선택한 날짜에 축제가 없습니다',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: selectedEvents.length,
                        itemBuilder: (context, index) {
                          final festival = selectedEvents[index];
                          return FestivalCardWidget(
                            festival: festival,
                            onTap: () {
                              context.push('/ktour/festival/${festival.contentId}');
                            },
                            onBookmarkTap: () {
                              controller.toggleBookmark(festival.contentId);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}