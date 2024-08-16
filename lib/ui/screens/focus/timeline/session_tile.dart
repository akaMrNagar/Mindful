import 'package:flutter/material.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({
    super.key,
    required this.session,
  });

  final FocusSession session;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText(sessionTypeLabels[session.type] ?? 'Session'),
          StyledText(session.startTime.toString()),
          StyledText(session.duration.toTimeShort()),
          StyledText(session.state.toString()),
        ],
      ),
    );
  }
}
