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
import 'package:mindful/providers/focus/invincible_mode_provider.dart';
import 'package:mindful/providers/restrictions/wellbeing_provider.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/scaffold_shell.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/permissions/accessibility_permission_card.dart';
import 'package:mindful/ui/screens/shorts_blocking/shorts_timer_chart.dart';
import 'package:mindful/ui/screens/shorts_blocking/sliver_shorts_quick_actions.dart';

class ShortsBlockingScreen extends ConsumerWidget {
  const ShortsBlockingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FIXME: Fetch shorts screen time
    int _shortsScreenTimeSec = 0;

    final allowedShortContentTimeSec =
        ref.watch(wellBeingProvider.select((v) => v.allowedShortsTimeSec));

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

    return ScaffoldShell(
      items: [
        NavbarItem(
          icon: FluentIcons.arrow_flow_diagonal_up_right_12_filled,
          filledIcon: FluentIcons.arrow_flow_diagonal_up_right_12_filled,
          titleText: "Shorts blocking",
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Information about shorts blocking
              StyledText(context.locale.wellbeing_tab_info).sliver,

              /// Short content header
              ContentSectionHeader(title: context.locale.short_content_heading)
                  .sliver,

              /// Short usage progress bar
              ShortsTimerChart(
                isModifiable: canModifySettings && haveAccessibilityPermission,
                allowedTimeSec: max(allowedShortContentTimeSec, 0),
                remainingTimeSec: remainingTimeSec,
              ).sliver,

              const AccessibilityPermissionCard(),

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

              const SliverTabsBottomPadding(),
            ],
          ),
        )
      ],
    );
  }
}
