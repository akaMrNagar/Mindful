import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/providers/apps_provider.dart';

final packagesByScreenUsageProvider =
    Provider.family<AsyncValue<List<String>>, FilterArgs>((ref, params) {
  return ref.watch(appsProvider).when(
        loading: () => const AsyncLoading(),
        error: (e, st) => const AsyncLoading(),
        data: (appsMap) {
          /// Create list of apps
          var apps = appsMap.values.toList();

          /// Filter out apps if they haven't been used i.e, whose screen time is 0
          if (!params.includeAll) {
            apps.removeWhere(
                (e) => e.screenTimeThisWeek[params.selectedDoW] == 0);
          }

          /// Reassign apps if list is empty after filtering out
          if (apps.isEmpty) apps = appsMap.values.toList();

          /// Sort apps
          apps.sort(
            (a, b) => b.screenTimeThisWeek[params.selectedDoW]
                .compareTo(a.screenTimeThisWeek[params.selectedDoW]),
          );

          /// Map the result
          return AsyncData(apps.map((e) => e.packageName).toList());
        },
      );
});
