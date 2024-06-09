import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/packages_by_screen_usage_provider.dart';
import 'package:mindful/providers/protection_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/async_error_indicator.dart';
import 'package:mindful/ui/common/async_loading_indicator.dart';
import 'package:mindful/ui/common/checkbox_app_tile.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BlockInternetPage extends ConsumerWidget {
  const BlockInternetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBlockerOn = ref
        .watch(protectionProvider.select((value) => value.appsInternetBlocker));

    /// Parameters for family provider
    final params = (dayOfWeek: dayOfWeek, includeAll: true);
    final allApps = ref.watch(packagesByScreenUsageProvider(params));

    final selectedApps =
        ref.watch(protectionProvider.select((v) => v.blockedApps));

    return MultiSliver(
      children: [
        SliverPinnedHeader(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.vBox(),
                const StatefulText(
                  "Silence your phone, change screen to black and white at bedtime. Only alarms and important calls can reach you.",
                  isActive: false,
                ),
                12.vBox(),
                SwitchableListTile(
                  isPrimary: true,
                  leadingIcon: FluentIcons.shield_keyhole_20_regular,
                  titleText: "Internet blocker",
                  subTitleText: "Switch blocker On/Off",
                  value: isBlockerOn,
                  onPressed: () => ref
                      .read(protectionProvider.notifier)
                      .toggleAppsInternetBlocker(!isBlockerOn),
                ),
              ],
            ),
          ),
        ),

        /// Selected Apps list
        allApps.when(
          loading: () => const AsyncLoadingIndicator().toSliverBox(),
          error: (e, st) => AsyncErrorIndicator(e, st).toSliverBox(),
          data: (apps) => AnimatedAppsList(
            itemExtent: 56,
            headerTitle: "Select distracting apps",
            appPackages: [
              ...apps.where((e) => selectedApps.contains(e)),
              if (selectedApps.isNotEmpty) ...["divider"],
              ...apps.where((e) => !selectedApps.contains(e)),
            ],
            itemBuilder: (context, app) => CheckboxAppTile(
              app: app,
              isSelected: selectedApps.contains(app.packageName),
              onSelectionChanged: (v) => ref
                  .read(protectionProvider.notifier)
                  .insertRemoveBlockedApp(app.packageName, v),
            ),
          ),
        ),

        72.vSliverBox(),
      ],
    );
  }
}
