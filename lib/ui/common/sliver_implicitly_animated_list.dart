/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/utils/widget_utils.dart';

class SliverImplicitlyAnimatedList<T> extends StatefulWidget {
  const SliverImplicitlyAnimatedList({
    super.key,
    required this.items,
    required this.keyBuilder,
    required this.itemBuilder,
    this.itemExtent,
    this.animationDelay = Duration.zero,
    this.animationDurationMultiplier = 1,
  });

  final Duration animationDelay;
  final double animationDurationMultiplier;
  final double? itemExtent;
  final List<T> items;
  final String Function(T item) keyBuilder;
  final Widget Function(
    BuildContext context,
    int index,
    T item,
    ItemPosition position,
  ) itemBuilder;

  @override
  State<SliverImplicitlyAnimatedList<T>> createState() =>
      _SliverImplicitlyAnimatedListState<T>();
}

class _SliverImplicitlyAnimatedListState<T>
    extends State<SliverImplicitlyAnimatedList<T>> {
  final Map<String, int> _prevIndices = {};

  void _postFrameCallback() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        for (var i = 0; i < widget.items.length; i++) {
          _prevIndices.update(
            widget.keyBuilder(widget.items[i]),
            (_) => i,
            ifAbsent: () => i,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Update indices of tiles based on packages
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _postFrameCallback(),
    );

    return widget.itemExtent != null
        ? SliverFixedExtentList.builder(
            itemExtent: widget.itemExtent!,
            itemCount: widget.items.length,
            itemBuilder: _itemBuilder,
          )
        : SliverList.builder(
            itemCount: widget.items.length,
            itemBuilder: _itemBuilder,
          );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    String key = widget.keyBuilder(widget.items[index]);

    /// Get offset from previous indices
    final yOffset =
        _prevIndices.containsKey(key) ? _prevIndices[key]! - index : 0;

    return Animate(
      key: Key(key),
      delay: widget.animationDelay,
      effects: [
        SlideEffect(
          duration: AppConstants.defaultAnimDuration *
              widget.animationDurationMultiplier,
          curve: AppConstants.defaultCurve,
          begin: Offset(0, yOffset.toDouble()),
          end: const Offset(0, 0),
        ),
      ],
      child: widget.itemBuilder(
        context,
        index,
        widget.items[index],
        getItemPositionInList(index, widget.items.length),
      ),
    );
  }
}
