class PermissionsModel {
  final bool haveNotificationPermission;
  final bool haveUsageAccessPermission;
  final bool haveDndPermission;
  final bool haveDisplayOverlayPermission;
  final bool haveVpnPermission;
  final bool haveAccessibilityPermission;
  final bool haveAdminPermission;

  PermissionsModel({
    this.haveNotificationPermission = true,
    this.haveUsageAccessPermission = true,
    this.haveDndPermission = true,
    this.haveDisplayOverlayPermission = true,
    this.haveVpnPermission = true,
    this.haveAccessibilityPermission = true,
    this.haveAdminPermission = true,
  });

  PermissionsModel copyWith({
    bool? haveNotificationPermission,
    bool? haveUsageAccessPermission,
    bool? haveDndPermission,
    bool? haveDisplayOverlayPermission,
    bool? haveVpnPermission,
    bool? haveAccessibilityPermission,
    bool? haveAdminPermission,
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
    );
  }
}
