import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/common/segmented_icon_buttons.dart';
import 'package:mindful/ui/screens/home/wellbeing/distraction_blocker_page.dart';
import 'package:mindful/ui/screens/home/wellbeing/internet_blocker_page.dart';
import 'package:sliver_tools/sliver_tools.dart';

final _selectedProvider = StateProvider<int>((ref) {
  return 0;
});

class TabWellbeing extends ConsumerWidget {
  const TabWellbeing({super.key});

  void _onPressedFab(BuildContext context, WidgetRef ref) async {
    final url = await showInputWebsiteDialog(context);
    if (url == null || url.isEmpty) return;

    final host =
        await MethodChannelService.instance.parseUrl(url.toLowerCase());

    if (host.isNotEmpty && host.contains('.') && !host.contains(' ')) {
      /// Check if url is already blocked
      if (ref.read(wellbeingProvider).blockedWebsites.contains(host)) {
        await MethodChannelService.instance.showToast("Url already added");
        return;
      }

      /// Add to blocked sites list
      ref.read(wellbeingProvider.notifier).insertRemoveBlockedSite(host, true);
    } else {
      await MethodChannelService.instance
          .showToast("Invalid url! cannot parse host name");
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
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Appbar
              const SliverFlexibleAppBar(title: "Wellbeing"),

              SliverFlexiblePinnedHeader(
                child: SegmentedIconButton(
                  selected: selectedIndex,
                  segments: const [
                    FluentIcons.globe_20_regular,
                    FluentIcons.cursor_click_20_regular,
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
                  const InternetBlockerPage(),
                  const DistractionBlockerPage(),
                ][selectedIndex],
              ),
            ],
          ),

          /// Add more distracting websites button
          if (selectedIndex == 1)
            Positioned(
              bottom: 64,
              right: 24,
              child: FloatingActionButton(
                heroTag: 'InputWebsiteDialog',
                onPressed: () => _onPressedFab(context, ref),
                child: const Icon(FluentIcons.add_20_filled),
              ),
            )
        ],
      ),
    );
  }
}
