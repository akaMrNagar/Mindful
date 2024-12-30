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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/utils.dart';
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
    this.badge,
    this.isPrimary = false,
    this.position = ItemPosition.mid,
  });

  final IconData icon;
  final bool isPrimary;
  final String title;
  final String info;
  final VoidCallback? onTap;
  final ItemPosition position;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      circularRadius: 6,
      borderRadius: getBorderRadiusFromPosition(position),
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
              badge ?? 0.hBox,
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
