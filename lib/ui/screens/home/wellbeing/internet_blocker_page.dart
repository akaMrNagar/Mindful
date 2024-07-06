import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/packages_by_network_usage_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/async_error_indicator.dart';
import 'package:mindful/ui/common/async_loading_indicator.dart';
import 'package:mindful/ui/common/checkbox_app_tile.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class InternetBlockerPage extends ConsumerWidget {
  const InternetBlockerPage({super.key});

  void _switchInternetBlocker(WidgetRef ref, bool shouldBlock) async {
    if (!shouldBlock || ref.read(wellbeingProvider).blockedApps.isNotEmpty) {
      ref.read(wellbeingProvider.notifier).switchInternetBlocker(shouldBlock);
      return;
    }

    /// Show toast if no blocked apps
    await MethodChannelService.instance.showToast(
      "Select atleast one app to block internet",
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInternetBlockerOn = ref
        .watch(wellbeingProvider.select((value) => value.isInternetBlockerOn));

    /// Parameters for family provider
    final params = (dayOfWeek: dayOfWeek, includeAll: true);
    final allApps = ref.watch(packagesByNetworkUsageProvider(params));

    final blockedApps =
        ref.watch(wellbeingProvider.select((v) => v.blockedApps));

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
                  leadingIcon: FluentIcons.globe_prohibited_20_regular,
                  titleText: "Internet blocker",
                  subTitleText: "Switch  blocker On/Off",
                  value: isInternetBlockerOn,
                  onPressed: () =>
                      _switchInternetBlocker(ref, !isInternetBlockerOn),
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
              /// Selected (Blocked) apps which are installed
              ...blockedApps.where((e) => apps.contains(e)),

              if (blockedApps.isNotEmpty) ...["divider"],

              /// Unselected apps which are installed
              ...apps.where((e) => !blockedApps.contains(e)),
            ],
            itemBuilder: (context, app) => CheckboxAppTile(
              app: app,
              isSelected: blockedApps.contains(app.packageName),
              onSelectionChanged: (v) => ref
                  .read(wellbeingProvider.notifier)
                  .insertRemoveBlockedApp(app.packageName, v),
            ),
          ),
        ),

        72.vSliverBox(),
      ],
    );
  }
}
