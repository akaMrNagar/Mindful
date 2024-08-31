/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';

extension ExtWidget on Widget {
  /// Wraps the widget with [SliverToBoxAdapter] and returns it
  Widget get sliver => SliverToBoxAdapter(child: this);

  /// Wraps the widget with [Center] and returns it
  Widget get centered => Center(child: this);

  /// Wraps the widget with [Align] and set alignment to [Alignment.centerLeft] and returns it
  Widget get leftCentered =>
      Align(alignment: Alignment.centerLeft, child: this);

  /// Wraps the widget with [Align] and set alignment to [Alignment.centerRight] and returns it
  Widget get rightCentered =>
      Align(alignment: Alignment.centerRight, child: this);
}
