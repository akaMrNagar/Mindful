import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/purged_apps_provider.dart';

/// Display [AndroidApp]'s icon if found else custom icon for specified apps.
class ApplicationIcon extends StatelessWidget {
  const ApplicationIcon({
    super.key,
    required this.app,
    this.size = 18,
  });

  final AndroidApp app;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (app.packageName == Constants.removedAppPackage) {
      return _getIcon(FluentIcons.delete_24_regular, context);
    } else if (app.packageName == Constants.tetheringAppPackage) {
      return _getIcon(FluentIcons.communication_24_regular, context);
    } else {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final isPurged =
                  ref.watch(purgedAppsProvider).contains(app.packageName);

              return Image.memory(
                app.icon,
                color: isPurged ? Colors.grey : null,
                colorBlendMode: isPurged ? BlendMode.saturation : null,
              );
            },
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
