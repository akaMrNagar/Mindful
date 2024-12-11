/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';
import 'package:flutter/material.dart';

class TimerProgressClock extends StatelessWidget {
  const TimerProgressClock({
    super.key,
    required this.progress,
    this.dimension = 184,
  });

  /// Progress from 0-100
  final double progress;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(dimension),
      painter: _TimerClockPainter(
        progress: progress,
        bgColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        fillColor: Theme.of(context).colorScheme.primary,
        notchColor: Theme.of(context).colorScheme.primary,
        needleColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}

class _TimerClockPainter extends CustomPainter {
  final double progress;
  final Color fillColor;
  final Color bgColor;
  final Color notchColor;
  final Color needleColor;
  final double needleWidth;

  _TimerClockPainter({
    required this.progress,
    required this.fillColor,
    required this.bgColor,
    required this.notchColor,
    required this.needleColor,
    // ignore: unused_element
    this.needleWidth = 6,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width / 2, size.height / 2) - 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    double progressAngle = (2 * pi * (progress / 100)) - pi / 2;

    // Draw the notches around the timer
    Paint smallNotchPaint = Paint()
      ..color = notchColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    Paint bigNotchPaint = Paint()
      ..color = notchColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    int bigNotchCount = 12;
    int smallNotchCount = 4;
    double bigNotchLength = radius * 0.1;
    double smallNotchLength = radius * 0.03;

    double angleStep = 2 * pi / (bigNotchCount * (smallNotchCount + 1));
    for (int i = 0; i < bigNotchCount * (smallNotchCount + 1); i++) {
      double angle = angleStep * i;
      bool isBigNotch = (i % (smallNotchCount + 1) == 0);
      double notchLength = isBigNotch ? bigNotchLength : smallNotchLength;

      double startX = center.dx + cos(angle) * (radius - notchLength);
      double startY = center.dy + sin(angle) * (radius - notchLength);
      double endX = center.dx + cos(angle) * radius;
      double endY = center.dy + sin(angle) * radius;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        isBigNotch ? bigNotchPaint : smallNotchPaint,
      );
    }

    /// Draw main faded background
    canvas.drawCircle(
      center,
      radius * 0.75,
      Paint()..color = bgColor,
    );

    /// Draw main progress circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.75),
      -pi / 2,
      progressAngle + pi / 2,
      true,
      Paint()..color = fillColor,
    );

    /// Draw needle holder background circle
    canvas.drawCircle(center, radius * 0.15, Paint()..color = Colors.white);

    // Draw the progress pointer
    double needleLength = radius;
    double needleX = center.dx + cos(progressAngle) * needleLength;
    double needleY = center.dy + sin(progressAngle) * needleLength;
    Paint needlePaint = Paint()
      ..color = needleColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = needleWidth;
    canvas.drawLine(center, Offset(needleX, needleY), needlePaint);

    /// Draw needle holder foreground cap shadow
    canvas.drawCircle(
      center,
      radius * 0.2,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
        ..color = Colors.black.withOpacity(0.2),
    );

    /// Draw needle holder foreground cap circle
    canvas.drawCircle(center, radius * 0.09, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _TimerClockPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
