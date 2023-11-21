class DeviceFocus {
  final Map<String, int> appTimers;

  DeviceFocus({
    required this.appTimers,
  });

  DeviceFocus copyWith({
    Map<String, int>? appTimers,
  }) {
    return DeviceFocus(
      appTimers: appTimers ?? this.appTimers,
    );
  }
}
