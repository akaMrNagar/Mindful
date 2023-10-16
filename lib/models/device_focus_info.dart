import 'package:flutter/foundation.dart';

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
