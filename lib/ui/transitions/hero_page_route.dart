import 'package:flutter/material.dart';

class HeroPageRoute<T> extends PageRoute<T> {
  HeroPageRoute({
    required WidgetBuilder builder,
    bool fullscreenDialog = false,
    bool barrierDismissible = true,
  })  : _builder = builder,
        super(
          fullscreenDialog: fullscreenDialog,
          barrierDismissible: barrierDismissible,
        );

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}
