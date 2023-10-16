import 'package:flutter/foundation.dart';

@immutable
class DeviceFocusInfo {
  final Map<String, int> appsTimer;

  const DeviceFocusInfo({
    required this.appsTimer,
  });

  DeviceFocusInfo copyWith({
    Map<String, int>? appsTimer,
  }) {
    return DeviceFocusInfo(
      appsTimer: appsTimer ?? this.appsTimer,
    );
  }
}
