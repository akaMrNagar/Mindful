import 'package:flutter/material.dart';

@immutable
class ScaffoldTabItem {
  final IconData icon;
  final String title;
  final Widget body;
  final String? tabLabel;

  const ScaffoldTabItem({
    required this.title,
    required this.icon,
    required this.body,
    this.tabLabel,
  });
}
