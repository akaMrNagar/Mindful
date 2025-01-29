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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/status_label.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SingleNotificationTile extends StatelessWidget {
  const SingleNotificationTile({
    super.key,
    this.leading,
    required this.title,
    required this.content,
    required this.timeStamp,
    required this.position,
    required this.onPressed,
  });

  final Widget? leading;
  final String title;
  final String content;
  final ItemPosition position;
  final DateTime timeStamp;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isOlder = timeStamp.isBefore(DateTime.now().dateOnly);

    return DefaultListTile(
      position: position,
      onPressed: onPressed,
      leading: leading,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Title
          Expanded(
            child: StyledText(
              title,
              fontSize: 16,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          4.hBox,

          /// Timestamp
          StyledText(
            timeStamp.timeString(context).toLowerCase(),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.vBox,

          /// Conversation
          StyledText(
            content,
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),

          /// Older label
          if (isOlder)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: StatusLabel(label: context.locale.day_yesterday),
            ),
        ],
      ),
    );
  }
}
