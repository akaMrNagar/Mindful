/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/utils/db_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

/// A service class responsible for interacting with the Drift database.
///
/// This class provides methods for initializing the Drift database,
class DriftDbService {
  /// Private constructor to enforce singleton pattern.
  DriftDbService._();

  /// Singleton instance of the [DriftDbService].
  static final DriftDbService instance = DriftDbService._();

  /// Instance used for database operations.
  late AppDatabase driftDb;

  /// The details about the database being opened
  OpeningDetails get openingDetails => _openingDetails;
  late final OpeningDetails _openingDetails;

  /// Flag indicating if we need to populate the database or not
  ///
  /// This is `TRUE` only when the database is created or upgraded
  bool get doesDbNeedsToPopulate => _doesDbNeedsToPopulate;
  late final bool _doesDbNeedsToPopulate;

  /// Initializes the Drift database service.
  ///
  /// This method should be called once in the application's main method
  /// to set up the database.
  Future<void> init() async => driftDb = await _createIsolatedDb();

  /// Creates two separate executors for read and write operations
  Future<AppDatabase> _createIsolatedDb() async {
    final db = LazyDatabase(
      () async {
        final dbFile = File(await getSqliteDbPath());

        /// Set cache directory
        final cacheBase = (await getTemporaryDirectory()).path;
        sqlite3.tempDirectory = cacheBase;

        QueryExecutor foregroundReadExecutor = NativeDatabase(
          dbFile,
          // logStatements: kDebugMode,
          setup: _setup,
        );

        QueryExecutor backgroundWriteExecutor =
            NativeDatabase.createInBackground(
          dbFile,
          // logStatements: kDebugMode,
          setup: _setup,
        );
        return MultiExecutor(
          read: foregroundReadExecutor,
          write: backgroundWriteExecutor,
        );
      },
    );

    return AppDatabase(db);
  }

  /// Setup before opening db
  static void _setup(Database db) {
    /// Retry until 5 seconds then throw db lock error
    db.execute('PRAGMA busy_timeout = 5000;');

    /// Enable WAL mode to allow multiple reader/writers (1000 pages = 4MB)
    // db.execute('PRAGMA journal_mode = WAL;');
    // db.execute('PRAGMA wal_autocheckpoint = 1000;');
  }

  /// Executes after the database is ready to be used (ie. it has been opened
  /// and all migrations ran), but before any other queries will be sent. This
  /// makes it a suitable place to populate data after the database has been
  /// created or set sqlite `PRAGMAS` that you need.
  Future<void> beforeOpen(AppDatabase db, OpeningDetails details) async {
    _openingDetails = details;
    debugPrint(
      "DriftDbService.beforeOpen() is called with details:\n\tCreated: ${details.wasCreated}\n\tUpgraded: ${details.hadUpgrade} [${details.versionBefore} to ${details.versionNow}] ",
    );

    /// Mark as need to populate if db is created or upgraded
    if (details.hadUpgrade || details.wasCreated) {
      _doesDbNeedsToPopulate = true;
      debugPrint("Database is either upgraded or created, so need to populate");
    } else {
      _doesDbNeedsToPopulate = false;
      debugPrint("No need to populate database");
    }
  }
}
