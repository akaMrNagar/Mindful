import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/screens/device_network_stats_screen.dart';
import 'package:mindful/screens/mindful_settings_screen.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

class QuickActions extends ConsumerWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: EdgeInsets.zero,
      primary: false,
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        // _GridTile(
        //   label: "Stats",
        //   iconData: FluentIcons.data_pie_20_regular,
        //   onPressed: () {
        //     // ref.read(deviceAppsProvider.notifier).refreshScreenUsageWeek();
        //     Navigator.of(context).push(
        //       CupertinoPageRoute(
        //           builder: (context) => const DeviceTimeScreen()),
        //     );
        //     // ref.read(deviceUsageInfoProvider.notifier).refreshScreenUsageWeek();
        //   },
        // ),
        _GridTile(
          label: "Quick focus",
          iconData: FluentIcons.target_arrow_20_regular,
          onPressed: () {
            // ref.read(deviceUsageProvider.notifier).refreshScreenUsageWeek();
          },
          // onPressed: () => homeScreenController.goToQuickFocusScreen(),
        ),
        const _GridTile(
          label: "Bedtime",
          iconData: FluentIcons.sleep_20_regular,
          // onPressed: () => homeScreenController.goToBedTimeScreen(),
        ),
        const _GridTile(
          label: "Lock sites",
          iconData: FluentIcons.globe_20_regular,
          // onPressed: () => homeScreenController.goToLockSitesScreen(),
        ),
        _GridTile(
          label: "Data Monitor",
          iconData: FluentIcons.circle_half_fill_20_regular,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => const DeviceNetworkStatsScreen(),
              ),
            );
          },
        ),
        _GridTile(
          label: "Settings",
          iconData: FluentIcons.settings_20_regular,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => const MindfulSettingsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _GridTile extends StatelessWidget {
  const _GridTile({
    required this.label,
    required this.iconData,
    this.onPressed,
  });

  final String label;
  final IconData iconData;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RepaintBoundary(
      child: InteractiveCard(
        circularRadius: 16,
        onPressed: onPressed ?? () {},
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Icon(
              iconData,
              size: 42,
              color: theme.disabledColor,
            ),
            const Spacer(flex: 3),
            SubtitleText(label, size: 14, weight: FontWeight.w600),
          ],
        ),
      ).animate().fadeIn().moveY(
            begin: 50,
            end: 0,
            duration: 250.ms,
            curve: Curves.easeOutBack,
          ),
    );
  }
}
