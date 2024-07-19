import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';

class UsageAccessPermission extends ConsumerWidget {
  const UsageAccessPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref
        .watch(permissionProvider.select((v) => v.haveUsageAccessPermission));

    return SliverPermissionWarning(
      havePermission: havePermission,
      margin: const EdgeInsets.only(bottom: 8),
      title: "Usage access",
      information:
          "Please grant usage access permission. This will allow Mindful to monitor app usage and manage access to certain apps, ensuring a more focused and controlled digital environment.",
      onTapAllow:
          ref.read(permissionProvider.notifier).askUsageAccessPermission,
    );
  }
}
