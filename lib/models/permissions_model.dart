class PermissionsModel {
  /// Indicates whether the notification permission is granted.
  final bool haveNotificationPermission;

  /// Indicates whether the usage access permission is granted.
  final bool haveUsageAccessPermission;

  /// Indicates whether the Do Not Disturb (DND) permission is granted.
  final bool haveDndPermission;

  /// Indicates whether the display overlay permission is granted.
  final bool haveDisplayOverlayPermission;

  /// Indicates whether the VPN permission is granted.
  final bool haveVpnPermission;

  /// Indicates whether the accessibility permission is granted.
  final bool haveAccessibilityPermission;

  /// Indicates whether the admin permission is granted.
  final bool haveAdminPermission;

  /// Indicates whether the set exact alarm permission is granted.
  final bool haveAlarmsPermission;

  /// Indicates whether the ignore battery optimization permission is granted.
  final bool haveIgnoreOptimizationPermission;

  const PermissionsModel({
    this.haveNotificationPermission = true,
    this.haveUsageAccessPermission = true,
    this.haveDndPermission = true,
    this.haveDisplayOverlayPermission = true,
    this.haveVpnPermission = true,
    this.haveAccessibilityPermission = true,
    this.haveAdminPermission = true,
    this.haveAlarmsPermission = true,
    this.haveIgnoreOptimizationPermission = true,
  });

  /// Creates a copy of the `PermissionsModel` with potentially modified permissions.
  PermissionsModel copyWith({
    bool? haveNotificationPermission,
    bool? haveUsageAccessPermission,
    bool? haveDndPermission,
    bool? haveDisplayOverlayPermission,
    bool? haveVpnPermission,
    bool? haveAccessibilityPermission,
    bool? haveAdminPermission,
    bool? haveAlarmsPermission,
    bool? haveIgnoreOptimizationPermission,
  }) {
    return PermissionsModel(
      haveNotificationPermission:
          haveNotificationPermission ?? this.haveNotificationPermission,
      haveUsageAccessPermission:
          haveUsageAccessPermission ?? this.haveUsageAccessPermission,
      haveDndPermission: haveDndPermission ?? this.haveDndPermission,
      haveDisplayOverlayPermission:
          haveDisplayOverlayPermission ?? this.haveDisplayOverlayPermission,
      haveVpnPermission: haveVpnPermission ?? this.haveVpnPermission,
      haveAccessibilityPermission:
          haveAccessibilityPermission ?? this.haveAccessibilityPermission,
      haveAdminPermission: haveAdminPermission ?? this.haveAdminPermission,
      haveAlarmsPermission: haveAlarmsPermission ?? this.haveAlarmsPermission,
      haveIgnoreOptimizationPermission: haveIgnoreOptimizationPermission ??
          this.haveIgnoreOptimizationPermission,
    );
  }
}
