import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/focus_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';

/// Displays available settings for the app in [AppDashboard]
class AppSettings extends StatelessWidget {
  const AppSettings({super.key, required this.app});

  final AndroidApp app;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          12.vBox(),
          const Text("App settings"),
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
                    final timer = ref.watch(focusProvider.select(
                            (value) => value[app.packageName]?.timer)) ??
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
                                  .setAppTimer(app.packageName, value);
                            }
                          },
                        );
                      },
                    );
                  },
                ),

          /// Launch app button
          _SettingTile(
            title: "Launch App",
            icondata: FluentIcons.rocket_20_regular,
            onPressed: () {},
          ),

          /// Launch app notification settings button
          _SettingTile(
            title: "Manage notfications",
            icondata: FluentIcons.alert_on_20_regular,
            onPressed: () {},
          ),

          /// Launch app settings button
          _SettingTile(
            title: "Go to app settings",
            icondata: FluentIcons.launcher_settings_20_regular,
            onPressed: () {},
          ),
        ],
      ),
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
      applyBorder: subTitle != null,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTileSkeleton(
        leading: Icon(icondata),
        title: StatefulText(title, fontSize: 16),
        subtitle: subTitle != null
            ? StatefulText(
                subTitle!,
                activeColor: Theme.of(context).hintColor,
              )
            : null,
        trailing: trailing,
      ),
    );
  }
}
