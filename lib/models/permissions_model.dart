class PermissionsModel {
  final bool haveUsagePermission;
  final bool haveDndPermission;
  final bool haveDisplayOverayPermission;
  final bool haveBatteryOptimizationPermission;

  final bool isVpnServiceRunning;
  final bool isAccessibilityServiceRunning;

  PermissionsModel({
    this.haveUsagePermission = false,
    this.haveDndPermission = false,
    this.haveDisplayOverayPermission = false,
    this.haveBatteryOptimizationPermission = false,
    this.isVpnServiceRunning = false,
    this.isAccessibilityServiceRunning = false,
  });

  PermissionsModel copyWith({
    bool? haveUsagePermission,
    bool? haveDndPermission,
    bool? haveDisplayOverayPermission,
    bool? haveBatteryOptimizationPermission,
    bool? isVpnServiceRunning,
    bool? isAccessibilityServiceRunning,
  }) {
    return PermissionsModel(
      haveUsagePermission: haveUsagePermission ?? this.haveUsagePermission,
      haveDndPermission: haveDndPermission ?? this.haveDndPermission,
      haveDisplayOverayPermission:
          haveDisplayOverayPermission ?? this.haveDisplayOverayPermission,
      haveBatteryOptimizationPermission: haveBatteryOptimizationPermission ??
          this.haveBatteryOptimizationPermission,
      isVpnServiceRunning: isVpnServiceRunning ?? this.isVpnServiceRunning,
      isAccessibilityServiceRunning:
          isAccessibilityServiceRunning ?? this.isAccessibilityServiceRunning,
    );
  }
}
