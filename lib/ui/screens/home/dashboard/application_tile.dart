import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/app_focus_infos_provider.dart';
import 'package:mindful/ui/common/components/rounded_list_tile.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard.dart';
import 'package:mindful/ui/common/components/application_icon.dart';
import 'package:mindful/ui/common/custom_text.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';

/// List tile used for displaying app usage info based on the bool [usageType]
class ApplicationTile extends ConsumerWidget {
  const ApplicationTile({
    super.key,
    required this.app,
    required this.usageType,
    required this.day,
  });

  final AndroidApp app;
  final UsageType usageType;
  final int day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(appFocusInfosProvider
            .select((value) => value[app.packageName]?.timer)) ??
        0;

    return RoundedListTile(
      color: Colors.transparent,
      borderColor: Theme.of(context).hoverColor,
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => AppDashboard(app: app),
          ),
        );
      },

      /// App icon
      leading: ApplicationIcon(app: app),

      /// App Name
      title: TitleText(app.name, size: 16, weight: FontWeight.normal),

      /// App's Screen Time OR Data Usage
      subTitle: SubtitleText(
        usageType == UsageType.networkUsage
            ? app.networkUsageThisWeek[day].toData()
            : app.screenTimeThisWeek[day].seconds.toTimeFull(),
        size: 14,
      ),

      /// Timer picker button
      trailing: (usageType == UsageType.screenUsage && !app.isImpSysApp)
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
                          .read(appFocusInfosProvider.notifier)
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
