import 'package:flutter/material.dart';

class CustomSegment {
  final int value;
  final String? label;
  final IconData? iconData;

  CustomSegment({
    required this.value,
    this.label,
    this.iconData,
  });
}