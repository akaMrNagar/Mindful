import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/sorted_apps_provider.dart';
import 'package:mindful/ui/common/async_error_indicator.dart';
import 'package:mindful/ui/common/async_loading_indicator.dart';
import 'package:mindful/ui/common/buttons.dart';
import 'package:mindful/ui/screens/home/dashboard/application_tile.dart';

class AnimatedAppsList extends ConsumerStatefulWidget {
  const AnimatedAppsList({
    super.key,
    required this.usageType,
  });

  final UsageType usageType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedAppsListState();
}

class _AnimatedAppsListState extends ConsumerState<AnimatedAppsList> {
  bool _showAllApps = false;

  @override
  Widget build(BuildContext context) {
    final sortedApps = ref.watch(sortedAppsProvider(_showAllApps));

    return sortedApps.when(
      loading: () => const SliverToBoxAdapter(child: AsyncLoadingIndicator()),
      error: (e, st) => SliverToBoxAdapter(child: AsyncErrorIndicator(e, st)),
      data: (packages) => SliverFixedExtentList.builder(
        itemExtent: 72,
        itemCount: packages.length + (_showAllApps ? 0 : 1),
        itemBuilder: (context, index) {
          if (index == packages.length) {
            return PrimaryButton(
              onPressed: () => setState(() => _showAllApps = !_showAllApps),
              child: const Text("Show all"),
            );
          }

          final app = ref.read(appsProvider).value?[packages[index]];
          return app == null
              ? const SizedBox()
              : ApplicationTile(
                  app: app,
                  usageType: UsageType.screenUsage,
                  day: 0,
                );
        },
      ),
    );
  }
}
