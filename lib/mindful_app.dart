import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/routes.dart';

class MindfulApp extends ConsumerWidget {
  const MindfulApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const seedColor = Colors.lightBlue;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.homeScreen,
      routes: AppRoutes.mindfulRoutes,
    );
  }
}
