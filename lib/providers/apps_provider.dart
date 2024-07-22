import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/android_app.dart';

final appsProvider =
    StateNotifierProvider<DeviceAppsList, AsyncValue<Map<String, AndroidApp>>>(
  (ref) => DeviceAppsList(),
);

class DeviceAppsList
    extends StateNotifier<AsyncValue<Map<String, AndroidApp>>> {
  DeviceAppsList() : super(const AsyncLoading()) {
    /// initialization
    refreshDeviceApps();
  }

  /// Refresh list of [AndroidApp] including their usage
  Future<bool> refreshDeviceApps() async {
    final appsList = await MethodChannelService.instance.getDeviceApps();
    state = AsyncData(
      Map.fromEntries(
        appsList.map((e) => MapEntry(e.packageName, e)),
      ),
    );
    return true;
  }
}
