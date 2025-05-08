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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/animated_flags_provider.dart';

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

  /// Wraps the widget with [Align] and set alignment to [Alignment.topCenter] and returns it
  Widget get topCentered => Align(alignment: Alignment.topCenter, child: this);

  /// Wraps the widget with [Align] and set alignment to [Alignment.bottomCenter] and returns it
  Widget get bottomCentered =>
      Align(alignment: Alignment.bottomCenter, child: this);

  /// Wraps the target [Widget] in an [Animate] instance, and returns
  /// the widget. But this animates the widget only once.
  Widget animateOnce({
    required WidgetRef ref,
    required String uniqueKey,
    Key? key,
    List<Effect>? effects,
    AnimateCallback? onInit,
    AnimateCallback? onPlay,
    AnimateCallback? onComplete,
    bool? autoPlay,
    Duration? delay,
    AnimationController? controller,
    Adapter? adapter,
    double? target,
    double? value,
  }) =>
      ref.watch(animatedFlagsProvider.select((v) => !v.contains(uniqueKey)))
          ? Animate(
              key: key,
              effects: effects,
              onInit: onInit,
              onPlay: onPlay,
              onComplete: (controller) {
                /// Call on complete
                onComplete?.call(controller);

                /// Add this key to animated set
                Future.delayed(
                  delay ?? 100.ms,
                  () {
                    if (ref.context.mounted) {
                      ref
                          .read(animatedFlagsProvider.notifier)
                          .update((v) => v..add(uniqueKey));
                    }
                  },
                );
              },
              autoPlay: autoPlay,
              delay: delay,
              controller: controller,
              adapter: adapter,
              target: target,
              value: value,
              child: this,
            )
          : this;
}
