import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
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
  @override
  void initState() {
    super.initState();
    ref.read(activeSessionProvider.notifier).refreshActiveSessionState();
  }

  @override
  Widget build(BuildContext context) {
    final timeline = ref.watch(focusTimelineProvider);

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
                      "The total productive time in the selected month.",
                      icon: FluentIcons.clock_20_filled,
                    ),
                  ),
                ),
                8.hBox,
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    icon: FluentIcons.shifts_day_20_regular,
                    title: "Productive days",
                    info: "${timeline.totalProductiveDays} days",
                    onTap: () => context.showSnackAlert(
                      "The total number of productive days in the selected month.",
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
                "The total number of productive days in the selected month.",
                icon: FluentIcons.shifts_day_20_filled,
              ),
            ).sliver,

            const SliverContentTitle(title: "Calender"),
            HeatMapCalendar(
              /// NOTE - datasets map should only contain date and all time related fields should be 0
              datasets: timeline.daysTypeMap,
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
              onClick: ref.read(focusTimelineProvider.notifier).onDayChanged,
            ).sliver,

            8.vSliverBox,
            const SliverContentTitle(title: "Your sessions"),
            8.vSliverBox,

            /// List of today's sessions
            SliverList.builder(
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
