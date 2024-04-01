import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/shared_prefs_service.dart';
import 'package:mindful/mindful_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize shared prefrence service
  await SharePrefsService.instance.init();

  /// Setting up SystmeUIMode to draw app behind
  /// the navigation controls and status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /// run main app
  runApp(const ProviderScope(child: MindfulApp()));
}
