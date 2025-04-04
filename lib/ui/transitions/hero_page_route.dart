/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:mindful/config/app_constants.dart';

class HeroPageRoute<T> extends PageRoute<T> {
  HeroPageRoute({
    required WidgetBuilder builder,
    this.isFullscreenDialog = false,
    this.isBarrierDismissible = true,
  })  : _builder = builder,
        super(
          fullscreenDialog: isFullscreenDialog,
          barrierDismissible: isBarrierDismissible,
        );

  final WidgetBuilder _builder;
  final bool isBarrierDismissible;
  final bool isFullscreenDialog;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => isBarrierDismissible;

  @override
  Duration get transitionDuration => AppConstants.defaultAnimDuration * 1.5;

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
  String get barrierLabel => 'Popup hero dialog';
}
