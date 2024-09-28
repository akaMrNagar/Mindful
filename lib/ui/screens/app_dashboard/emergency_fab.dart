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
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';

class EmergencyFAB extends ConsumerWidget {
  const EmergencyFAB({
    super.key,
  });

  void _useEmergency(BuildContext context) async {
    int leftPasses =
        await MethodChannelService.instance.getLeftEmergencyPasses();

    if (!context.mounted) return;

    if (leftPasses <= 0) {
      context.showSnackAlert(context.locale.emergency_no_pass_left_snack_alert);
      return;
    }

    final confirmed = await showConfirmationDialog(
      context: context,
      icon: FluentIcons.fire_20_filled,
      heroTag: HeroTags.emergencyTileTag,
      title: context.locale.emergency_fab_button,
      info: context.locale.emergency_dialog_info(leftPasses),
      positiveLabel: context.locale.emergency_dialog_button_use_anyway,
    );

    if (!confirmed) return;
    final success = await MethodChannelService.instance.useEmergencyPass();

    if (!success && context.mounted) {
      context.showSnackAlert(
        context.locale.emergency_already_active_snack_alert,
        icon: FluentIcons.fire_16_filled,
      );
    } else if (context.mounted) {
      context.showSnackAlert(
        context.locale.emergency_started_snack_alert,
        icon: FluentIcons.fire_16_filled,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      heroTag: HeroTags.emergencyTileTag,
      label: Text(context.locale.emergency_fab_button),
      icon: const Icon(FluentIcons.fire_20_filled),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: () => _useEmergency(context),
    );
  }
}
