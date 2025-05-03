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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/providers/focus/dated_focus_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/status_label.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class SessionCard extends ConsumerWidget {
  const SessionCard({
    super.key,
    required this.session,
    this.position,
  });

  final FocusSession session;
  final ItemPosition? position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final borderRadius =
        getBorderRadiusFromPosition(position ?? ItemPosition.none);

    return DefaultHero(
      tag: HeroTags.sessionReflectionTag(session.id),
      child: RoundedContainer(
        borderRadius: borderRadius,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.symmetric(vertical: 2),
        color: stateColor.withAlpha(20),
        circularRadius: 24,
        onPressed: () async {
          final reflection = await showFocusReflectionDialog(
            context: context,
            heroTag: HeroTags.sessionReflectionTag(session.id),
            initialText: session.reflection,
          );

          if (reflection == null || reflection == session.reflection) return;
          ref
              .read(datedFocusProvider(dateToday).notifier)
              .updateSession(session.copyWith(reflection: reflection));
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            DefaultListTile(
              color: Colors.transparent,
              leadingIcon: sessionTypeIcons[session.type] ??
                  FluentIcons.target_arrow_20_regular,

              /// Session type
              titleText: sessionTypeLabels(context)[session.type] ?? 'Session',

              /// Timestamp
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledText(
                    session.startDateTime.dateTimeString(context),
                    color: Theme.of(context).hintColor,
                    fontSize: 14,
                  ),

                  12.vBox,

                  /// State Label
                  StatusLabel(
                    label: stateLabel,
                    accent: stateColor,
                  ),
                ],
              ),

              /// Duration
              trailing: StyledText(
                session.durationSecs.seconds.toTimeShort(context),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// Reflection
            if (session.reflection.isNotEmpty)
              RoundedContainer(
                color: stateColor.withAlpha(20),
                margin: const EdgeInsets.all(0),
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(12),
                borderRadius: borderRadius.copyWith(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 64),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: StyledText(
                      session.reflection,
                      color: Theme.of(context).hintColor,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
