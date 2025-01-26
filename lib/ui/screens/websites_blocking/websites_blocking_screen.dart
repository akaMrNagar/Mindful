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
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/restrictions/wellbeing_provider.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/screens/websites_blocking/add_websites_fab.dart';
import 'package:mindful/ui/screens/websites_blocking/sliver_blocked_websites_list.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class WebsitesBlockingScreen extends ConsumerWidget {
  const WebsitesBlockingScreen({super.key});

  void _turnNsfwBlockerOn(BuildContext context, WidgetRef ref) async {
    final isConfirm = await showConfirmationDialog(
      context: context,
      icon: FluentIcons.video_prohibited_20_filled,
      heroTag: HeroTags.blockNsfwTileTag,
      title: context.locale.adult_content_heading,
      info: context.locale.block_nsfw_dialog_info,
      positiveLabel: context.locale.block_nsfw_dialog_button_block_anyway,
    );

    if (isConfirm) {
      ref.read(wellBeingProvider.notifier).switchBlockNsfwSites();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockNsfwSites =
        ref.watch(wellBeingProvider.select((v) => v.blockNsfwSites));

    final haveAccessibilityPermission = ref.watch(
      permissionProvider.select((v) => v.haveAccessibilityPermission),
    );

    return DefaultScaffold(navbarItems: [
      NavbarItem(
        icon: FluentIcons.arrow_flow_diagonal_up_right_12_filled,
        filledIcon: FluentIcons.arrow_flow_diagonal_up_right_12_filled,
        fab: const AddWebsitesFAB(),
        title: "Website restrictions",
        sliverBody: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Adult content header
            ContentSectionHeader(title: context.locale.adult_content_heading)
                .sliver,

            /// Block NSFW websites
            DefaultHero(
              tag: HeroTags.blockNsfwTileTag,
              child: DefaultListTile(
                enabled: haveAccessibilityPermission && !blockNsfwSites,
                leadingIcon: FluentIcons.video_prohibited_20_regular,
                titleText: context.locale.block_nsfw_title,
                subtitleText: context.locale.block_nsfw_subtitle,
                switchValue: blockNsfwSites,
                onPressed: () => _turnNsfwBlockerOn(context, ref),
              ),
            ).sliver,

            /// Blocked websites header
            ContentSectionHeader(title: context.locale.blocked_websites_heading)
                .sliver,

            /// Distracting websites list
            const SliverBlockedWebsitesList(),

            const SliverTabsBottomPadding(),
          ],
        ),
      )
    ]);
  }
}
