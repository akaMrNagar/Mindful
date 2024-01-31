import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/selected_day_provider.dart';

final sortByTimeProvider = StateProvider.autoDispose<bool>((ref) => true);

final sortedAppsProvider = Provider.autoDispose
    .family<AsyncValue<List<String>>, bool>((ref, includeAll) {
  return ref.watch(appsProvider).when(
        loading: () => const AsyncLoading(),
        error: (_, __) => const AsyncLoading(),
        data: (appsMap) {
          final day = ref.watch(selectedDayProvider);
          final sortBytime = ref.watch(sortByTimeProvider);
          var apps = appsMap.values.toList();

          if (!includeAll) {
            apps = apps
                .where(
                  (e) => sortBytime
                      ? e.screenTimeThisWeek[day] > 0
                      : e.networkUsageThisWeek[day] > 0,
                )
                .toList();
          }

          if (sortBytime) {
            apps.sort(
              (a, b) => b.screenTimeThisWeek[day]
                  .compareTo(a.screenTimeThisWeek[day]),
            );
          } else {
            apps.sort(
              (a, b) => b.networkUsageThisWeek[day]
                  .compareTo(a.networkUsageThisWeek[day]),
            );
          }

          return AsyncData(apps.map((e) => e.packageName).toList());
        },
      );
});
