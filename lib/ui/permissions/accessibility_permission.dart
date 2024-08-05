import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class AccessibilityPermission extends ConsumerWidget {
  /// Creates a animated [SliverPrimaryActionContainer] for asking permission from user
  /// with self handled state and automatically hides itself if the user have granted the permission
  const AccessibilityPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref
        .watch(permissionProvider.select((v) => v.haveAccessibilityPermission));

    return SliverPrimaryActionContainer(
      isVisible: !havePermission,
      margin: const EdgeInsets.only(top: 12),
      title: "Accessibility",
      information:
          "Please grant accessibility permission. This will allow Mindful to restrict access to short-form video content (e.g., Reels, Shorts) within social media apps and browsers, and filter inappropriate websites, creating a more secure and focused online environment.",
      onTapAction: !havePermission
          ? ref.read(permissionProvider.notifier).askAccessibilityPermission
          : null,
    );
  }
}
