import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/device_focus_provider.dart';
import 'package:mindful/providers/selected_day_provider.dart';
import 'package:mindful/screens/app_stats_screen.dart';
import 'package:mindful/widgets/_common/application_icon.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/duration_picker.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

class ApplicationTile extends StatelessWidget {
  const ApplicationTile({
    super.key,
    required this.app,
    required this.isDataTile,
  });

  final AndroidApp app;
  final bool isDataTile;

  @override
  Widget build(BuildContext context) {
    return InteractiveCard(
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => AppStatsScreen(
              app: app,
              chartIndex: isDataTile ? 1 : 0,
            ),
          ),
        );
      },
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ApplicationIcon(app: app),

          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// App Name
              TitleText(app.name, size: 16, weight: FontWeight.normal),

              /// Apps Screen Time
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  final day = ref.watch(selectedDayProvider);

                  return SubtitleText(
                    isDataTile
                        ? app.dataUsageThisWeek[day].toData()
                        : app.screenTimeThisWeek[day].seconds.toTimeFull(),
                    size: 14,
                  );
                },
              ),
            ],
          ),

          const Spacer(),

          /// Timer picker button
          if (!isDataTile && !app.isImpSysApp)
            Consumer(
              builder: (context, ref, child) {
                final timer = ref.watch(deviceFocusProvider
                        .select((value) => value.appsTimer[app.packageName])) ??
                    0;

                return InteractiveCard(
                  padding: const EdgeInsets.all(10),
                  applyBorder: true,
                  child: timer > 0
                      ? TitleText(timer.seconds.toTimeShort(), size: 12)
                      : const Icon(FluentIcons.timer_20_regular),
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
            )
        ],
      ),
    );
  }
}
