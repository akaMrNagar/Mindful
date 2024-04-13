import 'package:flutter/material.dart';

extension ExtWidget on Widget {
  /// Wraps the widget with [SliverToBoxAdapter]
  Widget toSliverBox() => SliverToBoxAdapter(child: this);
}
