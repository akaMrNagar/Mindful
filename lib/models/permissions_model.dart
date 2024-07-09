class PermissionsModel {
  final bool haveUsagePermission;
  final bool haveDndPermission;
  final bool haveDisplayOverayPermission;
  final bool haveBatteryOptimizationPermission;

  final bool haveVpnPermission;
  final bool haveAccessibilityPermission;

  PermissionsModel({
    this.haveUsagePermission = true,
    this.haveDndPermission = true,
    this.haveDisplayOverayPermission = true,
    this.haveBatteryOptimizationPermission = true,
    this.haveVpnPermission = true,
    this.haveAccessibilityPermission = true,
  });

  PermissionsModel copyWith({
    bool? haveUsagePermission,
    bool? haveDndPermission,
    bool? haveDisplayOverayPermission,
    bool? haveBatteryOptimizationPermission,
    bool? haveVpnPermission,
    bool? haveAccessibilityPermission,
  }) {
    return PermissionsModel(
      haveUsagePermission: haveUsagePermission ?? this.haveUsagePermission,
      haveDndPermission: haveDndPermission ?? this.haveDndPermission,
      haveDisplayOverayPermission:
          haveDisplayOverayPermission ?? this.haveDisplayOverayPermission,
      haveBatteryOptimizationPermission: haveBatteryOptimizationPermission ??
          this.haveBatteryOptimizationPermission,
      haveVpnPermission: haveVpnPermission ?? this.haveVpnPermission,
      haveAccessibilityPermission:
          haveAccessibilityPermission ?? this.haveAccessibilityPermission,
    );
  }
}
