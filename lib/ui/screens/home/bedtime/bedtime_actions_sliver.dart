import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:mindful/ui/screens/home/bedtime/distracting_apps_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BedtimeActionsSliver extends ConsumerStatefulWidget {
  const BedtimeActionsSliver({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BedtimeActionsState();
}

class _BedtimeActionsState extends ConsumerState<BedtimeActionsSliver> {
  bool isDistractingAppsListExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isScheduleOn =
        ref.watch(bedtimeProvider.select((v) => v.isScheduleOn));

    final shouldStartDnd =
        ref.watch(bedtimeProvider.select((v) => v.shouldStartDnd));

    return MultiSliver(
      children: [
        SwitchableListTile(
          enabled: !isScheduleOn,
          value: shouldStartDnd,
          onPressed: () => ref
              .read(bedtimeProvider.notifier)
              .setShouldStartDnd(!shouldStartDnd),
          titleText: "Start DND",
          subTitleText: "Start do not disturb mode during \nbedtime",
        ),

        /// Manage Dnd settings
        RoundedContainer(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          onPressed: () =>
              MethodChannelService.instance.openDeviceDndSettings(),
          child: const ListTileSkeleton(
            leading: Icon(FluentIcons.alert_20_regular),
            title: StatefulText(
              "Do not disturb settings",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            subtitle: StatefulText(
              "Manage which app are distracting you from your routine.",
              fontSize: 14,
              isActive: false,
            ),
            trailing: Icon(FluentIcons.chevron_right_20_filled),
          ),
        ),

        /// Manage distracting apps
        RoundedContainer(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          onPressed: () => setState(
            () =>
                isDistractingAppsListExpanded = !isDistractingAppsListExpanded,
          ),
          child: ListTileSkeleton(
            leading: const Icon(FluentIcons.weather_moon_20_regular),
            title: const StatefulText(
              "Distracting apps",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            subtitle: const StatefulText(
              "Manage which app are distracting you from your routine.",
              fontSize: 14,
              isActive: false,
            ),
            trailing: AnimatedRotation(
              duration: 250.ms,
              turns: isDistractingAppsListExpanded ? 0.5 : 0,
              child: const Icon(FluentIcons.chevron_down_20_filled),
            ),
          ),
        ),

        /// Distracting apps list
        SliverAnimatedPaintExtent(
          duration: 500.ms,
          curve: Curves.easeInOut,
          child: isDistractingAppsListExpanded
              ? const DistractingAppsList()
              : 0.vSliverBox(),
        ),
      ],
    );
  }
}
