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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/status_label.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    required this.session,
    this.position,
  });

  final FocusSession session;
  final ItemPosition? position;

  @override
  Widget build(BuildContext context) {
    final stateLabels = [
      context.locale.focus_session_state_active,
      context.locale.focus_session_state_successful,
      context.locale.focus_session_state_failed,
    ];

    final stateColors = [
      Theme.of(context).colorScheme.tertiary,
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.error,
    ];

    final stateColor = stateColors[session.state.index];
    final stateLabel = stateLabels[session.state.index];
    final dateTime = session.startDateTime;

    return RoundedContainer(
      borderRadius: getBorderRadiusFromPosition(position ?? ItemPosition.none),
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      circularRadius: 24,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Skeleton.leaf(
              child: Icon(
                sessionTypeIcons[session.type] ??
                    FluentIcons.target_arrow_20_regular,
                size: 40,
              ),
            ),
          ),
          // 16.hBox,
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton.leaf(
                  child: StyledText(
                    sessionTypeLabels(context)[session.type] ?? 'Session',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                2.vBox,
                Skeleton.leaf(
                  child: StyledText(
                    "${context.locale.focus_session_tile_time_label}: ${dateTime.timeString(context)}",
                    color: Theme.of(context).hintColor,
                    fontSize: 14,
                  ),
                ),
                Skeleton.leaf(
                  child: StyledText(
                    "${context.locale.focus_session_tile_date_label}: ${dateTime.dateString(context)}",
                    color: Theme.of(context).hintColor,
                    fontSize: 14,
                  ),
                ),
                Skeleton.leaf(
                  child: StyledText(
                    "${context.locale.focus_session_tile_duration_label}: ${session.durationSecs.seconds.toTimeFull(context)}",
                    color: Theme.of(context).hintColor,
                    fontSize: 14,
                  ),
                ),

                16.vBox,

                /// State Label
                Skeleton.leaf(
                  child: StatusLabel(
                    label: stateLabel,
                    accent: stateColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
