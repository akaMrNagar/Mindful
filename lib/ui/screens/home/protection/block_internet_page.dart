import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/protection_provider.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:mindful/ui/screens/home/protection/apps_selection_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BlockInternetPage extends ConsumerWidget {
  const BlockInternetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBlockerOn = ref
        .watch(protectionProvider.select((value) => value.appsInternetBlocker));
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
                      .toggleAppsInternetBlocker(!isBlockerOn),
                ),
              ],
            ),
          ),
        ),

        /// Selected Apps list
        AppsSelectionList(
          selectedApps: selectedApps,
          onSelect: (appPackage) => ref
              .read(protectionProvider.notifier)
              .addAppToBlockedList(appPackage),
          onDeselect: (appPackage) => ref
              .read(protectionProvider.notifier)
              .removeAppFromBlockedList(appPackage),
        ),

        72.vSliverBox(),
      ],
    );
  }
}
