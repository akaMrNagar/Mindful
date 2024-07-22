import 'package:flutter/material.dart';

extension ExtWidget on Widget {
  /// Wraps the widget with [SliverToBoxAdapter] and returns it
  Widget get sliverBox => SliverToBoxAdapter(child: this);
}
