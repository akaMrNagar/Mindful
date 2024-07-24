class AppTags {
  /// Tag used to identify the invincible mode setting.
  static const invincibleModeTileTag = "settings.general.invincibleModeTile";

  /// Tag used to identify the short content timer picker.
  static const shortContentTimerPickerTag = "home.wellBeing.shortsTimerPicker";

  /// Tag used to identify the emergency FAB (floating action button).
  static const emergencyFABTag = "home.dashboard.useEmergency";

  /// Tag used to identify the FAB for adding a distracting website.
  static const addDistractingSiteFABTag =
      "home.wellBeing.addDistractingWebsite";

  /// Generates a tag for an application tile based on the provided package name.
  static String applicationTileTag(String package) =>
      "home.statistics.applicationTile.$package";

  /// Generates a tag for an app timer tile based on the provided package name.
  static String appTimerTileTag(String package) =>
      "appDashboard.timerTile.$package";

  /// Generates a tag for a website tile based on the provided host name.
  static String websiteTileTag(String host) =>
      "home.wellBeing.websiteTile.$host";
}
