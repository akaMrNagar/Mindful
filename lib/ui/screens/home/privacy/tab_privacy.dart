import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/components/flexible_appbar.dart';
import 'package:mindful/ui/screens/home/privacy/block_internet.dart';
import 'package:mindful/ui/screens/home/privacy/block_websites.dart';
import 'package:mindful/ui/common/components/segmented_icon_buttons.dart';

final _selectedProvider = StateProvider<int>((ref) {
  return 0;
});

class TabPrivacy extends ConsumerWidget {
  const TabPrivacy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(_selectedProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 12),
      child: CustomScrollView(
        slivers: [
          /// Appbar
          const FlexibleAppBar(title: "Protection"),

          SegmentedIconButton(
            selected: selectedIndex,
            segments: const [
              FluentIcons.shield_prohibited_20_regular,
              FluentIcons.shield_globe_20_regular,
            ],
            onChange: (value) =>
                ref.read(_selectedProvider.notifier).update((state) => value),
          ).toSliverBox(),

          16.vSliverBox(),
          [
            const BlockInternet(),
            const BlockWebsites(),
          ][selectedIndex]
              .toSliverBox()

          ///
        ],
      ),
    );
  }
}
