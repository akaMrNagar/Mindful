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

class BlockInternet extends StatelessWidget {
  const BlockInternet({super.key});

  @override
  Widget build(BuildContext context) {
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
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return SwitchableListTile(
                      isPrimary: true,
                      leadingIcon: FluentIcons.shield_keyhole_20_regular,
                      titleText: "Internet blocker",
                      subTitleText: "Block distracting app's internet",
                      value: ref.watch(protectionProvider
                          .select((value) => value.blockAppsInternet)),
                      onPressed: () => ref
                          .read(protectionProvider.notifier)
                          .toggleBlockApps(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

      

        /// Selected Apps list
        Consumer(
          builder: (_, WidgetRef ref, __) {
            final selectedApps =
                ref.watch(protectionProvider.select((v) => v.blockedApps));
            return AnimatedAppsList(
              itemExtent: 56,
              selectedDoW: dayOfWeek,
              usageType: UsageType.screenUsage,
              sortApps: (apps) {
                return [
                  ...apps.where((e) => selectedApps.contains(e)),
                  ...apps.where((e) => !selectedApps.contains(e)),
                ];
              },
              itemBuilder: (context, appPackage) => SelectableAppTile(
                appPackage: appPackage,
                isSelected: selectedApps.contains(appPackage),
                onSelect: () => ref
                    .read(protectionProvider.notifier)
                    .addAppToBlockedList(appPackage),
                onDeselect: () => ref
                    .read(protectionProvider.notifier)
                    .removeAppFromBlockedList(appPackage),
              ),
            );
          },
        ),

        72.vSliverBox(),
      ],
    );
  }
}
