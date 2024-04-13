import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/screens/home/privacy/block_internet.dart';
import 'package:mindful/ui/screens/home/privacy/block_websites.dart';
import 'package:mindful/ui/common/segmented_icon_buttons.dart';
import 'package:sliver_tools/sliver_tools.dart';

final _selectedProvider = StateProvider<int>((ref) {
  return 0;
});

class TabPrivacy extends ConsumerWidget {
  const TabPrivacy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(_selectedProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              /// Appbar
              const SliverFlexibleAppBar(title: "Protection"),

              SliverFlexiblePinnedHeader(
                child: SegmentedIconButton(
                  selected: selectedIndex,
                  segments: const [
                    FluentIcons.shield_prohibited_20_regular,
                    FluentIcons.shield_globe_20_regular,
                  ],
                  onChange: (value) => ref
                      .read(_selectedProvider.notifier)
                      .update((state) => value),
                ),
              ),

              /// Body
              SliverAnimatedSwitcher(
                duration: 250.ms,
                switchInCurve: Curves.ease,
                switchOutCurve: Curves.ease,
                child: [
                  const BlockInternet(),
                  const BlockWebsites(),
                ][selectedIndex],
              ),
            ],
          ),

          /// Add more distracting websites button
          if (selectedIndex == 1)
            Positioned(
              bottom: 48,
              right: 16,
              child: FloatingActionButton(
                child: const Icon(FluentIcons.add_20_filled),
                onPressed: () {},
              ),
            )
        ],
      ),
    );
  }
}
