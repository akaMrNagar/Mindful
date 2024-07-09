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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(
            focusProvider.select((value) => value[app.packageName]?.timer)) ??
        0;

    final isPurged = timer > 0 && timer < app.screenTimeThisWeek[dayOfWeek];
    final internetAccess = ref.watch(focusProvider
            .select((value) => value[app.packageName]?.internetAccess)) ??
        true;

    final haveVpnPermission =
        ref.watch(permissionProvider.select((v) => v.haveVpnPermission));

    return SliverList.list(
      children: [
        /// App Timer Button
        app.isImpSysApp
            ? const DefaultListTile(
                titleText: "App timer",
                subtitleText: "Timer not available for important apps",
                leadingIcon: FluentIcons.timer_off_20_regular,
              )
            : DefaultListTile(
                titleText: "App timer",
                subtitleText:
                    timer > 0 ? timer.seconds.toTimeFull() : "No timer",
                leadingIcon: isPurged
                    ? FluentIcons.clock_toolbox_20_regular
                    : FluentIcons.timer_20_regular,
                trailing: isPurged ? const Text("Paused") : null,
                onPressed: () async {
                  await showDurationPicker(
                    context: context,
                    initialTime: timer,
                    appName: app.name,
                  ).then(
                    (value) {
                      if (value != timer) {
                        ref
                            .read(focusProvider.notifier)
                            .updateAppTimer(app.packageName, value);
                      }
                    },
                  );
                },
              ),

        /// Internet access
        DefaultListTile(
          switchValue: internetAccess,
          enabled: haveVpnPermission,
          titleText: "Internet access",
          subtitleText: "Turn off to block app's internet",
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
