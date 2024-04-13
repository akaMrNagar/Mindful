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

          /// Sort apps
          apps.sort(
            (a, b) => b.networkUsageThisWeek[params.dayOfWeek]
                .compareTo(a.networkUsageThisWeek[params.dayOfWeek]),
          );

          /// Filter out apps if they haven't used internet i.e, whose network usage is 0
          if (!params.includeAll) {
            apps = apps
                .where((e) => e.networkUsageThisWeek[params.dayOfWeek] > 0)
                .toList();
          }

          /// Map the result
          return AsyncData(apps.map((e) => e.packageName).toList());
        },
      );
});
