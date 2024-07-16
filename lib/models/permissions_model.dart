class PermissionsModel {
  final bool haveUsagePermission;
  final bool haveDndPermission;
  final bool haveDisplayOverlayPermission;
  final bool haveBatteryOptimizationPermission;
  final bool haveVpnPermission;
  final bool haveAccessibilityPermission;
  final bool haveAdminPermission;

  PermissionsModel({
    this.haveUsagePermission = true,
    this.haveDndPermission = true,
    this.haveDisplayOverlayPermission = true,
    this.haveBatteryOptimizationPermission = true,
    this.haveVpnPermission = true,
    this.haveAccessibilityPermission = true,
    this.haveAdminPermission = true,
  });

  

  PermissionsModel copyWith({
    bool? haveUsagePermission,
    bool? haveDndPermission,
    bool? haveDisplayOverlayPermission,
    bool? haveBatteryOptimizationPermission,
    bool? haveVpnPermission,
    bool? haveAccessibilityPermission,
    bool? haveAdminPermission,
  }) {
    return PermissionsModel(
      haveUsagePermission: haveUsagePermission ?? this.haveUsagePermission,
      haveDndPermission: haveDndPermission ?? this.haveDndPermission,
      haveDisplayOverlayPermission: haveDisplayOverlayPermission ?? this.haveDisplayOverlayPermission,
      haveBatteryOptimizationPermission: haveBatteryOptimizationPermission ?? this.haveBatteryOptimizationPermission,
      haveVpnPermission: haveVpnPermission ?? this.haveVpnPermission,
      haveAccessibilityPermission: haveAccessibilityPermission ?? this.haveAccessibilityPermission,
      haveAdminPermission: haveAdminPermission ?? this.haveAdminPermission,
    );
  }
}
