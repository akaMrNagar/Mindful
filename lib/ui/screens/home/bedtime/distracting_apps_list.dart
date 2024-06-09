import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/providers/packages_by_screen_usage_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/async_error_indicator.dart';
import 'package:mindful/ui/common/async_loading_indicator.dart';
import 'package:mindful/ui/common/checkbox_app_tile.dart';

class DistractingAppsList extends ConsumerWidget {
  const DistractingAppsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distractingApps =
        ref.watch(bedtimeProvider.select((v) => v.distractingApps));

    /// Parameters for family provider
    final params = (dayOfWeek: dayOfWeek, includeAll: true);
    final allApps = ref.watch(packagesByScreenUsageProvider(params));

    return allApps.when(
      loading: () => const AsyncLoadingIndicator().toSliverBox(),
      error: (e, st) => AsyncErrorIndicator(e, st).toSliverBox(),
      data: (apps) => AnimatedAppsList(
        itemExtent: 56,
        headerTitle: "Select distracting apps",
        appPackages: [
          ...apps.where((e) => distractingApps.contains(e)),
          if (distractingApps.isNotEmpty) ...["divider"],
          ...apps.where((e) => !distractingApps.contains(e)),
        ],
        itemBuilder: (context, app) => CheckboxAppTile(
          app: app,
          isSelected: distractingApps.contains(app.packageName),
          onSelectionChanged: (v) => ref
              .read(bedtimeProvider.notifier)
              .insertRemoveDistractingApp(app.packageName, v),
        ),
      ),
    );
  }
}
