import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/focus_provider.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard.dart';
import 'package:mindful/ui/widgets/application_icon.dart';
import 'package:mindful/ui/widgets/custom_list_tile.dart';
import 'package:mindful/ui/widgets/custom_text.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';

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
    final timer = ref.watch(
            focusProvider.select((value) => value[app.packageName]?.timer)) ??
        0;

    return CustomListTile(
      margin: const EdgeInsets.only(bottom: 4, right: 6),
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => AppDashboard(app: app),
          ),
        );
      },
      leading: ApplicationIcon(app: app),

      /// App Name
      title: TitleText(app.name, size: 16, weight: FontWeight.normal),

      /// App's Screen Time OR Data Usage
      subTitle: SubtitleText(
        isDataTile
            ? app.networkUsageThisWeek[day].toData()
            : app.screenTimeThisWeek[day].seconds.toTimeFull(),
        size: 14,
      ),

      /// Timer picker button
      trailing: (!isDataTile && !app.isImpSysApp)
          ? IconButton(
              icon: timer > 0
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
                          .read(focusProvider.notifier)
                          .setAppTimer(app.packageName, value);
                    }
                  },
                );
              },
            )
          : null,
    );
  }
}
