import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/selected_day_provider.dart';
import 'package:mindful/widgets/shared/custom_text.dart';

/// Base bar chart used for diplaying app/device usage
class BaseBarChart extends ConsumerWidget {
  const BaseBarChart({
    super.key,
    required this.selectedDay,
    required this.data,
    required this.sideLabelsBuilder,
    this.intervalBuilder,
  });

  final int selectedDay;
  final List<int> data;

  /// Return type of [yPos]  will be same as provided in [data]
  final String Function(int yPos) sideLabelsBuilder;
  final double? Function(int max)? intervalBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unselectedGrad = [Colors.blue, Colors.cyan];
    final selectedGrad = [Colors.red, Colors.pink];
    final maxY = data.fold(0, (p, e) => math.max(p, e));

    // adding one to show baar if all values are zeroes
    final barMaxHeight = (maxY * 1.25) + 1;

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: BarChart(
        BarChartData(
          barGroups: List.generate(
            data.length,
            (index) {
              final isSelected = selectedDay == index;
              return BarChartGroupData(
                groupVertically: true,
                x: index,
                barRods: [
                  BarChartRodData(
                    width: 30,
                    toY: data[index].toDouble(),
                    gradient: LinearGradient(
                      colors: isSelected ? selectedGrad : unselectedGrad,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: barMaxHeight,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              );
            },
          ),
          maxY: barMaxHeight,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: _generateTitles(maxY, context),
          barTouchData: BarTouchData(
            touchExtraThreshold:
                const EdgeInsets.symmetric(vertical: 200, horizontal: 12),
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return null;
              },
            ),
            touchCallback: (tEvent, tResponse) {
              if (!tEvent.isInterestedForInteractions) {
                final touchedIndex = tResponse?.spot?.touchedBarGroupIndex;
                if (touchedIndex != null &&
                    touchedIndex != selectedDay &&
                    touchedIndex <= dayOfWeek) {
                  ref
                      .read(selectedDayProvider.notifier)
                      .update((state) => touchedIndex);
                }
              }
            },
          ),
        ),
        swapAnimationCurve: Curves.ease,
        swapAnimationDuration: 750.ms,
      ),
    );
  }

  FlTitlesData _generateTitles(int max, BuildContext context) {
    return FlTitlesData(
      show: true,
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: intervalBuilder == null ? null : intervalBuilder!(max),
        getTitlesWidget: (yPos, meta) => FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: SubtitleText(sideLabelsBuilder(yPos.toInt())),
        ),
      )),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 24,
          getTitlesWidget: (value, meta) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topCenter,
              child: SubtitleText(AppStrings.daysShort[value.toInt()]),
            ),
          ),
        ),
      ),
    );
  }
}
