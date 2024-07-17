import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/focus_provider.dart';

/// Display [AndroidApp]'s icon if found else custom icon for specified apps.
class ApplicationIcon extends StatelessWidget {
  const ApplicationIcon({
    super.key,
    required this.app,
    this.size = 18,
    this.isGreyedOut = false,
  });

  final AndroidApp app;
  final double size;
  final bool isGreyedOut;

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
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final timer = ref.watch(focusProvider
                      .select((value) => value[app.packageName]?.timerSec)) ??
                  0;
              final isPurged =
                  timer > 0 && timer < app.screenTimeThisWeek[dayOfWeek];

              return Image.memory(
                app.icon,
                color: isPurged || isGreyedOut ? Colors.white : null,
                colorBlendMode:
                    isPurged || isGreyedOut ? BlendMode.saturation : null,
              );
            },
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
