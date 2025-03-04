import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';
import 'package:mindful/ui/permissions/accessibility_permission_card.dart';

class AccessibilityTip extends ConsumerWidget {
  const AccessibilityTip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
      permissionProvider.select((v) => v.haveAccessibilityPermission),
    );

    final prob = Random().nextInt(11);

    return SliverPrimaryActionContainer(
      isVisible: !havePermission && prob == 1,
      icon: FluentIcons.lightbulb_filament_20_filled,
      margin: const EdgeInsets.only(bottom: 4),
      title: context.locale.tip_container_title,
      information: context.locale.accessibility_tip,
      positiveBtn: FilledButton(
        child: Text(context.locale.permission_button_grant_permission),
        onPressed: () => const AccessibilityPermissionCard()
            .showAccessibilityPermissionSheet(context, ref),
      ),
    );
  }
}
