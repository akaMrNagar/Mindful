import 'package:flutter/material.dart';

/// To get =>  ScrollControllerProvider.of(context)?.controller;
class ScrollControllerProvider extends InheritedWidget {
  final ScrollController controller;

  const ScrollControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// Returns the [ScrollController] most closely associated with the given context.
  /// Returns null if there is no [ScrollController] associated with the given context.
  static ScrollControllerProvider? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ScrollControllerProvider>();
  }

  @override
  bool updateShouldNotify(covariant ScrollControllerProvider oldWidget) {
    return oldWidget.controller != controller;
  }
}
