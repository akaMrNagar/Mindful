import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/routes.dart';

class MindfulApp extends ConsumerWidget {
  const MindfulApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        cardColor: const Color(0xFF1D2327),
        scaffoldBackgroundColor: const Color(0xFF12181C),
      ),
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // cardColor: const Color(0xFFD8DEE2),
        // scaffoldBackgroundColor: const Color(0xFFE3E9ED),
      ),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.homeScreen,
      routes: AppRoutes.mindfulRoutes,
    );
  }
}
