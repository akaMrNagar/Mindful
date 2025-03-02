// ignore_for_file: file_names

import 'package:drift/drift.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/utils/db_utils.dart';

Future<void> from4To5(Migrator m, Schema5 schema) async => await runSafe(
      "Migration(4 to 5)",
      () async {
        /// Add invincible window time column to [ParentalControlsTable]
        await m.addColumn(
          schema.parentalControlsTable,
          schema.parentalControlsTable.invincibleWindowTime,
        );

        /// Add blocked features column to [WellbeingTable]
        await m.addColumn(
          schema.wellbeingTable,
          schema.wellbeingTable.blockedFeatures,
        );

        /// Drop old columns from [WellbeingTable]
        await m.alterTable(TableMigration(schema.wellbeingTable));
      },
    );
