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

  /// Generates a random number between the range [NUMBER/2 - NUMBER]
  num get randomHalf =>
      ((this ~/ 2) + Random().nextInt((toInt() - (toInt() ~/ 2) + 1)));

  /// Returns TRUE if the number is between the given range [a] and [b], otherwise FALSE
  ///
  /// Only if number is less than [b] ie,[b] is upper range so number must not be equal
  bool isBetween(num a, num b) => a <= this && this < b;
}
