/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:drift/drift.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/config/app_constants.dart';

@DataClassName("MindfulSettings")
class MindfulSettingsTable extends Table {
  /// Unique ID for app settings
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Default theme mode for app
  IntColumn get themeMode => intEnum<AppThemeMode>()
      .withDefault(Constant(AppConstants.defaultThemeMode.index))();

  /// Default material color for app
  TextColumn get accentColor =>
      text().withDefault(const Constant(AppConstants.defaultMaterialColor))();

  /// Username shown on the dashboard
  TextColumn get username =>
      text().withDefault(const Constant(AppConstants.defaultUsername))();

  /// App Locale (Language code)
  TextColumn get localeCode =>
      text().withDefault(const Constant(AppConstants.defaultLocale))();

  /// Flag indicating if to use pure amoled black color for dark theme
  BoolColumn get useAmoledDark =>
      boolean().withDefault(const Constant(false))();

  /// Flag indicating if to use wallpaper colors for themes
  BoolColumn get useDynamicColors =>
      boolean().withDefault(const Constant(false))();

  /// Default initial home tab
  IntColumn get defaultHomeTab => intEnum<DefaultHomeTab>()
      .withDefault(Constant(DefaultHomeTab.dashboard.index))();

  /// Maximum number of weeks till the app's usage history will be kept
  IntColumn get usageHistoryWeeks => integer().withDefault(const Constant(4))();

  /// Number of emergency break passes left for today
  IntColumn get leftEmergencyPasses =>
      integer().withDefault(const Constant(3))();

  /// Timestamp of the last used emergency break
  DateTimeColumn get lastEmergencyUsed =>
      dateTime().withDefault(Constant(DateTime(0)))();

  /// Flag indicating if onboarding is completed or not
  BoolColumn get isOnboardingDone =>
      boolean().withDefault(const Constant(false))();

  /// The currently installed version of Mindful.
  /// Mainly used to show changelogs screen.
  TextColumn get appVersion => text().withDefault(const Constant(""))();
}
