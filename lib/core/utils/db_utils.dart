import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Get the SQLITE database file path: /data/user/0/com.mindful.android/app_flutter/Mindful.sqlite
Future<String> getSqliteDbPath() async => path.join(
      (await getApplicationDocumentsDirectory()).path,
      'Mindful.sqlite',
    );


/// Invoke the method in the [try/catch] block and print the error if it occurred
Future<void> runSafe(String tag, Future<void> Function() method) async {
  try {
    await method();
  } catch (e) {
    debugPrint("Error Occurred [$tag] : ${e.toString()}");
  }
}


