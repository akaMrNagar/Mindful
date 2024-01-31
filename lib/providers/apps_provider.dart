import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/models/android_app.dart';

final appsProvider =
    StateNotifierProvider<DeviceAppsList, AsyncValue<Map<String, AndroidApp>>>(
  (ref) => DeviceAppsList(),
);

class DeviceAppsList
    extends StateNotifier<AsyncValue<Map<String, AndroidApp>>> {
  DeviceAppsList() : super(const AsyncValue.loading()) {
    /// inititalization
    refreshDeviceApps();
  }

  /// Refresh list of [AndroidApp] including their usage
  Future<bool> refreshDeviceApps() async {
    await MindfulNativePlugin.instance.getDeviceApps().then(
          (value) => state = AsyncData(
            Map.fromEntries(value.map((e) => MapEntry(e.packageName, e))),
          ),
        );
    return true;
  }
}
