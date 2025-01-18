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
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/providers/focus_timeline_provider.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/focus/timeline/sliver_heatmap_calender.dart';
import 'package:mindful/ui/screens/focus/timeline/session_card.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TabTimeline extends ConsumerStatefulWidget {
  const TabTimeline({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabTimelineState();
}

class _TabTimelineState extends ConsumerState<TabTimeline> {
  @override
  void initState() {
    super.initState();
    ref
        .read(focusTimelineProvider.notifier)
        .onDayChanged(DateTime.now().dateOnly);
  }

  @override
  Widget build(BuildContext context) {
    final timeline = ref.watch(focusTimelineProvider);

    return Skeletonizer.zone(
      enabled: timeline.selectedDaysSessions.isLoading,
      ignorePointers: false,
      enableSwitchAnimation: true,
      child: DefaultRefreshIndicator(
        onRefresh: ref.read(focusTimelineProvider.notifier).refreshTimeline,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            StyledText(context.locale.timeline_tab_info).sliver,

            24.vSliverBox,

            /// Productivity stats
            Column(
              children: [
                Row(
                  children: [
                    /// Total productive time
                    Expanded(
                      child: UsageGlanceCard(
                        isPrimary: true,
                        position: ItemPosition.topLeft,
                        icon: FluentIcons.clock_20_regular,
                        title:
                            context.locale.selected_month_productive_time_label,
                        info: timeline.totalProductiveTime.toTimeShort(context),
                        onTap: () => context.showSnackAlert(
                          context.locale
                              .selected_month_productive_time_snack_alert(
                            timeline.totalProductiveTime.toTimeFull(context),
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
                        title:
                            context.locale.selected_month_productive_days_label,
                        info:
                            context.locale.nDays(timeline.totalProductiveDays),
                        onTap: () => context.showSnackAlert(
                          context.locale
                              .selected_month_productive_days_snack_alert(
                            timeline.totalProductiveDays,
                          ),
                          icon: FluentIcons.calendar_day_20_filled,
                        ),
                      ),
                    ),
                  ],
                ),

                4.vBox,

                /// Today's total focused time
                UsageGlanceCard(
                  isPrimary: true,
                  position: ItemPosition.bottom,
                  icon: FluentIcons.shifts_day_20_regular,
                  title: context.locale.selected_day_focused_time_label,
                  info: timeline.selectedDaysFocusedTime.toTimeFull(context),
                  onTap: () => context.showSnackAlert(
                    context.locale.selected_day_focused_time_snack_alert(
                      timeline.selectedDaysFocusedTime.toTimeFull(context),
                    ),
                    icon: FluentIcons.shifts_day_20_filled,
                  ),
                ),
              ],
            ).sliver,

            /// Calender
            ContentSectionHeader(title: context.locale.calender_heading).sliver,
            SliverHeatMapCalendar(
              heatmapData: timeline.monthlyFocusTimeMap,
              onDayChanged:
                  ref.read(focusTimelineProvider.notifier).onDayChanged,
              onMonthChanged:
                  ref.read(focusTimelineProvider.notifier).onMonthChanged,
            ),

            8.vSliverBox,
            ContentSectionHeader(title: context.locale.your_sessions_heading)
                .sliver,
            8.vSliverBox,

            /// List of today's sessions
            timeline.selectedDaysSessions.hasValue &&
                    timeline.selectedDaysSessions.value!.isNotEmpty
                ? SliverList.builder(
                    itemCount: timeline.selectedDaysSessions.value!.length,
                    itemBuilder: (context, index) => SessionCard(
                      position: getItemPositionInList(
                          index, timeline.selectedDaysSessions.value!.length),
                      session: timeline.selectedDaysSessions.value![index],
                    ),
                  )
                : SizedBox(
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
                  ).sliver,

            const SliverTabsBottomPadding(),
          ],
        ),
      ),
    );
  }
}
