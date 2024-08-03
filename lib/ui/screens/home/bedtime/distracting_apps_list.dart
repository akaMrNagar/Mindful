import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/providers/packages_by_screen_usage_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DistractingAppsList extends ConsumerWidget {
  const DistractingAppsList({
    super.key,
  });

  void _insertRemoveDistractingApp(
    WidgetRef ref,
    BuildContext context,
    AndroidApp app,
    bool shouldInsert,
  ) async {
    /// If app is important system app
    if (app.isImpSysApp) {
      context.showSnackAlert(
        "Adding important system apps to the list of distracting apps is not permitted.",
      );
      return;
    }

    /// If bedtime schedule is active or ON
    if (ref.read(bedtimeProvider).isScheduleOn) {
      context.showSnackAlert(
        "Modifications to the list of distracting apps is not permitted while the bedtime schedule is active.",
      );
      return;
    }

    ref
        .read(bedtimeProvider.notifier)
        .insertRemoveDistractingApp(app.packageName, shouldInsert);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distractingApps =
        ref.watch(bedtimeProvider.select((v) => v.distractingApps));

    /// Arguments for family provider
    final args = (selectedDoW: todayOfWeek, includeAll: true);
    final allApps = ref.watch(packagesByScreenUsageProvider(args));

    return MultiSliver(
      children: [
        const SliverContentTitle(title: "Selected apps"),

        /// Most used apps list
        SliverAnimatedSwitcher(
          duration: 300.ms,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: allApps.hasValue
              ? AnimatedAppsList(
                  itemExtent: 56,
                  separatorTitle: "Select distracting apps",
                  appPackages: [
                    /// Selected apps which are installed
                    ...distractingApps.where((e) => allApps.value!.contains(e)),

                    /// Will act as a separator
                    if (distractingApps.isNotEmpty) ...[""],

                    /// Unselected apps which are installed
                    ...allApps.value!
                        .where((e) => !distractingApps.contains(e)),
                  ],
                  itemBuilder: (context, app) {
                    final isSelected =
                        distractingApps.contains(app.packageName);
                    return DefaultListTile(
                      isSelected: app.isImpSysApp ? null : isSelected,
                      leading: ApplicationIcon(
                        app: app,
                        isGreyedOut: isSelected,
                        size: 16,
                      ),
                      titleText: app.name,
                      onPressed: () => _insertRemoveDistractingApp(
                        ref,
                        context,
                        app,
                        !isSelected,
                      ),
                    );
                  },
                )
              : const SliverShimmerList(includeSubtitle: true),
        ),
      ],
    );
  }
}
