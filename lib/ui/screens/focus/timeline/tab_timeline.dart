import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/active_session_provider.dart';
import 'package:mindful/providers/sessions_provider.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/screens/focus/timeline/session_tile.dart';
import 'package:mindful/ui/screens/home/dashboard/usage_glance_card.dart';

class TabTimeline extends ConsumerStatefulWidget {
  const TabTimeline({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabTimelineState();
}

class _TabTimelineState extends ConsumerState<TabTimeline> {
  Map<DateTime, int> _heatMapDataSet = {};
  DateTime _selectedDateOnly = DateTime.now().dateOnly;

  @override
  void initState() {
    super.initState();
    // IsarDbService.instance.resetDb();
    ref.read(activeSessionProvider.notifier).refreshActiveSessionState();
    _loadHeatmapData(DateTime.now());
  }

  void _loadHeatmapData(DateTime month) async {
    final data = await ref
        .read(sessionsProvider.notifier)
        .loadHeatmapDataSetsForMonth(month: month);

    setState(() => _heatMapDataSet = data);
  }

  @override
  Widget build(BuildContext context) {
    /// Manually update selected day Due to the fact that [HeatMapCalendar] does
    /// not allow to change color for the selected day
    final dataSets = {..._heatMapDataSet}
      ..update(_selectedDateOnly, (_) => -1, ifAbsent: () => -1);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        const SliverFlexibleAppBar(title: "Timeline"),

        8.vSliverBox,
        Row(
          children: [
            Expanded(
              child: UsageGlanceCard(
                isPrimary: true,
                icon: FluentIcons.clock_20_regular,
                title: "Productive time",
                info: 231.minutes.toTimeShort(),
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
                info: "7 days",
                onTap: () => context.showSnackAlert(
                  "The total number of productive days in the selected month.",
                  icon: FluentIcons.shifts_day_20_filled,
                ),
              ),
            ),
          ],
        ).sliver,

        UsageGlanceCard(
          icon: FluentIcons.shifts_day_20_regular,
          title: "Focused time",
          info: 314.minutes.toTimeFull(),
          onTap: () => context.showSnackAlert(
            "The total number of productive days in the selected month.",
            icon: FluentIcons.shifts_day_20_filled,
          ),
        ).sliver,
        // 12.vSliverBox,
        // 8.vSliverBox,

        const SliverContentTitle(title: "Calender"),
        HeatMapCalendar(
          /// NOTE - datasets map should only contain date and all time related fields should be 0
          datasets: dataSets,
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
          onMonthChange: _loadHeatmapData,
          onClick: (day) {
            setState(() => _selectedDateOnly = day.dateOnly);
            ref.read(sessionsProvider.notifier).loadSessionsForDay(day);
          },
        ).sliver,

        // const SliverContentTitle(title: "16 August 2024"),

        8.vSliverBox,
        const SliverContentTitle(title: "Focus Sessions"),
        8.vSliverBox,

        /// List of sessions
        ref.watch(sessionsProvider).when(
              loading: () => const CircularProgressIndicator().centered.sliver,
              error: (e, st) =>
                  const CircularProgressIndicator().centered.sliver,
              data: (sessions) => SliverList.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) =>
                    SessionTile(session: sessions[index]),
              ),
            ),

        const SliverTabsBottomPadding(),
        // TextButton(
        //   onPressed: IsarDbService.instance.insertFakeSessions,
        //   child: const Text("Fake Data"),
        // ).centered.sliver,
      ],
    );
  }
}
