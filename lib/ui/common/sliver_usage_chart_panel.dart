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
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/ui/common/default_bar_chart.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverUsageChartPanel extends StatelessWidget {
  /// Sliver list containing base bar chart for usage and
  /// selected day of week changer buttons
  const SliverUsageChartPanel({
    super.key,
    this.chartHeight = 256,
    required this.selectedDoW,
    required this.usageType,
    required this.barChartData,
    required this.onDayOfWeekChanged,
  });

  final double chartHeight;
  final int selectedDoW;
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
          selectedBar: selectedDoW,
          onBarTap: onDayOfWeekChanged,
          data: barChartData,
        ),

        8.vBox,

        /// Selected day changer
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(FluentIcons.chevron_left_20_filled),
                onPressed: selectedDoW > 0
                    ? () => onDayOfWeekChanged((selectedDoW - 1) % 7)
                    : null,
              ),
              StyledText(
                selectedDoW.dateFromDoW(context),
                color: Theme.of(context).hintColor,
                fontSize: 14,
              ),
              IconButton(
                icon: const Icon(FluentIcons.chevron_right_20_filled),
                onPressed: selectedDoW < todayOfWeek
                    ? () => onDayOfWeekChanged((selectedDoW + 1) % 7)
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
