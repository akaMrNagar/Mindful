import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/focus_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/common/application_icon.dart';
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
    /// Watch timer for the package
    final timer = ref.watch(
            focusProvider.select((value) => value[app.packageName]?.timer)) ??
        0;

    return DefaultListTile(
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => AppDashboardScreen(app: app),
          ),
        );
      },

      /// App icon
      leading: ApplicationIcon(app: app),

      /// App Name
      titleText: app.name,

      /// App's Screen Time OR Data Usage
      subtitle: StyledText(
        usageType == UsageType.networkUsage
            ? app.networkUsageThisWeek[day].toData()
            : app.screenTimeThisWeek[day].seconds.toTimeFull(),
        fontSize: 14,
        color: Theme.of(context).hintColor,
      ),

      /// Timer picker button
      trailing: (!app.isImpSysApp)
          ? IconButton(
              icon: timer > 0
                  ? Text(timer.seconds.toTimeShort())
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
                          .updateAppTimer(app.packageName, value);
                    }
                  },
                );
              },
            )
          : null,
    );
  }
}
