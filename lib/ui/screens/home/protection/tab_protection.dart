import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/protection_provider.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/screens/home/protection/block_internet_page.dart';
import 'package:mindful/ui/common/segmented_icon_buttons.dart';
import 'package:mindful/ui/screens/home/protection/block_websites_page.dart';
import 'package:sliver_tools/sliver_tools.dart';

final _selectedProvider = StateProvider<int>((ref) {
  return 0;
});

class TabProtection extends ConsumerWidget {
  const TabProtection({super.key});

  void onPressedFab(BuildContext context, WidgetRef ref) async {
    final url = await showInputWebsiteDialog(context);
    if (url == null) return;
    debugPrint("URL: $url");

    try {
      /// Extract host
      final host = Uri.parse(url).host;
      if (host.isEmpty) {
        throw Exception("Unable to parse url");
      } else {
        /// Add to distraction sites list
        ref.read(protectionProvider.notifier).addSiteToBlockedList(host);
      }

      debugPrint("HOST: $host");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
                  const BlockInternetPage(),
                  const BlockWebsitesPage(),
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
                heroTag: 'InputWebsiteDialog',
                onPressed: () => onPressedFab(context, ref),
                child: const Icon(FluentIcons.add_20_filled),
              ),
            )
        ],
      ),
    );
  }
}
