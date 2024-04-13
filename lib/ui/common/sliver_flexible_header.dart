import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverFlexiblePinnedHeader extends StatelessWidget {
  const SliverFlexiblePinnedHeader({
    super.key,
    required this.child,
    this.maxHeight,
    this.minHeight,
    this.backgroundColor,
    this.padding,
    this.alignment,
  });

  final Widget child;
  final double? maxHeight;
  final double? minHeight;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final childContainer = Container(
      padding: padding,
      alignment: alignment,
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );

    return maxHeight != null && minHeight != null
        ? SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeaderDelegate(
              maxHeight: maxHeight!,
              minHeight: minHeight!,
              child: childContainer,
            ),
          )
        : SliverPinnedHeader(child: childContainer);
  }
}

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  PersistentHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
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
    return child;
  }

  @override
  bool shouldRebuild(PersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
