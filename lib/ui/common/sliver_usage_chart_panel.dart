import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/default_bar_chart.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverUsageChartPanel extends StatelessWidget {
  /// Sliver box containing base bar chart for usage and
  /// selected day of week changer buttons
  const SliverUsageChartPanel({
    super.key,
    this.chartHeight = 256,
    required this.dayOfWeek,
    required this.usageType,
    required this.barChartData,
    required this.onDayOfWeekChanged,
  });

  final double chartHeight;
  final int dayOfWeek;
  final UsageType usageType;
  final List<int> barChartData;
  final ValueChanged<int> onDayOfWeekChanged;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        /// Usage bar chart
        DefaultBarChart(
          height: chartHeight,
          usageType: usageType,
          selectedBar: dayOfWeek,
          intervalBuilder: (max) => max * 0.275,
          onBarTap: onDayOfWeekChanged,
          data: barChartData,
        ),

        8.vBox(),

        /// Selected day changer
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(FluentIcons.chevron_left_20_filled),
                onPressed: () => onDayOfWeekChanged((dayOfWeek - 1) % 7),
              ),
              StyledText(
                dayOfWeek.toDateDiffToday(),
                color: Theme.of(context).hintColor,
                fontSize: 14,
              ),
              IconButton(
                icon: const Icon(FluentIcons.chevron_right_20_filled),
                onPressed: () => onDayOfWeekChanged((dayOfWeek + 1) % 7),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
