import 'package:flutter/material.dart';

@immutable
class VertNavBarItem {
  final IconData icon;
  final String label;
  const VertNavBarItem({
    required this.icon,
    required this.label,
  });
}
