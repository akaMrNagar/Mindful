import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/device_usage_info.dart';
import 'package:mindful/providers/apps_provider.dart';

final deviceUsageProvider = Provider<DeviceUsageInfo>((ref) {
  return ref.watch(appsProvider).when(
        data: (data) => DeviceUsageInfo.fromApps(data),
        error: (e, st) => const DeviceUsageInfo(),
        loading: () => const DeviceUsageInfo(),
      );
});
