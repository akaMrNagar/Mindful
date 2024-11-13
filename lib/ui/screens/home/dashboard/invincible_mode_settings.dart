import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/invincible_mode_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
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
        ref.read(invincibleModeProvider.notifier).switchInvincibleMode();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invincibleMode = ref.watch(invincibleModeProvider);

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
            position: ItemPosition.start,
            isPrimary: true,
            switchValue: invincibleMode.isInvincibleModeOn,
            leadingIcon: FluentIcons.animal_cat_20_regular,
            titleText: context.locale.invincible_mode_tile_title,
            onPressed: () => _turnOnInvincibleMode(
              context,
              ref,
              invincibleMode.isInvincibleModeOn,
            ),
          ),
        ).sliver,

        /// Apps timer
        DefaultListTile(
          position: ItemPosition.mid,
          isSelected: invincibleMode.includeAppsTimer,
          leadingIcon: FluentIcons.timer_20_regular,
          titleText:
              context.locale.invincible_mode_include_apps_timer_tile_title,
          subtitleText:
              context.locale.invincible_mode_include_apps_timer_tile_subtitle,
          onPressed:
              ref.read(invincibleModeProvider.notifier).toggleIncludeAppsTimer,
        ).sliver,

        /// Apps launch limit
        DefaultListTile(
          position: ItemPosition.mid,
          isSelected: invincibleMode.includeAppsLaunchLimit,
          leadingIcon: FluentIcons.rocket_20_regular,
          titleText: context
              .locale.invincible_mode_include_apps_launch_limit_tile_title,
          subtitleText: context
              .locale.invincible_mode_include_apps_launch_limit_tile_subtitle,
          onPressed: ref
              .read(invincibleModeProvider.notifier)
              .toggleIncludeAppsLaunchLimit,
        ).sliver,

        /// Groups timer
        DefaultListTile(
          position: ItemPosition.mid,
          isSelected: invincibleMode.includeGroupsTimer,
          leadingIcon: FluentIcons.app_title_20_regular,
          titleText:
              context.locale.invincible_mode_include_groups_timer_tile_title,
          subtitleText:
              context.locale.invincible_mode_include_groups_timer_tile_subtitle,
          onPressed: ref
              .read(invincibleModeProvider.notifier)
              .toggleIncludeGroupsTimer,
        ).sliver,

        /// Shorts timer
        DefaultListTile(
          position: ItemPosition.mid,
          isSelected: invincibleMode.includeShortsTimer,
          leadingIcon: FluentIcons.video_clip_multiple_20_regular,
          titleText:
              context.locale.invincible_mode_include_shorts_timer_tile_title,
          subtitleText:
              context.locale.invincible_mode_include_shorts_timer_tile_subtitle,
          onPressed: ref
              .read(invincibleModeProvider.notifier)
              .toggleIncludeShortsTimer,
        ).sliver,

        /// Bedtime schedule
        DefaultListTile(
          position: ItemPosition.end,
          isSelected: invincibleMode.includeBedtimeSchedule,
          leadingIcon: FluentIcons.sleep_20_regular,
          titleText: context.locale.invincible_mode_include_bedtime_tile_title,
          subtitleText:
              context.locale.invincible_mode_include_bedtime_tile_subtitle,
          onPressed: ref
              .read(invincibleModeProvider.notifier)
              .toggleIncludeBedtimeSchedule,
        ).sliver,
      ],
    );
  }
}
