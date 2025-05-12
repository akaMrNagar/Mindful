// ignore_for_file: file_names

import 'package:drift/drift.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/utils/db_utils.dart';

Future<void> from7To8(Migrator m, Schema8 schema) async => await runSafe(
      "Migration(7 to 8)",
      () async {
        /// Add [UsageReminders] column to [AppRestrictionTable]
        await m.addColumn(schema.appRestrictionTable,
            schema.appRestrictionTable.usageReminders);
      },
    );
