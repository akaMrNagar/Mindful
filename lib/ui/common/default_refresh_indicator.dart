/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';

class DefaultRefreshIndicator extends StatelessWidget {
  /// Global pull to refresh widget
  const DefaultRefreshIndicator({
    super.key,
    this.edgeOffset = 124,
    this.displacement = 156,
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
