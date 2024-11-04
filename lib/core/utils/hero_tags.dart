/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

class HeroTags {
  /// Tag used to identify the beta warning container
  static const betaWarningTag = "mindful.appbar.betaWarning";

  /// Tag used to identify the FAB for adding a distracting website.
  static const editUsernameTag = "home.dashboard.editUsername";

  /// Tag used to identify the invincible mode tile.
  static const invincibleModeTileTag = "home.dashboard.invincibleModeTile";

  /// Generates a tag for an application tile based on the provided package name.
  static String applicationTileTag(String package) =>
      "home.statistics.applicationTile.$package";

  /// Tag used to identify the short content timer picker.
  static const shortContentTimerPickerTag = "home.wellBeing.shortsTimerPicker";

  /// Tag used to identify the block NSFW sites tile in wellbeing tab.
  static const blockNsfwTileTag = "home.wellBeing.blockNsfwTile";

  /// Tag used to identify the FAB for adding a distracting website.
  static const addDistractingSiteFABTag =
      "home.wellBeing.addDistractingWebsite";

  /// Generates a tag for a website tile based on the provided host name.
  static String websiteTileTag(String host) =>
      "home.wellBeing.websiteTile.$host";

  /// Tag used to identify the emergency tile in app dashboard screen.
  static const emergencyTileTag = "appDashboard.useEmergencyTile";

  /// Generates a tag for an app timer tile based on the provided package name.
  static String appTimerTileTag(String package) =>
      "appDashboard.timerTile.$package";

  /// Generates a tag for an app launch limit tile based on the provided package name.
  static String appLaunchLimitTileTag(String package) =>
      "appDashboard.launchLimitTile.$package";

  /// Generates a tag for an app session and cooldown tile based on the provided package name.
  static String appSessionAndCooldownTileTag(String package) =>
      "appDashboard.sessionAndCooldownTile.$package";

  /// Tag used to identify the FAB for timer picker in focus mode.
  static const focusModeTimerTileTag = "focus.focusSessionTimerTile";

  /// Tag used to identify the FAB for timer picker in focus mode.
  static const giveUpFocusSessionTag = "activeSession.giveUp";

  /// Tag used to identify the tile for clearing crash log in settings.
  static const clearCrashLogsTileTag = "settings.advance.clearCrashLogs";

  /// Tag used to identify the remove button in a restriction group card based on the group ID.
  static String removeRestrictionGroupTag(int groupId) =>
      "restrictionGroupScreen.restrictionGroup.$groupId";
}
