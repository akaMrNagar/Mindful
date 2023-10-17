import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/device_usage_info.dart';
import 'package:mindful/providers/apps_provider.dart';

/// Provides aggregated device usage based on day for current week.
/// This includes screen time, wifi usage, and mobile usage
final deviceUsageProvider = Provider<DeviceUsageInfo>((ref) {
  return ref.watch(appsProvider).when(
        data: (data) => DeviceUsageInfo.fromApps(data),
        error: (e, st) => const DeviceUsageInfo(),
        loading: () => const DeviceUsageInfo(),
      );
});
