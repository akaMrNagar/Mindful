import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/device_focus_provider.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard.dart';
import 'package:mindful/ui/widgets/application_icon.dart';
import 'package:mindful/ui/widgets/custom_text.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';
import 'package:mindful/ui/widgets/interactive_card.dart';

/// List tile used for displaying app usage info based on the bool [isDataTile]
class ApplicationTile extends ConsumerWidget {
  const ApplicationTile({
    super.key,
    required this.app,
    required this.isDataTile,
    required this.day,
  });

  final AndroidApp app;
  final bool isDataTile;
  final int day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(deviceFocusProvider
            .select((value) => value.appTimers[app.packageName])) ??
        0;

    return InteractiveCard(
      height: 72,
      applyBorder: true,
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => AppDashboard(app: app),
          ),
        );
      },
      margin: const EdgeInsets.only(bottom: 4, right: 6),
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
              SubtitleText(
                isDataTile
                    ? app.networkUsageThisWeek[day].toData()
                    : app.screenTimeThisWeek[day].seconds.toTimeFull(),
                size: 14,
              ),
            ],
          ),

          const Spacer(),

          /// Timer picker button
          if (!isDataTile && !app.isImpSysApp)
            InteractiveCard(
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
                          .setAppTimer(app.packageName, value);
                    }
                  },
                );
              },
            )
        ],
      ),
    );
  }
}
