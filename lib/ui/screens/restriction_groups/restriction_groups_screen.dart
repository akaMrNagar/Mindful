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
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/providers/restrictions/restriction_groups_provider.dart';
import 'package:mindful/ui/common/default_fab_button.dart';
import 'package:mindful/ui/common/scaffold_shell.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/restriction_groups/create_update_group_screen.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_group_card.dart';
import 'package:mindful/ui/screens/restriction_groups/sample_restriction_group.dart';

class RestrictionGroupsScreen extends ConsumerWidget {
  const RestrictionGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups =
        ref.watch(restrictionGroupsProvider.select((v) => v.values.toList()));

    return ScaffoldShell(
      items: [
        NavbarItem(
          icon: FluentIcons.app_title_20_regular,
          filledIcon: FluentIcons.app_title_20_filled,
          titleText: context.locale.restriction_groups_tab_title,
          fab: DefaultFabButton(
            label: context.locale.create_group_fab_button,
            icon: FluentIcons.tab_add_20_filled,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    const CreateUpdateRestrictionGroupScreen(),
              ),
            ),
          ),
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Information about groups
              StyledText(context.locale.restriction_groups_tab_info).sliver,

              16.vSliverBox,

              groups.isEmpty
                  ? const SampleRestrictionGroup().sliver
                  : SliverList.builder(
                      itemCount: groups.length,
                      itemBuilder: (context, index) => RestrictionGroupCard(
                        group: groups[index],
                        position: getItemPositionInList(index, groups.length),
                      ),
                    ),

              const SliverTabsBottomPadding(),
            ],
          ),
        )
      ],
    );
  }
}
