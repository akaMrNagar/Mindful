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
      context.showSnackAlert(
        "You have used all your emergency passes. The blocked apps will stay blocked until midnight, or the active focus session ends.",
      );
      return;
    }

    final confirmed = await showConfirmationDialog(
      context: context,
      icon: FluentIcons.fire_20_filled,
      heroTag: HeroTags.emergencyTileTag,
      title: "Emergency",
      info:
          "This action will pause the app blocker for next 5 minutes. You have $leftPasses passes left. After using all passes, the app will stay blocked until midnight, or the active focus session ends.\n\nDo you still wish to proceed?",
      positiveLabel: "Use anyway",
    );

    if (!confirmed) return;
    final success = await MethodChannelService.instance.useEmergencyPass();

    if (!success && context.mounted) {
      context.showSnackAlert(
        "The app blocker is currently either paused or inactive. If notifications are enabled, you will receive updates regarding the remaining time.",
        icon: FluentIcons.fire_16_filled,
      );
    } else if (context.mounted) {
      context.showSnackAlert(
        "The app blocker is paused and will resume blocking in 5 minutes.",
        icon: FluentIcons.fire_16_filled,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      heroTag: HeroTags.emergencyTileTag,
      label: const Text("Emergency"),
      icon: const Icon(FluentIcons.fire_20_filled),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: () => _useEmergency(context),
    );
  }
}
