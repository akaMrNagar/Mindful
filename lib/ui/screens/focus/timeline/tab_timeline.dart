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
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/providers/focus_timeline_provider.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/focus/timeline/session_tile.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TabTimeline extends ConsumerStatefulWidget {
  const TabTimeline({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabTimelineState();
}

class _TabTimelineState extends ConsumerState<TabTimeline> {
  DateTime _selectedDay = DateTime.now().dateOnly;

  @override
  Widget build(BuildContext context) {
    final timeline = ref.watch(focusTimelineProvider);

    /// Manually update selected day Due to the fact that [HeatMapCalendar] does
    /// not allow to change color for the selected day
    /// NOTE - Key value for days
    /// -1 for selected day
    /// 1 for productive days
    final heatMapData = {...timeline.daysTypeMap}..update(
        _selectedDay,
        (_) => -1,
        ifAbsent: () => -1,
      );

    return Skeletonizer.zone(
      enabled: timeline.todaysSessions.isLoading,
      ignorePointers: false,
      enableSwitchAnimation: true,
      child: DefaultRefreshIndicator(
        onRefresh: ref.read(focusTimelineProvider.notifier).refreshTimeline,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Appbar
            SliverFlexibleAppBar(title: context.locale.timeline_tab_title),

            StyledText(context.locale.timeline_tab_info).sliver,

            24.vSliverBox,

            /// Productivity stats
            Row(
              children: [
                /// Total productive time
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    icon: FluentIcons.clock_20_regular,
                    title: context.locale.selected_month_productive_time_label,
                    info: timeline.totalProductiveTime.toTimeShort(),
                    onTap: () => context.showSnackAlert(
                      context.locale.selected_month_productive_time_snack_alert(
                        timeline.totalProductiveTime.toTimeFull(),
                      ),
                      icon: FluentIcons.clock_20_filled,
                    ),
                  ),
                ),
                8.hBox,

                /// Productive days
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    icon: FluentIcons.calendar_day_20_regular,
                    title: context.locale.selected_month_productive_days_label,
                    info: "${timeline.daysTypeMap.length} days",
                    onTap: () => context.showSnackAlert(
                      context.locale.selected_month_productive_days_snack_alert(
                        timeline.totalProductiveDays,
                      ),
                      icon: FluentIcons.calendar_day_20_filled,
                    ),
                  ),
                ),
              ],
            ).sliver,

            /// Today's total focused time
            UsageGlanceCard(
              isPrimary: true,
              icon: FluentIcons.shifts_day_20_regular,
              title: context.locale.selected_day_focused_time_label,
              info: timeline.todaysFocusedTime.toTimeFull(),
              onTap: () => context.showSnackAlert(
                context.locale.selected_day_focused_time_snack_alert(
                  timeline.todaysFocusedTime.toTimeFull(),
                ),
                icon: FluentIcons.shifts_day_20_filled,
              ),
            ).sliver,

            SliverContentTitle(title: context.locale.calender_heading),
            HeatMapCalendar(
              /// NOTE - datasets map should only contain date and all time related fields should be 0
              datasets: heatMapData,
              flexible: true,
              initDate: DateTime.now(),
              borderRadius: 10,
              colorMode: ColorMode.color,
              weekTextColor: Theme.of(context).iconTheme.color,
              textColor: Theme.of(context).iconTheme.color,
              defaultColor: Colors.transparent,
              colorsets: {
                /// NOTE - Key for colors
                /// -1 for selected day
                /// 1 for productive days
                -1: Theme.of(context).colorScheme.primary,
                1: Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.5),
              },
              onMonthChange:
                  ref.read(focusTimelineProvider.notifier).onMonthChanged,
              onClick: (day) {
                _selectedDay = day;
                ref.read(focusTimelineProvider.notifier).onDayChanged(day);
              },
            ).sliver,

            8.vSliverBox,
            SliverContentTitle(title: context.locale.your_sessions_heading),
            8.vSliverBox,

            /// List of today's sessions
            timeline.todaysSessions.value?.isEmpty ?? false
                ? SizedBox(
                    height: 256,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FluentIcons.emoji_sad_20_filled, size: 32),
                        StyledText(
                          context.locale.your_sessions_empty_list_hint,
                          fontSize: 14,
                          isSubtitle: true,
                        ),
                      ],
                    ),
                  ).sliver
                : SliverList.builder(
                    itemCount: timeline.todaysSessions.value?.length ?? 5,
                    itemBuilder: (context, index) => SessionTile(
                      session: timeline.todaysSessions.value?[index] ??
                          FocusSession.placeholder(),
                    ),
                  ),

            const SliverTabsBottomPadding(),
          ],
        ),
      ),
    );
  }
}
