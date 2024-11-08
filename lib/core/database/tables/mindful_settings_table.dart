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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/converters/list_converters.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/enums/default_home_tab.dart';

@DataClassName("MindfulSettings")
class MindfulSettingsTable extends Table {
  /// Unique ID for app settings
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Default theme mode for app
  IntColumn get themeMode => intEnum<AppThemeMode>()();

  /// Default material color for app
  TextColumn get accentColor => text()();

  /// Username shown on the dashboard
  TextColumn get username => text()();

  /// App Locale (Language code)
  TextColumn get localeCode => text()();

  /// Daily data usage renew or reset time [TimeOfDay] stored as minutes
  IntColumn get dataResetTimeMins => integer()();

  /// Flag indicating if to use bottom navigation or the default sidebar
  BoolColumn get useBottomNavigation => boolean()();

  /// Flag indicating if to use pure amoled black color for dark theme
  BoolColumn get useAmoledDark => boolean()();

  /// Flag indicating if to use wallpaper colors for themes
  BoolColumn get useDynamicColors => boolean()();

  /// Default initial home tab
  IntColumn get defaultHomeTab => intEnum<DefaultHomeTab>()();

  /// List of app's packages which are excluded from the aggregated usage statistics.
  TextColumn get excludedApps => text().map(const ListStringConverter())();

  static const defaultMindfulSettingsModel = MindfulSettings(
    id: 0,
    defaultHomeTab: DefaultHomeTab.dashboard,
    themeMode: AppThemeMode.system,
    accentColor: "Indigo",
    username: "Hustler",
    localeCode: "en",
    dataResetTimeMins: 0,
    useBottomNavigation: false,
    useAmoledDark: false,
    useDynamicColors: false,
    excludedApps: [],
  );
}
