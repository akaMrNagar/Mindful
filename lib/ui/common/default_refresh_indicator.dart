import 'package:flutter/material.dart';

class DefaultRefreshIndicator extends StatelessWidget {
  /// Global pull to refresh widget
  const DefaultRefreshIndicator({
    super.key,
    this.edgeOffset = 124,
    this.displacement = 172,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final double edgeOffset;
  final double displacement;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: edgeOffset,
      displacement: displacement,
      backgroundColor: Theme.of(context).colorScheme.primary,
      color: Theme.of(context).colorScheme.surface,
      strokeWidth: 3,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
