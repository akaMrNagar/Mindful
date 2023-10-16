import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mindfulThemeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});
