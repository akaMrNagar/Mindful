import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';

class AccessibilityPermission extends ConsumerWidget {
  const AccessibilityPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref
        .watch(permissionProvider.select((v) => v.haveAccessibilityPermission));

    return SliverPermissionWarning(
      havePermission: havePermission,
      margin: const EdgeInsets.only(top: 12),
      title: "Accessibility",
      information:
          "Please grant accessibility permission. This will allow Mindful to restrict access to short-form video content (e.g., Reels, Shorts) within social media apps and browsers, and filter inappropriate websites, creating a more secure and focused online environment.",
      onTapAllow:
          ref.read(permissionProvider.notifier).askAccessibilityPermission,
    );
  }
}
