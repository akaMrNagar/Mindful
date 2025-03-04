// ignore_for_file: file_names

import 'package:drift/drift.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/utils/db_utils.dart';

Future<void> from5To6(Migrator m, Schema6 schema) async => await runSafe(
      "Migration(5 to 6)",
      () async {
        /// Add enforce session column to [FocusProfileTable]
        await m.addColumn(
          schema.focusProfileTable,
          schema.focusProfileTable.enforceSession,
        );

        /// Add reflection column to [FocusSessionsTable]
        await m.addColumn(
          schema.focusSessionsTable,
          schema.focusSessionsTable.reflection,
        );
      },
    );
