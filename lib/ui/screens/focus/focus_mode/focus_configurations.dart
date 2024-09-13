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
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/device_dnd_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/permissions/dnd_switch_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FocusConfigurations extends ConsumerWidget {
  const FocusConfigurations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionType =
        ref.watch(focusModeProvider.select((v) => v.sessionType));
    final shouldStartDnd =
        ref.watch(focusModeProvider.select((v) => v.shouldStartDnd));

    return MultiSliver(
      children: [
        const SliverContentTitle(title: "Configurations"),

        /// Session tag
        DefaultDropdownTile<SessionType>(
          label: "Focus session",
          dialogIcon: FluentIcons.door_tag_20_filled,
          value: sessionType,
          onSelected: ref.read(focusModeProvider.notifier).setSessionType,
          items: sessionTypeLabels.entries
              .map((e) => DefaultDropdownItem(label: e.value, value: e.key))
              .toList(),
        ).sliver,

        /// Should start dnd
        DndSwitchTile(
          switchValue: shouldStartDnd,
          onPressed: () => ref
              .read(focusModeProvider.notifier)
              .setShouldStartDnd(!shouldStartDnd),
        ).sliver,

        /// Manage Dnd settings
        const DeviceDndTile().sliver,
      ],
    );
  }
}
