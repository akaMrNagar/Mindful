import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/models/android_app.dart';

class ApplicationIcon extends StatelessWidget {
  const ApplicationIcon({
    super.key,
    required this.app,
    this.size = 18,
    // this.backgroundColor = Colors.transparent,
  });

  final AndroidApp app;
  final double size;
  // final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (app.packageName == AppConstants.removedAppPackage) {
      return _getIcon(FluentIcons.delete_24_regular, context);
    } else if (app.packageName == AppConstants.tetheringAppPackage) {
      return _getIcon(FluentIcons.communication_24_regular, context);
    } else {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: Image.memory(
            app.icon,
            // color: Colors.grey,
            // colorBlendMode: BlendMode.saturation,
          ),
        ),
      );
    }
  }

  Widget _getIcon(IconData iconData, BuildContext context) {
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
