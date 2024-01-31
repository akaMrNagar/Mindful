import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/focus_provider.dart';
import 'package:mindful/ui/widgets/buttons.dart';
import 'package:mindful/ui/widgets/custom_text.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';
import 'package:mindful/ui/widgets/widgets_revealer.dart';

/// Displays available settings for the app in [AppDashboard]
class AppSettings extends StatelessWidget {
  const AppSettings({super.key, required this.app});

  final AndroidApp app;

  @override
  Widget build(BuildContext context) {
    return WidgetsRevealer(
      children: [
        const TitleText("App settings", size: 14),
        const SizedBox(height: 8),

        /// App Timer Button
        app.isImpSysApp
            ? const _SettingTile(
                title: "App timer",
                subTitle: "Timer not available for important apps",
                icondata: FluentIcons.clock_dismiss_20_regular,
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
                    subTitle: timer > 0 ? timer.seconds.toTime() : "No timer",
                    icondata: FluentIcons.time_and_weather_20_regular,
                    trailing: isPurged ? const SubtitleText("PAUSED") : null,
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
    return SecondaryButton(
      onPressed: onPressed,
      margin: const EdgeInsets.only(bottom: 4, right: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icondata,
            size: 32,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(title, size: 16, weight: FontWeight.normal),
              if (subTitle != null) SubtitleText(subTitle!, size: 14),
            ],
          ),
          const Spacer(),
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}
