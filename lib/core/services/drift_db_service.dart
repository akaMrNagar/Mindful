import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
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

  /// Initializes the Drift database service.
  ///
  /// This method should be called once in the application's main method
  /// to set up the database.
  Future<void> init() async => driftDb = await _createIsolatedDb();


  /// Creates two separate executors for read and write operations
  Future<AppDatabase> _createIsolatedDb() async {
    final db = LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'Mindful.sqlite'));

      /// Set cache directory
      final cacheBase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cacheBase;

      QueryExecutor foregroundExecutor = NativeDatabase(file);
      QueryExecutor backgroundExecutor =
          NativeDatabase.createInBackground(file);
      return MultiExecutor(read: foregroundExecutor, write: backgroundExecutor);
    });

    return AppDatabase(db);
  }
}
