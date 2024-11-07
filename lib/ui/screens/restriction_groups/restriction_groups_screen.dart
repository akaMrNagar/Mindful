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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/restriction_groups/create_restriction_group_fab.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_group_card.dart';

class RestrictionGroupsScreen extends ConsumerWidget {
  const RestrictionGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups =
        ref.watch(restrictionGroupsProvider.select((v) => v.values.toList()));

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.app_title_20_regular,
          filledIcon: FluentIcons.app_title_20_filled,
          title: context.locale.restriction_groups_tab_title,
          fab: const CreateRestrictionGroupFab(),
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Information about groups
              StyledText(context.locale.restriction_group_tab_info).sliver,

              16.vSliverBox,
              SliverList.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) => RestrictionGroupCard(
                  group: groups[index],
                  position: index == 0
                      ? ItemPosition.start
                      : index == groups.length - 1
                          ? ItemPosition.end
                          : ItemPosition.mid,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
