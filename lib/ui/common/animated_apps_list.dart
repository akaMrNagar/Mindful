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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';

class AnimatedAppsList extends ConsumerStatefulWidget {
  /// Animated list of android apps keyed to app packages
  /// The list automatically animates children based on their previous position or index
  const AnimatedAppsList({
    super.key,
    required this.itemExtent,
    required this.appPackages,
    required this.itemBuilder,
    this.separatorTitle,
  });

  final double itemExtent;
  final String? separatorTitle;
  final List<String> appPackages;
  final Widget Function(
      BuildContext context, AndroidApp app, ItemPosition position) itemBuilder;

  @override
  ConsumerState<AnimatedAppsList> createState() => _AnimatedAppsListState();
}

class _AnimatedAppsListState extends ConsumerState<AnimatedAppsList> {
  final Map<String, int> _prevIndices = {};

  void _postFrameCallback() {
    /// Update indices of tiles based on packages
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        for (var i = 0; i < widget.appPackages.length; i++) {
          _prevIndices.update(
            widget.appPackages[i],
            (value) => i,
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

    return SliverFixedExtentList.builder(
      itemExtent: widget.itemExtent,
      itemCount: widget.appPackages.length,
      itemBuilder: (context, index) {
        final yOffset = _prevIndices.containsKey(widget.appPackages[index])
            ? _prevIndices[widget.appPackages[index]]! - index
            : 0;

        /// Read the app package entry
        final app = ref.read(appsProvider).value?[widget.appPackages[index]];

        /// Application list tile
        return Animate(
          key: Key(widget.appPackages[index]),
          effects: [
            MoveEffect(
              duration: AppConstants.defaultAnimDuration,
              curve: AppConstants.defaultCurve,
              begin: Offset(0, yOffset * widget.itemExtent),
              end: const Offset(0, 0),
            ),
          ],

          /// NOTE: App can't be null in any condition but we put divider
          /// only if we added empty package in list to separate
          /// selected and unselected apps mainly on
          /// [TabProtection => Internet Blocker] screen and
          /// [TabBedtime => Distracting Apps List] screen
          child: app == null
              ? widget.separatorTitle == null
                  ? const Divider(indent: 12, endIndent: 12)
                  : ContentSectionHeader(title: widget.separatorTitle!)
              : widget.itemBuilder(
                  context,
                  app,
                  index == 0
                      ? ItemPosition.start
                      : index == widget.appPackages.length - 1
                          ? ItemPosition.end
                          : ItemPosition.mid,
                ),
        );
      },
    );
  }
}
