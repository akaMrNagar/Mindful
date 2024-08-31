/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:async';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SineWave extends StatefulWidget {
  const SineWave({
    super.key,
    this.sinColor = Colors.red,
    this.cosColor = Colors.blue,
  });

  final Color sinColor;
  final Color cosColor;

  @override
  State<SineWave> createState() => _SineWaveState();
}

class _SineWaveState extends State<SineWave> {
  final limitCount = 100;
  final sinPoints = <FlSpot>[];
  final cosPoints = <FlSpot>[];

  double xValue = 0;
  double step = 0.04;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      while (sinPoints.length > limitCount) {
        sinPoints.removeAt(0);
        cosPoints.removeAt(0);
      }
      setState(() {
        sinPoints.add(FlSpot(xValue, math.sin(xValue)));
        cosPoints.add(FlSpot(xValue, math.cos(xValue)));
      });
      xValue += step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return sinPoints.isNotEmpty
        ? AspectRatio(
            aspectRatio: 3,
            child: LineChart(
              LineChartData(
                minY: -1.5,
                maxY: 1.5,
                minX: sinPoints.first.x,
                maxX: sinPoints.last.x,
                lineTouchData: const LineTouchData(enabled: false),
                clipData: const FlClipData.none(),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(
                  show: false,
                  drawVerticalLine: false,
                ),
                lineBarsData: [
                  _flLines(sinPoints, widget.sinColor),
                  _flLines(cosPoints, widget.cosColor),
                ],
              ),
            ),
          )
        : Container();
  }

  LineChartBarData _flLines(List<FlSpot> points, Color color) {
    return LineChartBarData(
      spots: points,
      barWidth: 4,
      isCurved: false,
      dotData: const FlDotData(show: false),
      gradient: LinearGradient(
        colors: [
          color.withOpacity(0),
          color,
          color,
          color.withOpacity(0),
        ],
        stops: const [
          0.05,
          0.3,
          0.7,
          0.95,
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
