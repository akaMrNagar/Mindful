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
import 'package:mindful/models/aggregated_usage_stats_model.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/shared_unique_data_provider.dart';

/// Provides aggregated device usage based on day for current week.
/// This includes screen time, wifi usage, and mobile usage
final aggregatedUsageStatsProvider = Provider<AggregatedUsageStatsModel>((ref) {
  return ref.watch(appsProvider).when(
        data: (data) => AggregatedUsageStatsModel.fromApps(
          data.values.toList(),
          ref.watch(sharedUniqueDataProvider.select((v) => v.excludedApps)),
        ),
        error: (e, st) => const AggregatedUsageStatsModel(),
        loading: () => const AggregatedUsageStatsModel(),
      );
});
