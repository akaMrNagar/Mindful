import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/mindful_settings_provider.dart';
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
    bool shouldTurnOn,
  ) async {
    if (shouldTurnOn) {
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
        ref.read(mindfulSettingsProvider.notifier).switchInvincibleMode();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInvincibleModeOn =
        ref.watch(mindfulSettingsProvider.select((v) => v.isInvincibleModeOn));

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
            switchValue: isInvincibleModeOn,
            // enabled: !isInvincibleModeOn,
            leadingIcon: FluentIcons.animal_cat_20_regular,
            titleText: context.locale.invincible_mode_tile_title,
            onPressed: () =>
                _turnOnInvincibleMode(context, ref, !isInvincibleModeOn),
          ),
        ).sliver,

        DefaultListTile(
          position: ItemPosition.mid,
          isSelected: true,
          leadingIcon: FluentIcons.app_title_20_regular,
          titleText: "Include restriction groups",
          subtitleText: "Prevent modification during invincible mode.",
          onPressed: () {},
        ).sliver,
        DefaultListTile(
          position: ItemPosition.mid,
          isSelected: true,
          leadingIcon: FluentIcons.sleep_20_regular,
          titleText: "Include bedtime",
          subtitleText: "Prevent modification during invincible mode.",
          onPressed: () {},
        ).sliver,
        DefaultListTile(
          position: ItemPosition.end,
          isSelected: true,
          leadingIcon: FluentIcons.video_clip_multiple_20_regular,
          titleText: "Include wellbeing",
          subtitleText: "Prevent modification during invincible mode.",
          onPressed: () {},
        ).sliver,
      ],
    );
  }
}
