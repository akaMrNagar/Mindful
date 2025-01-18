/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/ui/common/default_bar_chart.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverUsageChartPanel extends StatelessWidget {
  /// Sliver list containing base bar chart for usage and
  /// selected day of week changer buttons
  const SliverUsageChartPanel({
    super.key,
    this.chartHeight = 256,
    required this.selectedDay,
    required this.usageType,
    required this.barChartData,
    required this.onDayOfWeekChanged,
    required this.onWeekChanged,
  });

  final double chartHeight;
  final DateTime selectedDay;
  final UsageType usageType;
  final Map<DateTime, UsageModel> barChartData;
  final ValueChanged<DateTime> onDayOfWeekChanged;
  final ValueChanged<DateTime> onWeekChanged;

  void _changeDay(int direction) {
    final newDate = selectedDay.add(direction.days);

    /// Check if the week is changed
    /// if old and new date is (1 & 7)[prev week]  OR (7 & 1) [new week]
    if ((selectedDay.weekday == 1 && newDate.weekday == 7) ||
        (selectedDay.weekday == 7 && newDate.weekday == 1)) {
      onWeekChanged(newDate);
    }

    /// Invoke on day changed anyway
    onDayOfWeekChanged(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        /// Usage bar chart
        DefaultBarChart(
          height: chartHeight,
          usageType: usageType,
          selectedDay: selectedDay,
          onDayBarTap: onDayOfWeekChanged,
          data: barChartData,
        ),

        8.vBox,

        /// Selected day changer
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              /// Previous day
              IconButton(
                icon: const Icon(FluentIcons.chevron_left_20_filled),
                onPressed: () => _changeDay(-1),
              ),

              const Spacer(),

              /// Current day
              StyledText(
                selectedDay.dateString(context),
                color: Theme.of(context).hintColor,
                fontSize: 14,
              ),

              /// Reset button
              if (selectedDay.isBefore(dateToday.startOfWeek))
                IconButton(
                  iconSize: 18,
                  icon: const Icon(
                    FluentIcons.arrow_counterclockwise_20_regular,
                  ),
                  onPressed: () {
                    onDayOfWeekChanged(dateToday);
                    onWeekChanged(dateToday);
                  },
                ),

              const Spacer(),

              /// Next day
              IconButton(
                icon: const Icon(FluentIcons.chevron_right_20_filled),
                onPressed: selectedDay.isBefore(dateToday)
                    ? () => _changeDay(1)
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
