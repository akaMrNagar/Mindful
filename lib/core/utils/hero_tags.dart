class HeroTags {
  /// Tag used to identify the invincible mode setting.
  static const invincibleModeTileTag = "settings.general.invincibleModeTile";

  /// Tag used to identify the beta warning container
  static const betaWarningTag = "mindful.appbar.betaWarning";

  /// Tag used to identify the short content timer picker.
  static const shortContentTimerPickerTag = "home.wellBeing.shortsTimerPicker";

  /// Tag used to identify the emergency tile in app dashboard screen.
  static const emergencyTileTag = "appDashboard.useEmergencyTile";

  /// Tag used to identify the block NSFW sites tile in wellbeing tab.
  static const blockNsfwTileTag = "home.wellBeing.blockNsfwTile";

  /// Tag used to identify the FAB for adding a distracting website.
  static const addDistractingSiteFABTag =
      "home.wellBeing.addDistractingWebsite";

  /// Tag used to identify the FAB for timer picker in focus mode.
  static const focusModeFABTag = "focus.focusSessionTimer";

  /// Generates a tag for an application tile based on the provided package name.
  static String applicationTileTag(String package) =>
      "home.statistics.applicationTile.$package";

  /// Generates a tag for an app timer tile based on the provided package name.
  static String appTimerTileTag(String package) =>
      "appDashboard.timerTile.$package";

  /// Generates a tag for a website tile based on the provided host name.
  static String websiteTileTag(String host) =>
      "home.wellBeing.websiteTile.$host";
 
  /// Tag used to identify the FAB for timer picker in focus mode.
  static const giveUpFocusSessionTag = "activeSession.giveUp";
}
