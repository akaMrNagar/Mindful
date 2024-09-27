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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/screens/home/bedtime/schedule_card.dart';
import 'package:mindful/ui/screens/home/bedtime/sliver_quick_actions.dart';

class TabBedtime extends ConsumerWidget {
  const TabBedtime({super.key});

  void _setScheduleStatus(
    WidgetRef ref,
    BuildContext context,
    bool shouldStart,
  ) async {
    final state = ref.read(bedtimeProvider);

    // If the total duration is less than 30 minutes
    if (state.totalDuration.inMinutes < 30) {
      context.showSnackAlert(
        context.locale.bedtime_minimum_duration_snack_alert,
      );
      return;
    }

    // If no distracting apps selected
    if (shouldStart && state.distractingApps.isEmpty) {
      context.showSnackAlert(
        context.locale.bedtime_minimum_apps_snack_alert,
      );
      return;
    }

    ref.read(bedtimeProvider.notifier).switchBedtimeSchedule(shouldStart);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScheduleOn =
        ref.watch(bedtimeProvider.select((v) => v.isScheduleOn));

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        SliverFlexibleAppBar(title: context.locale.bedtime_tab_title),

        /// Information about bedtime
        StyledText(context.locale.bedtime_tab_info).sliver,

        SliverContentTitle(title: context.locale.schedule_tile_title),

        /// Card with start and end time for schedule
        /// also schedule days
        const ScheduleCard().sliver,

        8.vSliverBox,

        /// Bedtime schedule status toggler
        DefaultListTile(
          isPrimary: true,
          switchValue: isScheduleOn,
          leadingIcon: FluentIcons.sleep_20_regular,
          titleText: context.locale.schedule_tile_title,
          subtitleText: context.locale.schedule_tile_subtitle,
          onPressed: () => _setScheduleStatus(ref, context, !isScheduleOn),
        ).sliver,

        8.vSliverBox,

        /// Actions related to bedtime
        const SliverQuickActions(),

        const SliverTabsBottomPadding()
      ],
    );
  }
}
