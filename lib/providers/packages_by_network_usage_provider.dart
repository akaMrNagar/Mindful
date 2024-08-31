/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/providers/apps_provider.dart';

/// A Riverpod provider that filters and sorts apps based on network usage for a specific day of the week.
/// 
/// This provider takes a `FilterArgs` argument that defines filtering options.
final packagesByNetworkUsageProvider = Provider.family<AsyncValue<List<String>>, FilterArgs>(
  (ref, params) {
  // Watch the appsProvider state
  return ref.watch(appsProvider).when(
    loading: () => const AsyncLoading(),
    error: (e, st) => AsyncError(e, st),
    data: (appsMap) {
      /// Create list of apps from the map
      var apps = appsMap.values.toList();

      /// Filter out apps with no usage for the selected day
      if (!params.includeAll) {
        apps.removeWhere((e) => e.networkUsageThisWeek[params.selectedDoW] == 0);
      }

      /// Repopulate list if empty after filtering (avoid empty result)
      if (apps.isEmpty) apps = appsMap.values.toList();

      /// Sort apps based on network usage for the selected day (descending)
      apps.sort(
        (a, b) => b.networkUsageThisWeek[params.selectedDoW].compareTo(a.networkUsageThisWeek[params.selectedDoW]),
      );

      /// Map the sorted apps to a list of package names
      return AsyncData(apps.map((e) => e.packageName).toList());
    },
  );
});
