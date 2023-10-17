import 'package:flutter/foundation.dart';


/// Responsible for data related to app or device focus like app timers,
/// bedtime schedules, and more.
@immutable
class DeviceFocusInfo {
  /// Map of app packages and their timer [in Seconds]
  final Map<String, int> appsTimer;

  const DeviceFocusInfo({
    this.appsTimer = const {},
  });

  DeviceFocusInfo copyWith({
    Map<String, int>? appsTimer,
  }) {
    return DeviceFocusInfo(
      appsTimer: appsTimer ?? this.appsTimer,
    );
  }
}
