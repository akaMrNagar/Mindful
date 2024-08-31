/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/permissions/battery_permission_tile.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class TabAdvance extends ConsumerWidget {
  const TabAdvance({super.key});

  void _turnOnInvincibleMode(
    BuildContext context,
    WidgetRef ref,
    bool shouldTurnOn,
  ) async {
    if (shouldTurnOn) {
      final isConfirm = await showConfirmationDialog(
        context: context,
        icon: FluentIcons.animal_cat_20_filled,
        heroTag: HeroTags.invincibleModeTileTag,
        title: "Invincible mode",
        info:
            "Are you absolutely sure you want to enable Invincible Mode? This action is irreversible. Once Invincible Mode is turned on, you cannot turn it off as long as this app is installed on your device.",
        positiveLabel: "Start",
      );
      if (isConfirm) {
        ref.read(settingsProvider.notifier).switchInvincibleMode();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInvincibleModeOn =
        ref.watch(settingsProvider.select((v) => v.isInvincibleModeOn));

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        const SliverFlexibleAppBar(title: "Advance"),

        /// Invincible mode
        const SliverContentTitle(title: "Invincible mode"),

        /// Information about invincible mode
        const StyledText(
                "When Invincible Mode is active, modifying the app's timer after it runs out or adjusting the short content settings after reaching the daily limit is not permitted.")
            .sliver,
        12.vSliverBox,

        /// Invincible mode
        DefaultHero(
          tag: HeroTags.invincibleModeTileTag,
          child: DefaultListTile(
            isPrimary: true,
            switchValue: isInvincibleModeOn,
            enabled: !isInvincibleModeOn,
            leadingIcon: FluentIcons.animal_cat_20_regular,
            titleText: "Activate invincible mode",
            onPressed: () =>
                _turnOnInvincibleMode(context, ref, !isInvincibleModeOn),
          ),
        ).sliver,
        12.vSliverBox,

        const SliverContentTitle(title: "Service"),

        /// Battery
        const StyledText(
          "If you are experiencing issues with Mindful suddenly stopping, please consider granting the ignore battery optimization permission. This will allow Mindful to operate in background without interruptions.",
        ).sliver,
        6.vSliverBox,

        /// Battery permission
        const BatteryPermissionTile(),

        const SliverTabsBottomPadding()
      ],
    );
  }
}
