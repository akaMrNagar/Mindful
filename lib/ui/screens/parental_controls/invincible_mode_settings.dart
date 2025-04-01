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
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/system/parental_controls_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/dialogs/time_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';

class InvincibleModeSettings extends ConsumerWidget {
  const InvincibleModeSettings({super.key});

  void _turnOnInvincibleMode(
    BuildContext context,
    WidgetRef ref,
    bool isOn,
  ) async {
    if (!isOn) {
      final isConfirm = await showConfirmationDialog(
        context: context,
        icon: FluentIcons.animal_cat_20_filled,
        heroTag: HeroTags.invincibleModeTileTag,
        title: context.locale.invincible_mode_heading,
        info: context.locale.invincible_mode_dialog_info,
        positiveLabel:
            context.locale.invincible_mode_dialog_button_start_anyway,
      );
      if (isConfirm) {
        ref.read(parentalControlsProvider.notifier).switchInvincibleMode();
      }
    } else {
      context.showSnackAlert(
        context.locale.invincible_mode_turn_off_snack_alert,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parentalControls = ref.watch(parentalControlsProvider);

    return MultiSliver(
      children: [
        /// Invincible mode
        ContentSectionHeader(title: context.locale.invincible_mode_heading)
            .sliver,

        /// Information about invincible mode
        StyledText(
          context.locale.invincible_mode_info,
        ).sliver,
        12.vSliverBox,

        /// Invincible mode
        DefaultHero(
          tag: HeroTags.invincibleModeTileTag,
          child: DefaultListTile(
            position: ItemPosition.top,
            isPrimary: true,
            switchValue: parentalControls.isInvincibleModeOn,
            leadingIcon: FluentIcons.animal_cat_20_regular,
            titleText: context.locale.invincible_mode_tile_title,
            onPressed: () => _turnOnInvincibleMode(
              context,
              ref,
              parentalControls.isInvincibleModeOn,
            ),
          ),
        ).sliver,

        /// invincible window
        DefaultHero(
          tag: HeroTags.invincibleWindowTileTag,
          child: DefaultListTile(
            position: ItemPosition.mid,
            isPrimary: true,
            titleText: context.locale.invincible_window_tile_title,
            subtitleText: context.locale.invincible_window_tile_subtitle,
            trailing: StyledText(
              parentalControls.invincibleWindowTime.format(context),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () async {
              /// Check if between the specified window
              if (!ref
                  .read(parentalControlsProvider.notifier)
                  .isBetweenInvincibleWindow) {
                context
                    .showSnackAlert(context.locale.invincible_mode_snack_alert);
                return;
              }

              final pickedTime = await showCustomTimePickerDialog(
                context: context,
                heroTag: HeroTags.invincibleWindowTileTag,
                initialTime: parentalControls.invincibleWindowTime,
                info: context.locale.invincible_window_tile_title,
              );

              if (pickedTime != null && context.mounted) {
                ref
                    .read(parentalControlsProvider.notifier)
                    .changeInvincibleWindowTime(pickedTime);
              }
            },
          ),
        ).sliver,

        /// App restrictions
        DefaultExpandableListTile(
          titleText: context.locale.invincible_mode_app_restrictions_tile_title,
          subtitleText:
              context.locale.invincible_mode_app_restrictions_tile_subtitle,
          position: ItemPosition.mid,
          content: Column(
            children: [
              /// Apps timer
              DefaultListTile(
                position: ItemPosition.mid,
                enabled: !parentalControls.isInvincibleModeOn ||
                    !parentalControls.includeAppsTimer,
                isSelected: parentalControls.includeAppsTimer,
                leadingIcon: FluentIcons.timer_20_regular,
                titleText:
                    context.locale.invincible_mode_include_timer_tile_title,
                onPressed: ref
                    .read(parentalControlsProvider.notifier)
                    .toggleIncludeAppsTimer,
              ),

              /// Apps launch limit
              DefaultListTile(
                position: ItemPosition.mid,
                enabled: !parentalControls.isInvincibleModeOn ||
                    !parentalControls.includeAppsLaunchLimit,
                isSelected: parentalControls.includeAppsLaunchLimit,
                leadingIcon: FluentIcons.rocket_20_regular,
                titleText: context
                    .locale.invincible_mode_include_launch_limit_tile_title,
                onPressed: ref
                    .read(parentalControlsProvider.notifier)
                    .toggleIncludeAppsLaunchLimit,
              ),

              /// Apps active period
              DefaultListTile(
                position: ItemPosition.mid,
                enabled: !parentalControls.isInvincibleModeOn ||
                    !parentalControls.includeAppsActivePeriod,
                isSelected: parentalControls.includeAppsActivePeriod,
                leadingIcon: FluentIcons.drink_coffee_20_regular,
                titleText: context
                    .locale.invincible_mode_include_active_period_tile_title,
                onPressed: ref
                    .read(parentalControlsProvider.notifier)
                    .toggleIncludeAppsActivePeriod,
              ),
            ],
          ),
        ).sliver,

        /// Group restrictions
        DefaultExpandableListTile(
          titleText:
              context.locale.invincible_mode_group_restrictions_tile_title,
          subtitleText:
              context.locale.invincible_mode_group_restrictions_tile_subtitle,
          position: ItemPosition.mid,
          content: Column(
            children: [
              /// Groups timer
              DefaultListTile(
                position: ItemPosition.mid,
                enabled: !parentalControls.isInvincibleModeOn ||
                    !parentalControls.includeGroupsTimer,
                isSelected: parentalControls.includeGroupsTimer,
                leadingIcon: FluentIcons.timer_20_regular,
                titleText:
                    context.locale.invincible_mode_include_timer_tile_title,
                onPressed: ref
                    .read(parentalControlsProvider.notifier)
                    .toggleIncludeGroupsTimer,
              ),

              /// Groups active period
              DefaultListTile(
                position: ItemPosition.mid,
                enabled: !parentalControls.isInvincibleModeOn ||
                    !parentalControls.includeGroupsActivePeriod,
                isSelected: parentalControls.includeGroupsActivePeriod,
                leadingIcon: FluentIcons.drink_coffee_20_regular,
                titleText: context
                    .locale.invincible_mode_include_active_period_tile_title,
                onPressed: ref
                    .read(parentalControlsProvider.notifier)
                    .toggleIncludeGroupsActivePeriod,
              ),
            ],
          ),
        ).sliver,

        /// Shorts timer
        DefaultListTile(
          position: ItemPosition.mid,
          enabled: !parentalControls.isInvincibleModeOn ||
              !parentalControls.includeShortsTimer,
          isSelected: parentalControls.includeShortsTimer,
          leadingIcon: FluentIcons.video_clip_multiple_20_regular,
          titleText:
              context.locale.invincible_mode_include_shorts_timer_tile_title,
          subtitleText:
              context.locale.invincible_mode_include_shorts_timer_tile_subtitle,
          onPressed: ref
              .read(parentalControlsProvider.notifier)
              .toggleIncludeShortsTimer,
        ).sliver,

        /// Bedtime schedule
        DefaultListTile(
          position: ItemPosition.bottom,
          enabled: !parentalControls.isInvincibleModeOn ||
              !parentalControls.includeBedtimeSchedule,
          isSelected: parentalControls.includeBedtimeSchedule,
          leadingIcon: FluentIcons.sleep_20_regular,
          titleText: context.locale.invincible_mode_include_bedtime_tile_title,
          subtitleText:
              context.locale.invincible_mode_include_bedtime_tile_subtitle,
          onPressed: ref
              .read(parentalControlsProvider.notifier)
              .toggleIncludeBedtimeSchedule,
        ).sliver,
      ],
    );
  }
}
