// ignore_for_file: file_names

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/utils/db_utils.dart';

Future<void> from2To3(Migrator m, Schema3 schema) async => await runSafe(
      "Migration(2 to 3)",
      () async {
        /// Create notification schedule table
        await m.createTable(schema.notificationScheduleTable);

        /// Create shared unique data table
        await m.createTable(schema.sharedUniqueDataTable);

        /// Fetch excluded apps from [MindfulSettingsTable]
        final settings = await m.database
            .select(schema.mindfulSettingsTable)
            .getSingleOrNull();

        /// Insert excluded apps to [SharedUniqueDataTable]
        if (settings != null) {
          /// Get record
          final record = await m.database
              .customSelect(
                'SELECT excluded_apps FROM mindful_settings_table',
              )
              .getSingleOrNull();

          /// Decode to list
          List<String> excludedApps = List.from(
            jsonDecode(record?.data['excluded_apps'] ?? '[]'),
          );

          /// Insert to table
          await m.database.into(schema.sharedUniqueDataTable).insert(
                SharedUniqueDataTableCompanion(
                  excludedApps: Value(excludedApps),
                ) as Insertable<QueryRow>,
                mode: InsertMode.insertOrReplace,
              );
        }

        /// Drop excluded apps column from [MindfulSettingsTable]
        await m.alterTable(TableMigration(schema.mindfulSettingsTable));
      },
    );
