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
import 'package:mindful/ui/common/styled_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProgressPercentageIndicator extends StatelessWidget {
  const ProgressPercentageIndicator({
    super.key,
    required this.progressPercentage,
    this.invertProgress = false,
  });

  final int progressPercentage;
  final bool invertProgress;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.error,
    ];

    final progressColor = progressPercentage.isNegative
        ? colors[invertProgress ? 1 : 0]
        : colors[invertProgress ? 0 : 1];

    return Skeleton.replace(
      replacement: const Bone.icon(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StyledText(
            "${progressPercentage.abs()}%",
            fontSize: 13,
            color: progressColor,
            fontWeight: FontWeight.bold,
          ),
          Icon(
            progressPercentage.isNegative
                ? FluentIcons.caret_down_20_filled
                : FluentIcons.caret_up_20_filled,
            size: 20,
            color: progressColor,
          )
        ],
      ),
    );
  }
}
