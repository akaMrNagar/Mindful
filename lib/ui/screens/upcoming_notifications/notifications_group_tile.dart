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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';

class NotificationsGroupTile extends ConsumerWidget {
  const NotificationsGroupTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageName = "com.instagram.android";
    final app = ref.watch(appsProvider.select((v) => v.value?[packageName]));

    return DefaultExpandableListTile(
      titleText: "Instagram",
      subtitle: StyledText(
        "8 notifications",
        fontSize: 14,
        color: Theme.of(context).hintColor,
      ),
      leading: app != null ? ApplicationIcon(app: app) : null,
      leadingIcon: app == null ? FluentIcons.delete_20_regular : null,
      position: ItemPosition.top,
      contentPosition: ItemPosition.mid,
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        padding: const EdgeInsets.symmetric(),
        itemBuilder: (context, index) => _Notification(
          title: "Some title",
          content: "Notification content",
          timeStamp: DateTime.now(),
        ),
      ),
    );
  }
}

class _Notification extends StatelessWidget {
  const _Notification({
    required this.title,
    required this.content,
    required this.timeStamp,
  });

  final String title;
  final String content;
  final DateTime timeStamp;

  @override
  Widget build(BuildContext context) {
    return DefaultListTile(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      position: ItemPosition.mid,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StyledText(
              title,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          4.hBox,
          StyledText(timeStamp.timeString(context).toLowerCase()),
        ],
      ),
      subtitle: StyledText(
        content,
        fontSize: 14,
        color: Theme.of(context).hintColor,
      ),
    );
  }
}
