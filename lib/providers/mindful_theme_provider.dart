import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the [ThemeMode] to dynamically switch app theme at runtime
final mindfulThemeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});
