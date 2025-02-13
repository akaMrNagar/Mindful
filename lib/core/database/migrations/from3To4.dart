// ignore_for_file: file_names

import 'package:drift/drift.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/database/tables/parental_controls_table.dart';
import 'package:mindful/core/utils/db_utils.dart';

Future<void> from3To4(Migrator m, Schema4 schema) async => await runSafe(
      "Migration(3 to 4)",
      () async {
        /// Create [AppUsageTable]
        await m.createTable(schema.appUsageTable);

        /// Create [ParentalControlsTable]
        await m.createTable(schema.parentalControlsTable);

        /// Add nsfw websites column to [WellbeingTable]
        await m.addColumn(
          schema.wellbeingTable,
          schema.wellbeingTable.nsfwWebsites,
        );

        /// Add usage history weeks column to [MindfulSettingsTable]
        await m.addColumn(
          schema.mindfulSettingsTable,
          schema.mindfulSettingsTable.usageHistoryWeeks,
        );

        /// Add app version column to [MindfulSettingsTable]
        await m.addColumn(
          schema.mindfulSettingsTable,
          schema.mindfulSettingsTable.appVersion,
        );

        /// Move values from [MindfulSettingsTable] and [InvincibleModeTable]  to [ParentalControlsTable]
        /// Get first record
        final settingsRecord = await m.database
            .customSelect('SELECT * FROM mindful_settings_table')
            .getSingleOrNull();

        /// Get first record
        final invincibleRecord = await m.database
            .customSelect('SELECT * FROM invincible_mode_table')
            .getSingleOrNull();

        /// Settings values
        final bool protectedAccess =
            settingsRecord?.read<bool>('protected_access') ?? false;

        final int uninstallWindow =
            settingsRecord?.read<int>('uninstall_window_time') ?? 0;

        /// Invincible mode values
        final bool isInvincibleModeOn =
            invincibleRecord?.read<bool>('is_invincible_mode_on') ?? false;

        final bool includeAppsTimer =
            invincibleRecord?.read<bool>('include_apps_timer') ?? false;

        final bool includeAppsLaunchLimit =
            invincibleRecord?.read<bool>('include_apps_launch_limit') ?? false;

        final bool includeAppsActivePeriod =
            invincibleRecord?.read<bool>('include_apps_active_period') ?? false;

        final bool includeGroupsTimer =
            invincibleRecord?.read<bool>('include_groups_timer') ?? false;

        final bool includeGroupsActivePeriod =
            invincibleRecord?.read<bool>('include_groups_active_period') ??
                false;

        final bool includeShortsTimer =
            invincibleRecord?.read<bool>('include_shorts_timer') ?? false;

        final bool includeBedtimeSchedule =
            invincibleRecord?.read<bool>('include_bedtime_schedule') ?? false;

        ///  Get the newly created table
        final parentalControlsTable =
            m.database.allTables.whereType<ParentalControlsTable>().firstOrNull;

        /// Put these values to [ParentalControlsTable]
        if (parentalControlsTable != null) {
          await m.database.into(parentalControlsTable as TableInfo).insert(
                ParentalControlsTableCompanion.insert(
                  protectedAccess: Value(protectedAccess),
                  uninstallWindowTime:
                      Value(TimeOfDayAdapter.fromMinutes(uninstallWindow)),
                  isInvincibleModeOn: Value(isInvincibleModeOn),
                  includeAppsTimer: Value(includeAppsTimer),
                  includeAppsLaunchLimit: Value(includeAppsLaunchLimit),
                  includeAppsActivePeriod: Value(includeAppsActivePeriod),
                  includeGroupsTimer: Value(includeGroupsTimer),
                  includeGroupsActivePeriod: Value(includeGroupsActivePeriod),
                  includeShortsTimer: Value(includeShortsTimer),
                  includeBedtimeSchedule: Value(includeBedtimeSchedule),
                ),
                mode: InsertMode.insertOrReplace,
              );
        }

        /// Drop columns from [MindfulSettingsTable]
        await m.alterTable(TableMigration(schema.mindfulSettingsTable));

        /// Drop [InvincibleModeTable]
        await m.deleteTable('invincible_mode_table');
      },
    );
