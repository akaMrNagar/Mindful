import 'package:flutter/material.dart';
import 'package:mindful/config/app_constants.dart';

/// To get =>  TabControllerProvider.of(context)?.controller;
class TabControllerProvider extends InheritedWidget {
  final TabController controller;

  const TabControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static TabControllerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TabControllerProvider>();
  }

  /// Animates the parent [TabController] to the tab on [tabIndex]
  /// with predefined duration and curve
  void animateToTab(int tabIndex) {
    controller.animateTo(
      tabIndex.clamp(0, controller.length - 1),
      duration: AppConstants.defaultAnimDuration,
      curve: AppConstants.defaultCurve,
    );
  }

  @override
  bool updateShouldNotify(covariant TabControllerProvider oldWidget) {
    return oldWidget.controller != controller;
  }
}
