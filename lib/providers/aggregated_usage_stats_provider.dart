import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/aggregated_usage_stats_model.dart';
import 'package:mindful/providers/apps_provider.dart';

/// Provides aggregated device usage based on day for current week.
/// This includes screen time, wifi usage, and mobile usage
final aggregatedUsageStatsProvider = Provider<AggregatedUsageStatsModel>((ref) {
  return ref.watch(appsProvider).when(
        data: (data) =>
            AggregatedUsageStatsModel.fromApps(data.values.toList()),
        error: (e, st) => const AggregatedUsageStatsModel(),
        loading: () => const AggregatedUsageStatsModel(),
      );
});
