import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/mindful_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize method channel
  await MethodChannelService.instance.init();

  /// Initialize isar database service
  await IsarDbService.instance.init();

  /// run main app
  runApp(const ProviderScope(child: MindfulApp()));
}
