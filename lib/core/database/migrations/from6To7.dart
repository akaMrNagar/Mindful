// ignore_for_file: file_names

import 'package:drift/drift.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/utils/db_utils.dart';

Future<void> from6To7(Migrator m, Schema7 schema) async => await runSafe(
      "Migration(6 to 7)",
      () async {
        /// Create table [NotificationSettingsTable]
        await m.createTable(schema.notificationSettingsTable);

        /// Create table [NotificationsTable]
        await m.createTable(schema.notificationsTable);

        /// Drop [NotificationBatchedApps] column from [SharedUniqueDataTable]
        await m.alterTable(TableMigration(schema.sharedUniqueDataTable));

        /// Drop [NotificationScheduleTable]
        await m.deleteTable('notification_schedule_table');
      },
    );
