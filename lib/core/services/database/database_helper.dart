// import 'package:mindful/core/services/database/tables/focus_table.dart';
// import 'package:mindful/core/services/native_method_channel/mindful_native_plugin.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   /// Singleton
//   DatabaseHelper._();
//   static final DatabaseHelper _instance = DatabaseHelper._();
//   static DatabaseHelper get instance => _instance;

//   final _focusTable = FocusTable();
//   FocusTable get focusTable => _focusTable;

//   ///
//   static const dbName = "mindfulApp.db";
//   static const dbVersion = 1;

//   late Database? _database;
//   Future<Database> get database async {
//     _database ??= await initDatabase();
//     return _database!;
//   }

//   initDatabase() async {
//     final appDirectoryPath = await MindfulNativePlugin.getAppDirectoryPath();
//     final dbPath = join(appDirectoryPath, dbName);

//     return await openDatabase(dbPath, version: dbVersion, onCreate: onCreate);
//   }

//   void onCreate(Database db, int version) async {
//     await db.execute(FocusTable.createTableQuery);
//   }
// }
