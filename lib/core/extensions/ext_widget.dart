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
