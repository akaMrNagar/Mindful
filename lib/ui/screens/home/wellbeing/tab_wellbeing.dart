/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';
import 'package:mindful/ui/permissions/accessibility_permission.dart';
import 'package:mindful/ui/permissions/alarm_permission.dart';
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
      title: "Adult sites",
      info:
          "Are you sure? This action is irreversible. Once adult sites blocker is turned on, you cannot turn it off as long as this app is installed on your device.",
      positiveLabel: "Block anyway",
    );

    if (isConfirm) {
      ref.read(wellBeingProvider.notifier).switchBlockNsfwSites();
    }
  }

  @override
  Widget build(BuildContext context) {
    final allowedShortContentTimeSec = ref
        .watch(wellBeingProvider.select((v) => v.allowedShortContentTimeSec));

    final blockNsfwSites =
        ref.watch(wellBeingProvider.select((v) => v.blockNsfwSites));

    final haveAccessibilityPermission = ref.watch(
      permissionProvider.select((v) => v.haveAccessibilityPermission),
    );

    final haveAlarmPermission = ref.watch(
      permissionProvider.select((v) => v.haveAlarmsPermission),
    );

    final havePerms = haveAccessibilityPermission && haveAlarmPermission;

    final remainingTimeSec = max(
      0,
      (allowedShortContentTimeSec - _shortsScreenTimeSec),
    );

    final isInvincibleModeOn = ref.watch(
      settingsProvider.select((v) => v.isInvincibleModeOn),
    );

    final isModifiable =
        !isInvincibleModeOn || (isInvincibleModeOn && remainingTimeSec > 0);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        const SliverFlexibleAppBar(title: "Wellbeing"),

        /// Information about bedtime
        const StyledText(
          "Control how much time you spend on short content across platforms like Instagram, YouTube, Snapchat, and Facebook, including their websites. Additionally, block adult websites and custom sites for a balanced and focused online experience.",
        ).sliver,

        const ExactAlarmPermission(),
        const AccessibilityPermission(),

        /// Short content header
        const SliverContentTitle(title: "Short content"),

        /// Short usage progress bar
        ShortsTimerChart(
          isModifiable: isModifiable && havePerms,
          allowedTimeSec: max(allowedShortContentTimeSec, 1),
          remainingTimeSec: remainingTimeSec,
        ).sliver,

        SliverPrimaryActionContainer(
          isVisible: havePerms && !isModifiable,
          margin: const EdgeInsets.symmetric(vertical: 16),
          icon: FluentIcons.animal_cat_20_regular,
          title: "Invincible mode",
          information:
              "You have exhausted the daily short content quota time. Due to invincible mode, modifications to settings related to short content are not allowed.",
        ),

        /// Quick actions
        SliverShortsQuickActions(
          haveNecessaryPerms: havePerms,
          isModifiable: isModifiable,
        ),

        /// Adult content header
        const SliverContentTitle(title: "Adult content"),

        /// Block NSFW websites
        DefaultHero(
          tag: HeroTags.blockNsfwTileTag,
          child: DefaultListTile(
            enabled: haveAccessibilityPermission && !blockNsfwSites,
            leadingIcon: FluentIcons.video_prohibited_20_regular,
            titleText: "Block Nsfw",
            subtitleText:
                "Restrict browsers from opening adult and porn websites.",
            switchValue: blockNsfwSites,
            onPressed: _turnNsfwBlockerOn,
          ),
        ).sliver,

        /// Blocked websites header
        const SliverContentTitle(title: "Blocked websites"),

        /// Distracting websites list
        const SliverBlockedWebsitesList(),

        const SliverTabsBottomPadding(),
      ],
    );
  }
}
