// ignore_for_file: file_names

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/utils/db_utils.dart';

Future<void> from6To7(Migrator m, Schema7 schema) async => await runSafe(
      "Migration(6 to 7)",
      () async {
        /// Create table [NotificationSettingsTable]
        await m.createTable(schema.notificationSettingsTable);

        /// Create table [NotificationsTable]
        await m.createTable(schema.notificationsTable);

        /// Move batched apps from [SharedUniqueDataTable]  to [NotificationSettingsTable]
        ///  Get the newly created table
        final notificationSettingsTable = m.database.allTables
            .whereType<$NotificationSettingsTableTable>()
            .firstOrNull;

        /// Insert excluded apps to [SharedUniqueDataTable]
        if (notificationSettingsTable != null) {
          /// Get record
          final record = await m.database
              .customSelect(
                'SELECT notification_batched_apps FROM shared_unique_data_table',
              )
              .getSingleOrNull();

          /// Decode to list
          List<String> batchedApps = List.from(
            jsonDecode(record?.data['notification_batched_apps'] ?? '[]'),
          );

          /// Insert to table
          await m.database.into(notificationSettingsTable as TableInfo).insert(
                NotificationSettingsTableCompanion(
                  batchedApps: Value(batchedApps),
                ) as Insertable<QueryRow>,
                mode: InsertMode.insertOrReplace,
              );
        }
      },
    );
