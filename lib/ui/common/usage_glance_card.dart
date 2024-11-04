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
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UsageGlanceCard extends StatelessWidget {
  const UsageGlanceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    this.onTap,
    this.progressPercentage = 0,
    this.isPrimary = false,
    this.invertProgress = false,
  });

  final IconData icon;
  final bool isPrimary;
  final bool invertProgress;
  final String title;
  final String info;
  final int progressPercentage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.error,
    ];

    final progressColor = progressPercentage.isNegative
        ? colors[invertProgress ? 1 : 0]
        : colors[invertProgress ? 0 : 1];

    return RoundedContainer(
      circularRadius: 8,
      padding: const EdgeInsets.all(16),
      color:
          isPrimary ? Theme.of(context).colorScheme.secondaryContainer : null,
      onPressed: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const Spacer(),
              if (progressPercentage != 0) ...[
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
                ),
              ]
            ],
          ),
          12.vBox,
          StyledText(
            title,
            fontSize: 12,
          ),
          Skeleton.leaf(
            child: FittedBox(
              child: StyledText(
                info.isEmpty ? " " : info,
                fontSize: 24,
                maxLines: 1,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
