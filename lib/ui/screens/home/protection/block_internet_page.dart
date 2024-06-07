import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/protection_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/selectable_app_tile.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BlockInternetPage extends ConsumerWidget {
  const BlockInternetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBlockerOn = ref
        .watch(protectionProvider.select((value) => value.blockAppsInternet));
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
                  subTitleText: "Block distracting app's internet",
                  value: isBlockerOn,
                  onPressed: () => ref
                      .read(protectionProvider.notifier)
                      .toggleBlockApps(!isBlockerOn),
                ),
              ],
            ),
          ),
        ),

        /// Warning if Vpn is disconnected unintentionally
        // if(isBlockerOn)

        /// Selected Apps list
        AnimatedAppsList(
          itemExtent: 56,
          selectedDoW: dayOfWeek,
          usageType: UsageType.networkUsage,
          sortApps: (apps) {
            return [
              ...apps.where((e) => selectedApps.contains(e)),
              if (selectedApps.isNotEmpty) ...[""],
              ...apps.where((e) => !selectedApps.contains(e)),
            ];
          },
          itemBuilder: (context, appPackage) => appPackage.isEmpty
              ? const Divider(indent: 12, endIndent: 12)
              : SelectableAppTile(
                  appPackage: appPackage,
                  isSelected: selectedApps.contains(appPackage),
                  onSelect: () => ref
                      .read(protectionProvider.notifier)
                      .addAppToBlockedList(appPackage),
                  onDeselect: () => ref
                      .read(protectionProvider.notifier)
                      .removeAppFromBlockedList(appPackage),
                ),
        ),

        72.vSliverBox(),
      ],
    );
  }
}
