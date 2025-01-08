/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/sorting_type.dart';
import 'package:mindful/models/filter_model.dart';
import 'package:mindful/providers/apps_provider.dart';

/// A Riverpod provider that filters and sorts app packages based on [FilterModel]
final packagesByFilterProvider =
    Provider.family<AsyncValue<List<String>>, FilterModel>((ref, filter) {
  // Watch the appsProvider state
  return ref.watch(appsProvider).when(
        loading: () => const AsyncLoading(),
        error: (e, st) => AsyncError(e, st),
        data: (appsMap) {
          /// Create list of apps from the map with searching
          var apps = appsMap.values.toList();

          /// Filter by query
          if (filter.query.isNotEmpty) {
            apps.removeWhere(
              (e) => !e.name.toLowerCase().contains(filter.query.toLowerCase()),
            );
          }

          /// Filter out apps with no usage for the selected day
          if (!filter.includeAll) {
            apps.removeWhere((e) =>
                (filter.sorting == SortingType.network
                    ? e.networkUsageThisWeek[filter.selectedDayOfWeek]
                    : e.screenTimeThisWeek[filter.selectedDayOfWeek]) ==
                0);
          }

          /// Repopulate list if empty after filtering (avoid empty result)
          if (apps.isEmpty) apps = appsMap.values.toList();

          /// Sort apps based on sorting type for the selected day (descending)
          switch (filter.sorting) {
            case SortingType.screen:
              apps.sort(
                (a, b) => b.screenTimeThisWeek[filter.selectedDayOfWeek]
                    .compareTo(a.screenTimeThisWeek[filter.selectedDayOfWeek]),
              );
              break;

            case SortingType.network:
              apps.sort(
                (a, b) => b.networkUsageThisWeek[filter.selectedDayOfWeek]
                    .compareTo(
                        a.networkUsageThisWeek[filter.selectedDayOfWeek]),
              );
              break;

            case SortingType.alphabetic:
              apps.sort(
                (a, b) => a.name.compareTo(b.name),
              );
              break;
          }

          /// Reverse if needed
          if (filter.reverse) {
            apps = apps.reversed.toList();
          }

          /// Map the sorted apps to a list of package names
          return AsyncData(apps.map((e) => e.packageName).toList());
        },
      );
});
