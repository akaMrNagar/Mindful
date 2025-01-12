import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/providers/shared_unique_data_provider.dart';

/// A state notifier provider that manages a map of Package and installed Android applications and respected usage for today.
final todaysAppsUsageProvider = StateNotifierProvider<TodaysUsageNotifier,
    AsyncValue<Map<String, UsageModel>>>(
  (ref) => TodaysUsageNotifier(
    ref.watch(sharedUniqueDataProvider.select((v) => v.excludedApps)),
  ),
);

class TodaysUsageNotifier
    extends StateNotifier<AsyncValue<Map<String, UsageModel>>> {
  final List<String> excludedApps;

  TodaysUsageNotifier(this.excludedApps) : super(const AsyncLoading()) {
    refreshTodaysUsage();
  }

  /// Fetches and updates apps usage for today.
  Future<void> refreshTodaysUsage() async {
    final usageMap =
        await MethodChannelService.instance.fetchAppsUsageForInterval(
      start: dateToday,
      end: DateTime.now(),
    );

    usageMap.removeWhere((k, v) => excludedApps.contains(k));
    if (mounted) state = AsyncData(usageMap);
  }
}
