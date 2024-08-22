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
import 'package:mindful/providers/active_session_provider.dart';
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
  void initState() {
    super.initState();
    ref.read(activeSessionProvider.notifier).refreshActiveSessionState();
  }

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
            const SliverFlexibleAppBar(title: "Timeline"),

            const StyledText(
              "Explore your focus journey by selecting a date from the calendar. Track your progress, revisit your successes, and learn from the challenges.",
            ).sliver,

            24.vSliverBox,

            /// Productivity stats
            Row(
              children: [
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    icon: FluentIcons.clock_20_regular,
                    title: "Productive time",
                    info: timeline.totalProductiveTime.toTimeShort(),
                    onTap: () => context.showSnackAlert(
                      "Your total productive time for the selected month is ${timeline.totalProductiveTime.toTimeFull()}.",
                      icon: FluentIcons.clock_20_filled,
                    ),
                  ),
                ),
                8.hBox,
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    icon: FluentIcons.calendar_day_20_regular,
                    title: "Productive days",
                    info: "${timeline.daysTypeMap.length} days",
                    onTap: () => context.showSnackAlert(
                      "You've had a total of ${timeline.totalProductiveDays} productive days in the selected month.",
                      icon: FluentIcons.shifts_day_20_filled,
                    ),
                  ),
                ),
              ],
            ).sliver,

            /// Today's total focused time
            UsageGlanceCard(
              isPrimary: true,
              icon: FluentIcons.shifts_day_20_regular,
              title: "Focused time",
              info: timeline.todaysFocusedTime.toTimeFull(),
              onTap: () => context.showSnackAlert(
                "Your total focused time for the selected day is ${timeline.todaysFocusedTime.toTimeFull()}.",
                icon: FluentIcons.shifts_day_20_filled,
              ),
            ).sliver,

            const SliverContentTitle(title: "Calender"),
            HeatMapCalendar(
              /// NOTE - datasets map should only contain date and all time related fields should be 0
              datasets: heatMapData,
              flexible: true,
              initDate: DateTime.now(),
              borderRadius: 10,
              showColorTip: false,
              colorMode: ColorMode.color,
              // monthFontSize: 0.1,
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
            const SliverContentTitle(title: "Your sessions"),
            8.vSliverBox,

            /// List of today's sessions
            timeline.todaysSessions.value?.isEmpty ?? false
                ? const SizedBox(
                    height: 256,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FluentIcons.emoji_sad_20_filled, size: 32),
                        StyledText(
                          "No focus sessions recorded for the selected day.",
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
