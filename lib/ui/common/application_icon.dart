/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/models/app_info.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ApplicationIcon extends StatelessWidget {
  /// Display [AndroidApp]'s icon if found else custom icon for specified apps.
  const ApplicationIcon({
    super.key,
    required this.appInfo,
    this.size = 18,
    this.isGrayedOut = false,
  });

  final AppInfo appInfo;
  final double size;
  final bool isGrayedOut;

  @override
  Widget build(BuildContext context) {
    final useCustomIcon = appInfo.icon.isEmpty ||
        appInfo.packageName == AppConstants.removedAppPackage ||
        appInfo.packageName == AppConstants.tetheringAppPackage;

    return CircleAvatar(
      backgroundColor:
          useCustomIcon ? Theme.of(context).focusColor : Colors.transparent,
      radius: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: Skeleton.replace(
          replacement: Bone.iconButton(size: size * 2),
          child: useCustomIcon
              ? _resolveIcon()
              : Image.memory(
                  appInfo.icon,
                  color: isGrayedOut ? Colors.white : null,
                  colorBlendMode: isGrayedOut ? BlendMode.saturation : null,
                ),
        ),
      ),
    );
  }

  Widget _resolveIcon() {
    return Icon(
      appInfo.icon.isEmpty
          ? FluentIcons.question_circle_20_filled
          : appInfo.packageName == AppConstants.tetheringAppPackage
              ? FluentIcons.communication_20_filled
              : FluentIcons.delete_20_filled,
      size: size,
    );
  }
}
