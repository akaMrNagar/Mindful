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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/notification_schedules_provider.dart';
import 'package:mindful/ui/common/default_fab_button.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';

class NewNotificationScheduleFab extends ConsumerWidget {
  const NewNotificationScheduleFab({super.key});

  void _onPressed(BuildContext context, WidgetRef ref) async {
    final scheduleName = await showNotificationScheduleNameDialog(
      context: context,
      heroTag: HeroTags.newNotificationScheduleFABTag,
    );

    if (scheduleName == null || scheduleName.isEmpty) return;

    /// Create new schedule
    ref
        .read(notificationSchedulesProvider.notifier)
        .createNewSchedule(scheduleName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultFabButton(
      heroTag: HeroTags.newNotificationScheduleFABTag,
      label: context.locale.new_schedule_fab_button,
      icon: FluentIcons.add_20_filled,
      onPressed: () => _onPressed(context, ref),
    );
  }
}
