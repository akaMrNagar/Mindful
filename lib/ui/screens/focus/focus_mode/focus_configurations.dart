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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/device_dnd_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/permissions/dnd_switch_tile.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FocusConfigurations extends ConsumerWidget {
  const FocusConfigurations({super.key});

  void _pickSessionDuration(
    BuildContext context,
    WidgetRef ref,
    int prevTimer,
  ) async {
    final newTimer = await showFocusTimerPicker(
      heroTag: HeroTags.focusModeTimerTileTag,
      context: context,
      initialTime: prevTimer,
    );

    if (newTimer == null || newTimer == prevTimer) return;
    ref.read(focusModeProvider.notifier).setSessionDuration(newTimer);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionType =
        ref.watch(focusModeProvider.select((v) => v.focusMode.sessionType));

    final shouldStartDnd = ref
        .watch(focusModeProvider.select((v) => v.focusProfile.shouldStartDnd));

    final sessionDuration = ref
        .watch(focusModeProvider.select((v) => v.focusProfile.sessionDuration));

    final isSessionActive =
        ref.watch(focusModeProvider.select((v) => v.activeSession != null));

    return MultiSliver(
      children: [
        ContentSectionHeader(
          title: context.locale.quick_actions_heading,
        ).sliver,

        /// Session tag
        DefaultDropdownTile<SessionType>(
          position: ItemPosition.start,
          enabled: !isSessionActive,
          titleText: context.locale.focus_session_tile_title,
          dialogIcon: FluentIcons.door_tag_20_filled,
          value: sessionType,
          onSelected: ref.read(focusModeProvider.notifier).setSessionType,
          items: sessionTypeLabels(context)
              .entries
              .map((e) => DefaultDropdownItem(label: e.value, value: e.key))
              .toList(),
        ).sliver,

        /// Session timer
        DefaultHero(
          tag: HeroTags.focusModeTimerTileTag,
          child: DefaultListTile(
            position: ItemPosition.mid,
            enabled: !isSessionActive,
            titleText: context.locale.focus_session_duration_tile_title,
            subtitle: StyledText(
              sessionDuration > 0
                  ? sessionDuration.seconds.toTimeFull(context)
                  : context.locale.focus_session_duration_tile_subtitle,
              fontSize: 14,
              isSubtitle: true,
            ),
            onPressed: () => _pickSessionDuration(
              context,
              ref,
              sessionDuration,
            ),
          ),
        ),

        /// Should start dnd
        DndSwitchTile(
          enabled: !isSessionActive,
          switchValue: shouldStartDnd,
          position: ItemPosition.mid,
          onPressed: () => ref
              .read(focusModeProvider.notifier)
              .setShouldStartDnd(!shouldStartDnd),
        ).sliver,

        /// Manage Dnd settings
        const DeviceDndTile(
          position: ItemPosition.end,
        ).sliver,
      ],
    );
  }
}
