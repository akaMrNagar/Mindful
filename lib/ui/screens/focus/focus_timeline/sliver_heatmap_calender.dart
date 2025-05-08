import 'dart:math';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverHeatMapCalendar extends StatefulWidget {
  const SliverHeatMapCalendar({
    super.key,
    required this.heatmapData,
    required this.onDayChanged,
    required this.onMonthChanged,
  });

  final Map<DateTime, int> heatmapData;
  final void Function(DateTime day) onDayChanged;
  final void Function(DateTime month) onMonthChanged;

  @override
  SliverHeatMapCalendarState createState() => SliverHeatMapCalendarState();
}

class SliverHeatMapCalendarState extends State<SliverHeatMapCalendar> {
  DateTime _selectedDate = DateTime.now();

  void _changeMonth(int direction) {
    setState(() {
      _selectedDate = _selectedDate
          .copyWith(month: _selectedDate.month + direction)
          .dateOnly;
    });

    widget.onDayChanged(_selectedDate);
    widget.onMonthChanged(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final maxValue = widget.heatmapData.values.fold(0, (x, y) => max(x, y));
    final dayWidgets = _buildDayWidgets(maxValue);

    return MultiSliver(
      children: [
        /// Month selector
        Row(
          children: [
            /// Previous
            IconButton(
              icon: const Icon(FluentIcons.chevron_left_20_filled),
              onPressed: () => _changeMonth(-1),
            ),
            const Spacer(),

            /// Current
            StyledText(
              DateFormat.yMMMM(Localizations.localeOf(context).languageCode)
                  .format(_selectedDate),
              color: Theme.of(context).hintColor,
              fontSize: 14,
            ),

            /// Reset button
            if (_selectedDate.dateOnly != DateTime.now().dateOnly)
              IconButton(
                iconSize: 18,
                onPressed: () {
                  setState(() => _selectedDate = DateTime.now());
                  widget.onMonthChanged(_selectedDate);
                  widget.onDayChanged(_selectedDate);
                },
                icon: const Icon(FluentIcons.arrow_counterclockwise_20_regular),
              ),
            const Spacer(),

            /// Next
            IconButton(
              icon: const Icon(FluentIcons.chevron_right_20_filled),
              onPressed: () => _changeMonth(1),
            ),
          ],
        ).sliver,

        12.vSliverBox,

        /// Week days
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: AppConstants.daysShort(context)
              .map((day) => Expanded(child: StyledText(day).centered))
              .toList(),
        ).sliver,

        12.vSliverBox,

        /// Calendar view
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemCount: dayWidgets.length,
          itemBuilder: (context, index) => dayWidgets[index],
        ),
      ],
    );
  }

  List<Widget> _buildDayWidgets(int maxHeatmapValue) {
    final totalDaysInMonth = _selectedDate.daysInMonth;

    // Get the first day of the month to align the days correctly
    int firstWeekdayOfMonth =
        DateTime(_selectedDate.year, _selectedDate.month, 1).weekday;

    List<Widget> dayWidgets = [];

    // Add empty boxes for the days before the 1st of the month
    for (int i = 0; i < firstWeekdayOfMonth % 7; i++) {
      dayWidgets.add(Container()); // Empty boxes to align the start
    }

    // Add boxes for each day of the selected month
    for (int day = 1; day <= totalDaysInMonth; day++) {
      DateTime currentDay =
          DateTime(_selectedDate.year, _selectedDate.month, day);

      // Check if the current day is the selected day
      bool isSelectedDay = currentDay == _selectedDate.dateOnly;

      // Get heatmap value for the current day, default to 0 if not available
      int heatmapValue = widget.heatmapData[currentDay] ?? 0;

      // Build the day widget
      dayWidgets.add(
        RoundedContainer(
          circularRadius: 12,
          margin: const EdgeInsets.all(2),
          color: isSelectedDay
              ? Theme.of(context).colorScheme.primary
              : heatmapValue > 0 && maxHeatmapValue > 0
                  ? _getHeatmapColor(maxHeatmapValue, heatmapValue)
                  : Colors.transparent,
          onPressed: () {
            setState(() {
              _selectedDate = currentDay;
            });
            widget.onDayChanged(currentDay.dateOnly);
          },
          child: StyledText(
            day.toString(),
            fontSize: 14,
            color:
                isSelectedDay ? Theme.of(context).colorScheme.onPrimary : null,
          ),
        ),
      );
    }

    return dayWidgets;
  }

  Color _getHeatmapColor(int max, int value) {
    double normalizedValue = value / max;

    // Interpolate the color based on the normalized value
    return Color.lerp(
      Theme.of(context).colorScheme.primaryContainer.withAlpha(10),
      Theme.of(context).colorScheme.primaryContainer,
      normalizedValue.clamp(0.0, 1.0),
    )!;
  }
}
