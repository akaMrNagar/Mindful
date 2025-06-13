// ignore_for_file: file_names

import 'package:drift/drift.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/utils/db_utils.dart';

Future<void> from8To9(Migrator m, Schema9 schema) async => await runSafe(
      "Migration(8 to 9)",
      () async {
        /// Add [ReminderType] column to [AppRestrictionTable]
        await m.addColumn(schema.appRestrictionTable,
            schema.appRestrictionTable.reminderType);

        /// Drop [UsageReminders] column from [AppRestrictionTable]
        await m.alterTable(TableMigration(schema.appRestrictionTable));
      },
    );
