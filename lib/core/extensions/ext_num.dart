import 'dart:math';

import 'package:flutter/material.dart';

extension ExtNum on num {
  /// Creates a horizontal sizedBox widget with given width
  Widget get hBox => SizedBox(width: toDouble());

  /// Creates a vertical sizedBox widget with given height
  Widget get vBox => SizedBox(height: toDouble());

  /// Creates a horizontal sliver sizedBox widget with given width
  Widget get hSliverBox =>
      SliverToBoxAdapter(child: SizedBox(width: toDouble()));

  /// Creates a vertical sliver sizedBox widget with given height
  Widget get vSliverBox =>
      SliverToBoxAdapter(child: SizedBox(height: toDouble()));

  num get randomHalf =>
      ((this ~/ 2) + Random().nextInt((toInt() - (toInt() ~/ 2) + 1)));
}
