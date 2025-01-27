import 'package:flutter/material.dart';

/// To get =>  ScrollControllerProvider.of(context)?.controller;
class ScrollControllerProvider extends InheritedWidget {
  final ScrollController controller;

  const ScrollControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static ScrollControllerProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ScrollControllerProvider>();
  }

  @override
  bool updateShouldNotify(covariant ScrollControllerProvider oldWidget) {
    return oldWidget.controller != controller;
  }
}
