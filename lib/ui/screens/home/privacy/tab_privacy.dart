import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/screens/home/privacy/block_internet.dart';
import 'package:mindful/ui/screens/home/privacy/block_websites.dart';
import 'package:mindful/ui/widgets/segmented_icon_buttons.dart';

final _selectedProvider = StateProvider<int>((ref) {
  return 0;
});

class TabPrivacy extends ConsumerWidget {
  const TabPrivacy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(_selectedProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        24.vBox(),

        SegmentedIconButton(
          selected: selectedIndex,
          segments: const [
            FluentIcons.app_recent_20_regular,
            FluentIcons.globe_search_20_regular,
          ],
          onChange: (value) =>
              ref.read(_selectedProvider.notifier).update((state) => value),
        ),

        16.vBox(),
        [
          const BlockInternet(),
          const BlockWebsites(),
        ][selectedIndex]

        ///
      ],
    );
  }
}
