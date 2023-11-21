import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/aggregated_usage.dart';
import 'package:mindful/providers/apps_provider.dart';

/// Provides aggregated device usage based on day for current week.
/// This includes screen time, wifi usage, and mobile usage
final aggregatedUsageProvider = Provider<AggregatedUsage>((ref) {
  return ref.watch(appsProvider).when(
        data: (data) => AggregatedUsage.fromApps(data.values.toList()),
        error: (e, st) => const AggregatedUsage(),
        loading: () => const AggregatedUsage(),
      );
});
