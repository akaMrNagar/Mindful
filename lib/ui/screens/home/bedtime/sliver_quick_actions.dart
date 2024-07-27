import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/permissions/dnd_permission.dart';
import 'package:mindful/ui/screens/home/bedtime/distracting_apps_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverQuickActions extends ConsumerStatefulWidget {
  const SliverQuickActions({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BedtimeActionsState();
}

class _BedtimeActionsState extends ConsumerState<SliverQuickActions> {
  bool isDistractingAppsListExpanded = false;

  @override
  Widget build(BuildContext context) {
    final shouldStartDnd =
        ref.watch(bedtimeProvider.select((v) => v.shouldStartDnd));

    final haveDndPermission =
        ref.watch(permissionProvider.select((v) => v.haveDndPermission));

    final isScheduleOn =
        ref.watch(bedtimeProvider.select((v) => v.isScheduleOn));

    return MultiSliver(
      children: [
        /// Bedtime actions
        const SliverContentTitle(title: "Quick actions"),

        /// Dnd permission warning
        const DndPermission(),

        /// Should start dnd
        DefaultListTile(
          enabled: haveDndPermission && !isScheduleOn,
          switchValue: shouldStartDnd,
          onPressed: () => ref
              .read(bedtimeProvider.notifier)
              .setShouldStartDnd(!shouldStartDnd),
          titleText: "Start DND",
          subtitleText: "Start do not disturb mode during \nbedtime.",
        ),

        /// Manage Dnd settings
        DefaultListTile(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          leading: const Icon(FluentIcons.alert_20_regular),
          titleText: "Do not disturb settings",
          subtitleText:
              "Manage which app are distracting you from your routine.",
          trailing: const Icon(FluentIcons.chevron_right_20_filled),
          onPressed: () =>
              MethodChannelService.instance.openDeviceDndSettings(),
        ),

        /// Manage distracting apps
        DefaultListTile(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          leading: const Icon(FluentIcons.weather_moon_20_regular),
          titleText: "Distracting apps",
          subtitleText:
              "Manage which app are distracting you from your routine.",
          trailing: AnimatedRotation(
            duration: 250.ms,
            turns: isDistractingAppsListExpanded ? 0.5 : 1,
            child: const Icon(FluentIcons.chevron_down_20_filled),
          ),
          onPressed: () => setState(
            () =>
                isDistractingAppsListExpanded = !isDistractingAppsListExpanded,
          ),
        ),

        /// Distracting apps list
        SliverAnimatedPaintExtent(
          duration: 500.ms,
          curve: Curves.easeOut,
          child: isDistractingAppsListExpanded
              ? const DistractingAppsList()
              : 0.vSliverBox,
        ),

        if (!isDistractingAppsListExpanded) 108.vSliverBox,
      ],
    );
  }
}