import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/focus_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';

/// Displays available actions for the app in [AppDashboard]
class QuickActions extends StatelessWidget {
  const QuickActions({super.key, required this.app});

  final AndroidApp app;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        12.vBox(),
        const Text("Quick actions"),
        8.vBox(),

        /// App Timer Button
        app.isImpSysApp
            ? const _SettingTile(
                title: "App timer",
                subTitle: "Timer not available for important apps",
                icondata: FluentIcons.timer_off_20_regular,
              )
            : Consumer(
                builder: (_, WidgetRef ref, __) {
                  final timer = ref.watch(focusProvider
                          .select((value) => value[app.packageName]?.timer)) ??
                      0;

                  final isPurged =
                      timer > 0 && timer < app.screenTimeThisWeek[dayOfWeek];
                  return _SettingTile(
                    title: "App timer",
                    subTitle:
                        timer > 0 ? timer.seconds.toTimeFull() : "No timer",
                    icondata: isPurged
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
                  );
                },
              ),

        /// Internet access
        Consumer(
          builder: (_, WidgetRef ref, __) {
            final internetAccess = ref.watch(focusProvider.select(
                    (value) => value[app.packageName]?.internetAccess)) ??
                true;
            return SwitchableListTile(
              value: internetAccess,
              titleText: "Internet access",
              subTitleText: "Turn off to block app's internet",
              leadingIcon: FluentIcons.earth_20_regular,
              onPressed: () => ref
                  .read(focusProvider.notifier)
                  .switchInternetAccess(app.packageName, !internetAccess),
            );
          },
        ),

        /// Launch app button
        _SettingTile(
          title: "Launch app",
          subTitle: "Open ${app.name}",
          icondata: FluentIcons.rocket_20_regular,
          onPressed: () async =>
              MethodChannelService.instance.openAppWithPackage(app.packageName),
        ),

        /// Launch app settings button
        _SettingTile(
          title: "Go to app settings",
          subTitle:
              "Manage app settings like notifications, permissions, storage and more",
          icondata: FluentIcons.launcher_settings_20_regular,
          onPressed: () async => MethodChannelService.instance
              .openAppSettingsForPackage(app.packageName),
        ),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.title,
    required this.icondata,
    this.subTitle,
    this.onPressed,
    this.trailing,
  });

  final String title;
  final String? subTitle;
  final IconData icondata;
  final VoidCallback? onPressed;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: subTitle == null ? 52 : 64,
      onPressed: onPressed,
      // applyBorder: subTitle != null,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTileSkeleton(
        leading: Icon(icondata),
        title: StatefulText(title, fontSize: 16),
        subtitle: subTitle != null
            ? StatefulText(
                subTitle!,
                fontSize: 14,
                isActive: false,
                // activeColor: Theme.of(context).hintColor,
              )
            : null,
        trailing: trailing,
      ),
    );
  }
}
