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
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/models/usage_filter_model.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/providers/usage/dated_apps_usage_provider.dart';

/// A provider that filters and sorts app packages based on [UsageFilterModel]
final filteredPackagesProvider =
    Provider.family<AsyncValue<List<String>>, UsageFilterModel>((ref, filter) {
  /// Watch app's usage for selected day
  final appsUsage =
      ref.watch(appsUsageProvider(filter.selectedDay)).value ?? {};

  // Watch the app infos provider
  return ref.watch(appsInfoProvider).when(
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
            switch (filter.usageType) {
              case UsageType.screenUsage:
                apps.removeWhere(
                  (e) => ((appsUsage[e.packageName]?.screenTime ?? 0) == 0),
                );
                break;
              case UsageType.networkUsage:
                apps.removeWhere(
                  (e) => ((appsUsage[e.packageName]?.totalData ?? 0) == 0),
                );
                break;
              default:
            }
          }

          /// Repopulate list if empty after filtering (avoid empty result)
          if (apps.isEmpty) apps = appsMap.values.toList();

          /// If alphabetically is true the sort alphabetically,
          /// otherwise Sort apps based on usage  (descending)
          switch (filter.usageType) {
            case UsageType.alphabetic:
              apps.sort((a, b) => a.name.compareTo(b.name));
              break;
            case UsageType.screenUsage:
              apps.sort(
                (a, b) => (appsUsage[b.packageName]?.screenTime ?? 0)
                    .compareTo(appsUsage[a.packageName]?.screenTime ?? 0),
              );
              break;
            case UsageType.networkUsage:
              apps.sort(
                (a, b) => (appsUsage[b.packageName]?.totalData ?? 0)
                    .compareTo(appsUsage[a.packageName]?.totalData ?? 0),
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
