import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/selectable_app_tile.dart';

class DistractingAppsList extends ConsumerWidget {
  const DistractingAppsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distractingApps =
        ref.watch(bedtimeProvider.select((v) => v.distractionApps));

    return AnimatedAppsList(
      itemExtent: 56,
      selectedDoW: dayOfWeek,
      usageType: UsageType.screenUsage,
      sortApps: (apps) {
        return [
          ...apps.where((e) => distractingApps.contains(e)),
          ...apps.where((e) => !distractingApps.contains(e)),
        ];
      },
      itemBuilder: (context, appPackage) => SelectableAppTile(
        appPackage: appPackage,
        isSelected: distractingApps.contains(appPackage),
        onSelect: () =>
            ref.read(bedtimeProvider.notifier).addDistractionApp(appPackage),
        onDeselect: () =>
            ref.read(bedtimeProvider.notifier).removeDistractionApp(appPackage),
      ),
    );
  }
}
