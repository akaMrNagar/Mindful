import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/providers/focus_provider.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';

/// List tile used for displaying app usage info based on the bool [usageType]
class ApplicationTile extends ConsumerWidget {
  const ApplicationTile({
    super.key,
    required this.appPackage,
    required this.usageType,
    required this.day,
  });

  final String appPackage;
  final UsageType usageType;
  final int day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Read the app package entry
    final app = ref.read(appsProvider).value?[appPackage];

    /// Return sizebox if app is null which will always be false
    if (app == null) return const SizedBox();

    /// Watch timer for the package
    final timer =
        ref.watch(focusProvider.select((value) => value[appPackage]?.timer)) ??
            0;

    return RoundedContainer(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => AppDashboardScreen(app: app),
          ),
        );
      },
      child: ListTileSkeleton(
        /// App icon
        leading: ApplicationIcon(app: app),

        /// App Name
        title: StatefulText(
          app.name,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),

        /// App's Screen Time OR Data Usage
        subtitle: StatefulText(
          usageType == UsageType.networkUsage
              ? app.networkUsageThisWeek[day].toData()
              : app.screenTimeThisWeek[day].seconds.toTimeFull(),
          fontSize: 13,
          activeColor: Theme.of(context).hintColor,
        ),

        /// Timer picker button
        trailing: (usageType == UsageType.screenUsage && !app.isImpSysApp)
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
                            .setAppTimer(app.packageName, value);
                      }
                    },
                  );
                },
              )
            : null,
      ),
    );
  }
}
