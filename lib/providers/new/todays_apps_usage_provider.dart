import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/usage_model.dart';

/// A state notifier provider that manages a map of Package and installed Android applications and respected usage for today.
final todaysAppsUsageProvider = StateNotifierProvider<TodaysUsageNotifier,
    AsyncValue<Map<String, UsageModel>>>(
  (ref) => TodaysUsageNotifier(),

  /// FIXME: Ignore usage from excluded apps
);

class TodaysUsageNotifier
    extends StateNotifier<AsyncValue<Map<String, UsageModel>>> {
  TodaysUsageNotifier() : super(const AsyncLoading()) {
    refreshTodaysUsage();
  }

  /// Fetches and updates apps usage for today.
  Future<void> refreshTodaysUsage() async {
    final usageMap =
        await MethodChannelService.instance.fetchAppsUsageForInterval(
      start: dateToday,
      end: DateTime.now(),
    );

    state = AsyncData(usageMap);
  }
}
