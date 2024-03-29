import 'package:flutter/material.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/components/base_bar_chart.dart';

class UsageChartPanel extends StatelessWidget {
  /// Sliver box containing base bar chart for usage and
  /// selected day of week changer buttons
  const UsageChartPanel({
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
    return Column(
      children: [
        /// Usage bar chart
        BaseBarChart(
          height: chartHeight,
          usageType: usageType,
          selectedBar: dayOfWeek,
          intervalBuilder: (max) => max * 0.275,
          onBarTap: onDayOfWeekChanged,
          data: barChartData,
        ),

        12.vBox(),

        /// Selected day changer
        Container(
          height: 48,
          color: Theme.of(context).cardColor.withOpacity(.3),
        ),
      ],
    ).toSliverBox();
  }
}
