import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/packages_by_network_usage_provider.dart';
import 'package:mindful/providers/packages_by_screen_usage_provider.dart';
import 'package:mindful/ui/common/async_error_indicator.dart';
import 'package:mindful/ui/common/async_loading_indicator.dart';
import 'package:mindful/ui/common/components/rounded_list_tile.dart';
import 'package:mindful/ui/screens/home/dashboard/application_tile.dart';

class AnimatedAppsList extends ConsumerStatefulWidget {
  const AnimatedAppsList({
    super.key,
    required this.usageType,
    required this.selectedDoW,
  });

  final UsageType usageType;
  final int selectedDoW;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedAppsListState();
}

class _AnimatedAppsListState extends ConsumerState<AnimatedAppsList> {
  bool _includeAllApps = false;

  @override
  Widget build(BuildContext context) {
    /// Parameters for family provider
    final params = (dayOfWeek: widget.selectedDoW, includeAll: _includeAllApps);

    /// Watch the provider based on usage type
    final sortedApps = widget.usageType == UsageType.screenUsage
        ? ref.watch(packagesByScreenUsageProvider(params))
        : ref.watch(packagesByNetworkUsageProvider(params));

    return sortedApps.when(
      loading: () => const AsyncLoadingIndicator().toSliverBox(),
      error: (e, st) => AsyncErrorIndicator(e, st).toSliverBox(),
      data: (packages) => SliverFixedExtentList.builder(
        itemExtent: 72,
        itemCount: packages.length + (_includeAllApps ? 0 : 1),
        itemBuilder: (context, index) => index < packages.length

            /// Application list tile
            ? ApplicationTile(
                appPackage: packages[index],
                usageType: widget.usageType,
                day: widget.selectedDoW,
              )

            /// Show all apps button
            : Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: RoundedListTile(
                  leading: const Icon(FluentIcons.select_all_off_20_regular),
                  title: const Text("Show all apps"),
                  trailing: const Icon(FluentIcons.chevron_down_20_filled),
                  onPressed: () => setState(() => _includeAllApps = true),
                ),
              ),
      ),
    );
  }
}
