/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/invincible_mode_provider.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';
import 'package:mindful/ui/permissions/accessibility_permission_card.dart';
import 'package:mindful/ui/screens/home/wellbeing/sliver_blocked_websites_list.dart';
import 'package:mindful/ui/screens/home/wellbeing/sliver_shorts_quick_actions.dart';
import 'package:mindful/ui/screens/home/wellbeing/shorts_timer_chart.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class TabWellBeing extends ConsumerStatefulWidget {
  const TabWellBeing({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabWellBeingState();
}

class _TabWellBeingState extends ConsumerState<TabWellBeing> {
  int _shortsScreenTimeSec = 0;

  @override
  void initState() {
    super.initState();
    MethodChannelService.instance
        .getShortsScreenTimeSec()
        .then((timeSec) => setState(() => _shortsScreenTimeSec = timeSec));
  }

  void _turnNsfwBlockerOn() async {
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
  Widget build(BuildContext context) {
    final allowedShortContentTimeSec =
        ref.watch(wellBeingProvider.select((v) => v.allowedShortsTimeSec));

    final blockNsfwSites =
        ref.watch(wellBeingProvider.select((v) => v.blockNsfwSites));

    final haveAccessibilityPermission = ref.watch(
      permissionProvider.select((v) => v.haveAccessibilityPermission),
    );

    final remainingTimeSec = allowedShortContentTimeSec.isNegative
        ? 0
        : max(
            0,
            (allowedShortContentTimeSec - _shortsScreenTimeSec),
          );

    final isInvincibleModeRestricted = ref.watch(
      invincibleModeProvider
          .select((v) => v.isInvincibleModeOn && v.includeShortsTimer),
    );

    final canModifySettings = allowedShortContentTimeSec.isNegative ||
        !isInvincibleModeRestricted ||
        (isInvincibleModeRestricted && remainingTimeSec > 0);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Information about bedtime
        StyledText(context.locale.wellbeing_tab_info).sliver,

        const AccessibilityPermissionCard(),

        /// Short content header
        ContentSectionHeader(title: context.locale.short_content_heading)
            .sliver,

        /// Short usage progress bar
        ShortsTimerChart(
          isModifiable: canModifySettings && haveAccessibilityPermission,
          allowedTimeSec: max(allowedShortContentTimeSec, 0),
          remainingTimeSec: remainingTimeSec,
        ).sliver,

        /// Invincible Mode warning
        SliverPrimaryActionContainer(
          isVisible: haveAccessibilityPermission && !canModifySettings,
          margin: const EdgeInsets.symmetric(vertical: 16),
          icon: FluentIcons.animal_cat_20_regular,
          title: context.locale.invincible_mode_heading,
          information: context.locale.short_content_invincible_mode_info,
        ),

        /// Quick actions
        SliverShortsQuickActions(
          haveNecessaryPerms: haveAccessibilityPermission,
          isModifiable: canModifySettings,
        ),

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
            onPressed: _turnNsfwBlockerOn,
          ),
        ).sliver,

        /// Blocked websites header
        ContentSectionHeader(title: context.locale.blocked_websites_heading)
            .sliver,

        /// Distracting websites list
        const SliverBlockedWebsitesList(),

        const SliverTabsBottomPadding(),
      ],
    );
  }
}
