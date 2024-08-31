/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/models/android_app.dart';

class ApplicationIcon extends StatelessWidget {
  /// Display [AndroidApp]'s icon if found else custom icon for specified apps.
  const ApplicationIcon({
    super.key,
    required this.app,
    this.size = 18,
    this.isGrayedOut = false,
  });

  final AndroidApp app;
  final double size;
  final bool isGrayedOut;

  @override
  Widget build(BuildContext context) {
    if (app.packageName == AppConstants.removedAppPackage) {
      return _createIcon(FluentIcons.delete_24_regular, context);
    } else if (app.packageName == AppConstants.tetheringAppPackage) {
      return _createIcon(FluentIcons.communication_24_regular, context);
    } else {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: Image.memory(
            app.icon,
            color: isGrayedOut ? Colors.white : null,
            colorBlendMode: isGrayedOut ? BlendMode.saturation : null,
          ),
        ),
      );
    }
  }

  Widget _createIcon(IconData iconData, BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: Theme.of(context).focusColor,
      child: Icon(
        iconData,
        size: size,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
