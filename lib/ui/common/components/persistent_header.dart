import 'dart:math';

import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final AlignmentGeometry? alignment;

  PersistentHeader({
    required this.child,
    this.maxHeight = 100,
    this.minHeight = 0,
    this.backgroundColor,
    this.padding,
    this.alignment,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: padding,
      alignment: alignment ?? Alignment.center,
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(PersistentHeader oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
