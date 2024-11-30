/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/converters/list_converters.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/utils/app_constants.dart';

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

  /// Daily data usage renew or reset time [TimeOfDay] stored as minutes
  IntColumn get dataResetTime => integer()
      .map(const TimeOfDayAdapterConverter())
      .withDefault(const Constant(0))();

  /// Flag indicating if to use bottom navigation or the default sidebar
  BoolColumn get useBottomNavigation =>
      boolean().withDefault(const Constant(false))();

  /// Flag indicating if to use pure amoled black color for dark theme
  BoolColumn get useAmoledDark =>
      boolean().withDefault(const Constant(false))();

  /// Flag indicating if to use wallpaper colors for themes
  BoolColumn get useDynamicColors =>
      boolean().withDefault(const Constant(false))();

  /// Default initial home tab
  IntColumn get defaultHomeTab => intEnum<DefaultHomeTab>()
      .withDefault(Constant(DefaultHomeTab.dashboard.index))();

  /// List of app's packages which are excluded from the aggregated usage statistics.
  TextColumn get excludedApps => text()
      .map(const ListStringConverter())
      .withDefault(Constant(jsonEncode([])))();

  /// Number of emergency break passes left for today
  IntColumn get leftEmergencyPasses =>
      integer().withDefault(const Constant(3))();

  /// Timestamp of the last used emergency break
  DateTimeColumn get lastEmergencyUsed =>
      dateTime().withDefault(Constant(DateTime(0)))();

  /// Flag indicating if onboarding is completed or not
  BoolColumn get isOnboardingDone =>
      boolean().withDefault(const Constant(false))();

  /// Flag indicating whether to authenticate before opening Mindful or not
  BoolColumn get protectedAccess =>
      boolean().withDefault(const Constant(false))();

  /// Daily uninstall window start time [TimeOfDay] stored as minutes
  IntColumn get uninstallWindowTime => integer()
      .map(const TimeOfDayAdapterConverter())
      .withDefault(const Constant(0))();

  static final defaultMindfulSettingsModel = MindfulSettings(
    id: 0,
    defaultHomeTab: DefaultHomeTab.dashboard,
    themeMode: AppConstants.defaultThemeMode,
    accentColor: AppConstants.defaultMaterialColor,
    username: AppConstants.defaultUsername,
    localeCode: AppConstants.defaultLocale,
    dataResetTime: const TimeOfDayAdapter.zero(),
    useBottomNavigation: false,
    useAmoledDark: false,
    useDynamicColors: false,
    excludedApps: [],
    leftEmergencyPasses: 3,
    lastEmergencyUsed: DateTime(0),
    isOnboardingDone: false,
    protectedAccess: false,
    uninstallWindowTime: const TimeOfDayAdapter.zero(),
  );
}
