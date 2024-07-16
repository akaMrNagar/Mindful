import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/mindful_app.dart';

/// TODO - Remove following dependencies from app.gradle
/// implementation 'com.google.code.gson:gson:2.10.1'
/// implementation 'com.google.android.material:material:1.12.0'
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize method channel
  await MethodChannelService.instance.init();

  /// Initialize isar database service
  await IsarDbService.instance.init();

  /// Setting up SystemUIMode to draw app behind
  /// the navigation controls and status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /// run main app
  runApp(const ProviderScope(child: MindfulApp()));
}
