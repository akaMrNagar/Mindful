import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/device_focus_provider.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/duration_picker.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';
import 'package:mindful/widgets/_common/widgets_revealer.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key, required this.app});

  final AndroidApp app;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: WidgetsRevealer(
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
                    final timer = ref.watch(deviceFocusProvider.select(
                            (value) => value.appsTimer[app.packageName])) ??
                        0;
                    return _SettingTile(
                      title: "App timer",
                      subTitle: timer > 0 ? timer.seconds.toTime() : "No timer",
                      icondata: FluentIcons.time_and_weather_20_regular,
                      onPressed: () async {
                        await showDurationPicker(
                          context: context,
                          initialTime: timer,
                          appName: app.name,
                        ).then(
                          (value) {
                            if (value != timer) {
                              ref
                                  .read(deviceFocusProvider.notifier)
                                  .appendAppTimer(app.packageName, value);
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

          /// Launch app notification button
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
    this.subTitle,
    this.onPressed,
    required this.icondata,
  });

  final String title;
  final String? subTitle;
  final IconData icondata;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InteractiveCard(
      onPressed: onPressed,
      applyBorder: onPressed == null,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icondata,
            size: 32,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
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
        ],
      ),
    );
  }
}
