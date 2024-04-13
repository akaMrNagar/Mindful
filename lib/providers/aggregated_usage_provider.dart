import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/aggregated_usage_model.dart';
import 'package:mindful/providers/apps_provider.dart';

/// Provides aggregated device usage based on day for current week.
/// This includes screen time, wifi usage, and mobile usage
final aggregatedUsageProvider = Provider<AggregatedUsageModel>((ref) {
  return ref.watch(appsProvider).when(
        data: (data) => AggregatedUsageModel.fromApps(data.values.toList()),
        error: (e, st) => const AggregatedUsageModel(),
        loading: () => const AggregatedUsageModel(),
      );
});
