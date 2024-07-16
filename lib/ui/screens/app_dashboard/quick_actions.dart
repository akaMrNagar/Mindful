import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/focus_provider.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';

/// Displays available actions for the app in [AppDashboard]
class QuickActions extends ConsumerWidget {
  const QuickActions({super.key, required this.app});

  final AndroidApp app;

  void _pickAppTimer(BuildContext context, WidgetRef ref, int prevTimer) async {
    final newTimer = await showDurationPicker(
      context: context,
      initialTime: prevTimer,
      appName: app.name,
    );

    if (newTimer == prevTimer) return;
    ref.read(focusProvider.notifier).updateAppTimer(app.packageName, newTimer);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTimer = ref.watch(
            focusProvider.select((value) => value[app.packageName]?.timer)) ??
        0;

    final internetAccess = ref.watch(focusProvider
            .select((value) => value[app.packageName]?.internetAccess)) ??
        true;

    final isPurged =
        appTimer > 0 && appTimer < app.screenTimeThisWeek[dayOfWeek];

    final haveVpnPermission =
        ref.watch(permissionProvider.select((v) => v.haveVpnPermission));

    return SliverList.list(
      children: [
        /// App Timer Button
        DefaultListTile(
            titleText: "App timer",
            enabled: !app.isImpSysApp,
            subtitleText: app.isImpSysApp
                ? "Timer not available for important apps"
                : appTimer > 0
                    ? appTimer.seconds.toTimeFull()
                    : "No timer",
            leadingIcon: isPurged
                ? FluentIcons.clock_toolbox_20_regular
                : FluentIcons.timer_20_regular,
            trailing: isPurged ? const Text("Paused") : null,
            onPressed: () => _pickAppTimer(context, ref, appTimer)),

        /// Internet access
        DefaultListTile(
          switchValue: internetAccess,
          enabled: haveVpnPermission && !app.isImpSysApp,
          titleText: "Internet access",
          subtitleText: app.isImpSysApp
              ? "Cannot block important app's internet"
              : "Turn off to block app's internet",
          leadingIcon: FluentIcons.earth_20_regular,
          onPressed: () => ref
              .read(focusProvider.notifier)
              .switchInternetAccess(app.packageName, !internetAccess),
        ),

        /// Launch app button
        DefaultListTile(
          titleText: "Launch app",
          subtitleText: "Open ${app.name}",
          leadingIcon: FluentIcons.rocket_20_regular,
          onPressed: () async =>
              MethodChannelService.instance.openAppWithPackage(app.packageName),
        ),

        /// Launch app settings button
        DefaultListTile(
          titleText: "Go to app settings",
          subtitleText:
              "Manage app settings like notifications, permissions, storage and more",
          leadingIcon: FluentIcons.launcher_settings_20_regular,
          onPressed: () async => MethodChannelService.instance
              .openAppSettingsForPackage(app.packageName),
        ),
      ],
    );
  }
}
