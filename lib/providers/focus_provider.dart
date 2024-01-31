import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/focus_info.dart';

final focusProvider =
    StateNotifierProvider<AppsFocus, Map<String, FocusInfo>>((ref) {
  return AppsFocus();
});

class AppsFocus extends StateNotifier<Map<String, FocusInfo>> {
  AppsFocus() : super({});

  Future<bool> setAppTimer(String appPackage, int timer) async {
    // if (state.containsKey(appPackage) &&
    //     state[appPackage]!.profile != Constants.defaultProfile) return false;

    var newState = Map<String, FocusInfo>.from(state);

    if (timer <= 0) {
      newState.remove(appPackage);
    } else {
      newState.update(
        appPackage,
        (value) => value.copyWith(timer: timer),
        ifAbsent: () => FocusInfo(timer: timer),
      );
    }

    state = newState;

    // LocalStorage.instance.saveAppTimers(state.appTimers);
    // MindfulNativePlugin.instance.restartTrackingService();
    return true;
  }
}
