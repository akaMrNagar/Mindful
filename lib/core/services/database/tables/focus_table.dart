// import 'package:mindful/core/services/database/database_helper.dart';
// import 'package:sqflite/sqflite.dart';

// class FocusTable {
//   /// Table for app which are being focused or whose screen time limit is set
//   static const tableName = "FOCUS";

//   /// columns for table
//   static const colPackage = 'appPackage';
//   static const colScreenTimeLimit = 'screenTimeLimit';
//   static const colBedtimeStart = 'bedtimeStart';
//   static const colBedtimeEnd = 'bedtimeEnd';

//   /// Query
//   static const createTableQuery = '''
//   CREATE TABLE $tableName (
//     $colPackage TEXT PRIMARY KEY,
//     $colScreenTimeLimit INTEGER  DEFAULT 0,
//     $colBedtimeStart INTEGER DEFAULT 0,
//     $colBedtimeEnd INTEGER DEFAULT 0
//     )    
//   ''';

//   insertRecord(Map<String, dynamic> record) async {
//     Database db = await DatabaseHelper.instance.database;
//     return await db.insert(tableName, record);
//   }

//   Future<List<Map<String, dynamic>>> readRecord() async {
//     Database db = await DatabaseHelper.instance.database;
//     return await db.query(tableName);
//   }

//   Future<int> updateRecord(Map<String, dynamic> record) async {
//     Database db = await DatabaseHelper.instance.database;
//     String package = record[colPackage];
//     return await db.update(
//       tableName,
//       record,
//       where: '$colPackage = ?',
//       whereArgs: [package],
//     );
//   }

//   Future<int> deleteRecord(String packageName) async {
//     Database db = await DatabaseHelper.instance.database;
//     return await db.delete(
//       tableName,
//       where: '$colPackage = ?',
//       whereArgs: [packageName],
//     );
//   }
// }
