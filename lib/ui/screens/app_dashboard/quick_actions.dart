import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/restriction_infos_provider.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

/// Displays available actions for the app in [AppDashboard]
class QuickActions extends ConsumerWidget {
  const QuickActions({super.key, required this.app});

  final AndroidApp app;

  void _pickAppTimer(
    BuildContext context,
    WidgetRef ref,
    int prevTimer,
    int screenTime,
  ) async {
    final isInvincibleModeOn = ref.read(
      settingsProvider.select((v) => v.isInvincibleModeOn),
    );

    if (isInvincibleModeOn && prevTimer > 0 && screenTime >= prevTimer) {
      context.showSnackAlert(
        "Due to invincible mode, modifications to paused app's timer is not allowed.",
      );
      return;
    }

    final newTimer = await showAppTimerPicker(
      app: app,
      heroTag: HeroTags.appTimerTileTag(app.packageName),
      context: context,
      initialTime: prevTimer,
    );

    if (newTimer == prevTimer) return;
    ref
        .read(restrictionInfosProvider.notifier)
        .updateAppTimer(app.packageName, newTimer);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTimer = ref.watch(restrictionInfosProvider
            .select((value) => value[app.packageName]?.timerSec)) ??
        0;

    final internetAccess = ref.watch(restrictionInfosProvider
            .select((value) => value[app.packageName]?.internetAccess)) ??
        true;

    final isPurged =
        appTimer > 0 && appTimer < app.screenTimeThisWeek[todayOfWeek];

    final haveVpnPermission =
        ref.watch(permissionProvider.select((v) => v.haveVpnPermission));

    return SliverList.list(
      children: [
        /// App Timer Button
        DefaultHero(
          tag: HeroTags.appTimerTileTag(app.packageName),
          child: DefaultListTile(
            titleText: "App timer",
            enabled: !app.isImpSysApp,
            subtitleText: app.isImpSysApp
                ? "Timer not available for important apps"
                : appTimer > 0
                    ? appTimer.seconds.toTimeFull()
                    : "No timer",
            leadingIcon: FluentIcons.timer_20_regular,
            accent: isPurged ? Theme.of(context).colorScheme.error : null,
            trailing: isPurged ? const Text("Paused") : null,
            onPressed: () => _pickAppTimer(
              context,
              ref,
              appTimer,
              app.screenTimeThisWeek[todayOfWeek],
            ),
          ),
        ),

        /// Internet access
        DefaultListTile(
          switchValue: internetAccess,
          enabled: haveVpnPermission && !app.isImpSysApp,
          titleText: "Internet access",
          subtitleText: app.isImpSysApp
              ? "Cannot block important app's internet."
              : internetAccess
                  ? "Switch off to block ${app.name}'s internet"
                  : "${app.name}'s internet is blocked.",
          leadingIcon: internetAccess
              ? FluentIcons.globe_20_regular
              : FluentIcons.globe_prohibited_16_filled,
          accent: internetAccess ? null : Theme.of(context).colorScheme.error,
          onPressed: () => ref
              .read(restrictionInfosProvider.notifier)
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
              "Manage app settings like notifications, permissions, storage and more.",
          leadingIcon: FluentIcons.launcher_settings_20_regular,
          onPressed: () async => MethodChannelService.instance
              .openAppSettingsForPackage(app.packageName),
        ),
      ],
    );
  }
}
