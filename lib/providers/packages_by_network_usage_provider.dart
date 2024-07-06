import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/apps_provider.dart';

final packagesByNetworkUsageProvider =
    Provider.family<AsyncValue<List<String>>, FilterParams>((ref, params) {
  return ref.watch(appsProvider).when(
        loading: () => const AsyncLoading(),
        error: (e, st) => const AsyncLoading(),
        data: (appsMap) {
          /// Create list of apps
          var apps = appsMap.values.toList();

          /// Filter out apps if they haven't been used i.e, whose screen time is 0
          if (!params.includeAll) {
            apps.removeWhere(
                (e) => e.networkUsageThisWeek[params.dayOfWeek] == 0);
          }

          /// Repopulate apps list if list is empty after filtering out
          if (apps.isEmpty) apps = appsMap.values.toList();

          /// Sort apps
          apps.sort(
            (a, b) => b.networkUsageThisWeek[params.dayOfWeek]
                .compareTo(a.networkUsageThisWeek[params.dayOfWeek]),
          );

          /// Map the result
          return AsyncData(apps.map((e) => e.packageName).toList());
        },
      );
});
