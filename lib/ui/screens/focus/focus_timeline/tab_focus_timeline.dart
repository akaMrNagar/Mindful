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
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/providers/focus/dated_focus_provider.dart';
import 'package:mindful/providers/focus/monthly_focus_provider.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/empty_list_indicator.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/screens/focus/focus_timeline/session_card.dart';
import 'package:mindful/ui/screens/focus/focus_timeline/sliver_heatmap_calender.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TabFocusTimeline extends ConsumerStatefulWidget {
  const TabFocusTimeline({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabTimelineState();
}

class _TabTimelineState extends ConsumerState<TabFocusTimeline> {
  DateTimeRange _monthRange = dateToday.monthRange;
  DateTime _selectedDay = dateToday;

  @override
  Widget build(BuildContext context) {
    final monthlyFocus = ref.watch(monthlyFocusProvider(_monthRange));
    final dailyFocus = ref.watch(datedFocusProvider(_selectedDay));

    return DefaultRefreshIndicator(
      onRefresh: () async {
        await ref
            .read(datedFocusProvider(_selectedDay).notifier)
            .refreshTimeline();
        await ref
            .read(monthlyFocusProvider(_monthRange).notifier)
            .refreshTimeline();
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          StyledText(context.locale.focus_timeline_tab_info).sliver,

          24.vSliverBox,

          /// Productivity stats
          IntrinsicHeight(
            child: Row(
              children: [
                /// Total productive time
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    position: ItemPosition.topLeft,
                    icon: FluentIcons.clock_20_regular,
                    title: context.locale.focus_monthly_label,
                    info: monthlyFocus.totalProductiveTime.toTimeShort(context),
                    onTap: () => context.showSnackAlert(
                      context.locale.selected_month_productive_time_snack_alert(
                        monthlyFocus.totalProductiveTime.toTimeFull(context),
                      ),
                      icon: FluentIcons.clock_20_filled,
                    ),
                  ),
                ),
                4.hBox,

                /// Productive days
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    position: ItemPosition.topRight,
                    icon: FluentIcons.calendar_day_20_regular,
                    title: context.locale.selected_month_productive_days_label,
                    info:
                        context.locale.nDays(monthlyFocus.totalProductiveDays),
                    onTap: () => context.showSnackAlert(
                      context.locale.selected_month_productive_days_snack_alert(
                        monthlyFocus.totalProductiveDays,
                      ),
                      icon: FluentIcons.calendar_day_20_filled,
                    ),
                  ),
                ),
              ],
            ),
          ).sliver,

          4.vSliverBox,

          /// Today's total focused time
          Skeletonizer.zone(
            enabled: dailyFocus.selectedDaysSessions.isLoading,
            ignorePointers: false,
            child: UsageGlanceCard(
              isPrimary: true,
              position: ItemPosition.bottom,
              icon: FluentIcons.shifts_day_20_regular,
              title: context.locale.selected_day_focused_time_label,
              info: dailyFocus.selectedDaysFocusedTime.toTimeFull(context),
              onTap: () => context.showSnackAlert(
                context.locale.selected_day_focused_time_snack_alert(
                  dailyFocus.selectedDaysFocusedTime.toTimeFull(context),
                ),
                icon: FluentIcons.shifts_day_20_filled,
              ),
            ),
          ).sliver,

          /// Calender
          ContentSectionHeader(title: context.locale.calender_heading).sliver,
          SliverHeatMapCalendar(
            heatmapData: monthlyFocus.monthlyFocus,
            onDayChanged: (day) => setState(() => _selectedDay = day),
            onMonthChanged: (date) =>
                setState(() => _monthRange = date.monthRange),
          ),

          8.vSliverBox,
          ContentSectionHeader(title: context.locale.your_sessions_heading)
              .sliver,
          8.vSliverBox,

          /// List of today's sessions
          dailyFocus.selectedDaysSessions.hasValue &&
                  dailyFocus.selectedDaysSessions.value!.isNotEmpty
              ? SliverList.builder(
                  itemCount: dailyFocus.selectedDaysSessions.value!.length,
                  itemBuilder: (context, index) => SessionCard(
                    position: getItemPositionInList(
                      index,
                      dailyFocus.selectedDaysSessions.value!.length,
                    ),
                    session: dailyFocus.selectedDaysSessions.value![index],
                  ),
                )
              : EmptyListIndicator(
                  info: context.locale.your_sessions_empty_list_hint,
                ).sliver,

          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}
