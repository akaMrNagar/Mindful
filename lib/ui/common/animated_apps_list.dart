import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AnimatedAppsList extends ConsumerStatefulWidget {
  const AnimatedAppsList({
    super.key,
    required this.itemExtent,
    required this.appPackages,
    required this.itemBuilder,
    this.headerTitle,
  });

  final double itemExtent;
  final String? headerTitle;
  final List<String> appPackages;
  final Widget Function(BuildContext context, AndroidApp app) itemBuilder;

  @override
  ConsumerState<AnimatedAppsList> createState() => _AnimatedAppsListState();
}

class _AnimatedAppsListState extends ConsumerState<AnimatedAppsList> {
  // ignore: prefer_final_fields
  Map<String, int> _prevIndices = {};

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

    return MultiSliver(
      children: [
        /// Select distracting apps
        if (widget.headerTitle != null)
          SliverContentTitle(title: widget.headerTitle!),

        /// Apps list
        SliverFixedExtentList.builder(
          itemExtent: widget.itemExtent,
          itemCount: widget.appPackages.length,
          itemBuilder: (context, index) {
            final yOffset = _prevIndices.containsKey(widget.appPackages[index])
                ? _prevIndices[widget.appPackages[index]]! - index
                : 0;

            /// Read the app package entry
            final app =
                ref.read(appsProvider).value?[widget.appPackages[index]];

            /// Application list tile
            return Animate(
              key: Key(widget.appPackages[index]),
              effects: [
                MoveEffect(
                  duration: 250.ms,
                  curve: Curves.easeOut,
                  begin: Offset(0, yOffset * widget.itemExtent),
                  end: const Offset(0, 0),
                ),
              ],

              /// NOTE: App can't be null in any condition but we put divider
              /// only if we added empty package in list to seperate
              /// selected and unselected apps mainly on
              /// [TabProtection => Internet Blocker] screen and
              /// [TabBedtime => Distracting Apps List] screen
              child: app == null
                  ? const Divider(indent: 12, endIndent: 12)
                  : widget.itemBuilder(context, app),
            );
          },
        ),
      ],
    );
  }
}
