import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/local_storage.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/models/device_focus.dart';

final deviceFocusProvider =
    StateNotifierProvider<DeviceFocusState, DeviceFocus>(
  (ref) => DeviceFocusState(),
);

class DeviceFocusState extends StateNotifier<DeviceFocus> {
  DeviceFocusState() : super(DeviceFocus(appTimers: {})) {
    state = state.copyWith(
      appTimers: LocalStorage.instance.loadAppTimers(),
    );
  }

  Future<bool> setAppTimer(String appPackage, int timer) async {
    state = state.copyWith(
      appTimers: state.appTimers
        ..update(
          appPackage,
          (value) => timer,
          ifAbsent: () => timer,
        ),
    );

    LocalStorage.instance.saveAppTimers(state.appTimers);
    MindfulNativePlugin.instance.restartTrackingService();
    return true;
  }
}
