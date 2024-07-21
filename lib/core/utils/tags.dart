class AppTags {
  static const invincibleModeTag = "settings.service.invincibleMode";
  static const shortContentTimerPickerTag = "home.wellBeing.shortsTimerPicker";
  static const emergencyFABTag =
      "home.dashboard.useEmergency";

  static const addDistractingSiteFABTag =
      "home.wellBeing.addDistractingWebsite";

  static const pasteDistractingSiteFABTag =
      "home.wellBeing.pasteDistractingWebsite";

  static String applicationTileTag(String package) =>
      "home.statistics.applicationTile.$package";

  static String appTimerTileTag(String package) =>
      "appDashboard.timerTile.$package";

  static String websiteTileTag(String host) =>
      "home.wellBeing.websiteTile.$host";
}
