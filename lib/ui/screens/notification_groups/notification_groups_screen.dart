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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/styled_text.dart';

class NotificationGroupsScreen extends ConsumerWidget {
  const NotificationGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.app_title_20_regular,
          filledIcon: FluentIcons.app_title_20_filled,
          title: context.locale.notification_groups_tab_title,
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Information about notification groups
              StyledText(context.locale.notification_groups_tab_info).sliver,

              16.vSliverBox,

              SliverFillRemaining(
                child: StyledText(
                  "Coming soon!",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ).centered,
              ),

              // SliverList.builder(
              //   itemCount: groups.length,
              //   itemBuilder: (context, index) => RestrictionGroupCard(
              //     group: groups[index],
              //     position: index == 0
              //         ? ItemPosition.start
              //         : index == groups.length - 1
              //             ? ItemPosition.end
              //             : ItemPosition.mid,
              //   ),
              // ),
            ],
          ),
        )
      ],
    );
  }
}
