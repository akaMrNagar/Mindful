import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/packages_by_network_usage_provider.dart';
import 'package:mindful/providers/packages_by_screen_usage_provider.dart';
import 'package:mindful/ui/common/async_error_indicator.dart';
import 'package:mindful/ui/common/async_loading_indicator.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AnimatedAppsList extends ConsumerStatefulWidget {
  const AnimatedAppsList({
    super.key,
    required this.itemExtent,
    required this.selectedDoW,
    required this.usageType,
    required this.itemBuilder,
    this.listLabel = 'Select distracting apps',
    this.sortApps,
  });

  final int selectedDoW;
  final UsageType usageType;
  final double itemExtent;
  final Widget Function(BuildContext context, String appPackage) itemBuilder;
  final List<String> Function(List<String> apps)? sortApps;
  final String? listLabel;

  @override
  ConsumerState<AnimatedAppsList> createState() => _AnimatedAppsListState();
}

class _AnimatedAppsListState extends ConsumerState<AnimatedAppsList> {
  // ignore: prefer_final_fields
  Map<String, int> _prevIndices = {};
  bool _includeAllApps = false;

  void _postFrameCallback(List<String> packages) {
    /// Update indices of tiles based on packages
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        for (var i = 0; i < packages.length; i++) {
          _prevIndices.update(
            packages[i],
            (value) => i,
            ifAbsent: () => i,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Parameters for family provider
    final params = (dayOfWeek: widget.selectedDoW, includeAll: _includeAllApps);

    /// Watch the provider based on usage type
    final sortedApps = widget.usageType == UsageType.screenUsage
        ? ref.watch(packagesByScreenUsageProvider(params))
        : ref.watch(packagesByNetworkUsageProvider(params));

    return MultiSliver(
      children: [
        /// Select distracting apps
        if (widget.listLabel != null && sortedApps.hasValue)
          SliverFlexiblePinnedHeader(
            minHeight: 32,
            maxHeight: 48,
            alignment: Alignment.centerLeft,
            child: Text(widget.listLabel!),
          ),

        /// Apps list
        sortedApps.when(
          loading: () => const AsyncLoadingIndicator().toSliverBox(),
          error: (e, st) => AsyncErrorIndicator(e, st).toSliverBox(),
          data: (apps) {
            /// Sort apps if sorting function is not null
            final packages = widget.sortApps?.call(apps) ?? apps;

            return SliverFixedExtentList.builder(
              itemExtent: widget.itemExtent,
              itemCount: packages.length,
              itemBuilder: (context, index) {
                /// Update indices of tiles based on packages
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _postFrameCallback(packages),
                );

                final yOffset = _prevIndices.containsKey(packages[index])
                    ? _prevIndices[packages[index]]! - index
                    : 0;

                /// Application list tile
                return Animate(
                  key: Key(packages[index]),
                  effects: [
                    MoveEffect(
                      duration: 250.ms,
                      curve: Curves.easeOut,
                      begin: Offset(0, yOffset * widget.itemExtent),
                      end: const Offset(0, 0),
                    ),
                  ],
                  child: widget.itemBuilder(context, packages[index]),
                );
              },
            );
          },
        ),

        12.vBox(),

        /// Show all apps button
        if (sortedApps.hasValue && !_includeAllApps)
          RoundedContainer(
            height: 48,
            onPressed: () => setState(() => _includeAllApps = true),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const ListTileSkeleton(
              leading: Icon(FluentIcons.select_all_off_20_regular),
              title: Text("Show all apps"),
              trailing: Icon(FluentIcons.chevron_down_20_filled),
            ),
          ),
      ],
    );
  }
}
