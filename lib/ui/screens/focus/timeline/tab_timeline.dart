import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/providers/active_session_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';

class TabTimeline extends ConsumerStatefulWidget {
  const TabTimeline({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabTimelineState();
}

class _TabTimelineState extends ConsumerState<TabTimeline> {
  List<FocusSession> _sessions = [];

  @override
  void initState() {
    super.initState();
    ref.read(activeSessionProvider.notifier).refreshActiveSessionState();
    // IsarDbService.instance.resetDb();
    load();
  }

  void load() async {
    final sessions = await IsarDbService.instance.loadAllFocusSessions();
    setState(() => _sessions = sessions);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        const SliverFlexibleAppBar(title: "Timeline"),

        SliverList.builder(
          itemCount: _sessions.length,
          itemBuilder: (context, index) => RoundedContainer(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // StyledText(_sessions[index].uId.toString()),
                StyledText(_sessions[index].id.toString()),
                StyledText(_sessions[index].startTime.toString()),
                StyledText(_sessions[index].duration.toTimeShort()),
                StyledText(_sessions[index].state.toString()),
                StyledText(_sessions[index].type.toString()),
              ],
            ),
          ),
        )
      ],
    );
  }
}
