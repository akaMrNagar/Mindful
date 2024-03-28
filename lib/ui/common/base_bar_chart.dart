import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/ui/common/custom_text.dart';

/// Base bar chart used for diplaying app/device usage
class BaseBarChart extends StatelessWidget {
  const BaseBarChart({
    super.key,
    required this.usageType,
    required this.selectedBar,
    required this.data,
    required this.onBarTap,
    this.height = 232,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.intervalBuilder,
  });

  final double height;
  final double width;
  final EdgeInsets padding;

  final List<int> data;
  final UsageType usageType;
  final int selectedBar;
  final Function(int barIndex) onBarTap;
  final double? Function(int max)? intervalBuilder;

  @override
  Widget build(BuildContext context) {
    final unselectedGrad = [Colors.blue, Colors.cyan];
    final selectedGrad = [Colors.red, Colors.pink];
    final maxY = data.fold(0, (p, e) => math.max(p, e));
    // adding one to show baar chart if all values are zeroes
    final barMaxHeight = (maxY * 1.1) + 1.0;

    return Container(
      height: height,
      width: width,
      padding: padding,
      child: BarChart(
        BarChartData(
          barGroups: List.generate(
            data.length,
            (index) {
              final isSelected = selectedBar == index;
              return BarChartGroupData(
                groupVertically: true,
                x: index,
                barRods: [
                  BarChartRodData(
                    width: 20,
                    toY: data[index].toDouble(),
                    gradient: LinearGradient(
                      colors: isSelected ? selectedGrad : unselectedGrad,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ],
              );
            },
          ),
          maxY: barMaxHeight,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY > 0 ? intervalBuilder?.call(maxY) : 1,
          ),
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
                if (touchedIndex != null && touchedIndex != selectedBar) {
                  onBarTap(touchedIndex);
                }
              }
            },
          ),
        ),
        swapAnimationCurve: Curves.easeOutExpo,
        swapAnimationDuration: 500.ms,
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
        interval: max > 0
            ? intervalBuilder == null
                ? null
                : intervalBuilder!(max)
            : 1,
        getTitlesWidget: (yPos, meta) => FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: SubtitleText(
            _generateSideLabels(yPos.toInt()),
          ),
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

  String _generateSideLabels(int yData) {
    return switch (usageType) {
      /// Screen usage labels
      UsageType.screenUsage => (yData.inHours > 1)
          ? "${(yData.inHours).ceil()}h"
          : "${yData.inMinutes}m",

      /// Network usage labels
      UsageType.networkUsage => (yData.gb >= 1)
          ? "${yData.gb.ceil()}gb"
          : (yData.mb >= 1)
              ? "${yData.mb}mb"
              : "${yData}kb",
    };
  }
}
