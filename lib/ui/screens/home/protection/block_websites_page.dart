import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/protection_provider.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:mindful/ui/screens/home/bedtime/distracting_apps_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

final _isExpandedProvider = StateProvider<bool>((ref) => false);

class BlockWebsitesPage extends ConsumerWidget {
  const BlockWebsitesPage({super.key});

  Future<void> _showBrowserSelectionDialog() async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockedSites =
        ref.watch(protectionProvider.select((v) => v.blockedWebsites));

    final blockNsfw =
        ref.watch(protectionProvider.select((value) => value.blockNsfwSites));

    final isWebsitesBlockerOn =
        ref.watch(protectionProvider.select((value) => value.websitesBlocker));

    final isBrowserListExpanded = ref.watch(_isExpandedProvider);

    return MultiSliver(
      children: [
        SliverFlexiblePinnedHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.vBox(),
              const StatefulText(
                "Silence your phone, change screen to black and white at bedtime. Only alarms and important calls can reach you.",
                isActive: false,
              ),
              12.vBox(),

              /// Status switch
              SwitchableListTile(
                isPrimary: true,
                leadingIcon: FluentIcons.globe_search_20_regular,
                titleText: "Websites blocker",
                subTitleText: "Block distracting sites",
                value: isWebsitesBlockerOn,
                onPressed: () => ref
                    .read(protectionProvider.notifier)
                    .toggleWebsitesBlocker(!isWebsitesBlockerOn),
              ),
            ],
          ),
        ),

        4.vSliverBox(),

        /// Distracting websites header
        const SliverFlexiblePinnedHeader(
          minHeight: 32,
          maxHeight: 48,
          alignment: Alignment.centerLeft,
          child: Text("Quick actions"),
        ),

        /// Nsfw switch
        SwitchableListTile(
          leadingIcon: FluentIcons.globe_video_20_regular,
          titleText: "Block NSFW",
          subTitleText: "Block adult and porn sites",
          value: blockNsfw,
          onPressed: () =>
              ref.read(protectionProvider.notifier).toggleBlockNsfw(!blockNsfw),
        ),

        4.vSliverBox(),

        /// Manage selected browsers
        RoundedContainer(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          // onPressed: _showBrowserSelectionDialog,
          onPressed: () =>
              ref.read(_isExpandedProvider.notifier).update((state) => !state),
          child: ListTileSkeleton(
            leading: const Icon(FluentIcons.earth_20_regular),
            title: const StatefulText(
              "Manage browsers",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            subtitle: const StatefulText(
              "Select which installed browsers should be monitored to block websites.",
              fontSize: 14,
              isActive: false,
            ),
            trailing: AnimatedRotation(
              duration: 250.ms,
              turns: isBrowserListExpanded ? 0.5 : 0,
              child: const Icon(FluentIcons.chevron_down_20_filled),
            ),
          ),
        ).toSliverBox(),

        4.vSliverBox(),

        SliverAnimatedPaintExtent(
          duration: 500.ms,
          child: isBrowserListExpanded
              ? const DistractingAppsList()
              : const SizedBox().toSliverBox(),
        ),

        /// Distracting websites header
        const SliverFlexiblePinnedHeader(
          minHeight: 32,
          maxHeight: 48,
          alignment: Alignment.centerLeft,
          child: Text("Distracting websites"),
        ),

        4.vSliverBox(),

        /// Distracting websites list
        blockedSites.isNotEmpty
            ? SliverFixedExtentList.builder(
                itemExtent: 40,
                itemCount: blockedSites.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListTileSkeleton(
                    leading: const RoundedContainer(width: 8, height: 8),
                    title: StatefulText(
                      blockedSites[index],
                      fontSize: 14,
                      activeColor: Theme.of(context).hintColor,
                    ),
                    trailing: IconButton(
                      iconSize: 16,
                      icon: const Icon(FluentIcons.dismiss_16_regular),
                      onPressed: () => ref
                          .read(protectionProvider.notifier)
                          .removeSiteFromBlockedList(blockedSites[index]),
                    ),
                  ),
                ),
              )
            : SliverFillRemaining(
                // hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  alignment: const Alignment(0, -0.5),
                  child: const StatefulText(
                    "Click on '+' icon to add distracting website which you wish to block.",
                    isActive: false,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ],
    );
  }
}

// class _SelectBrowser extends ConsumerWidget {
//   const _SelectBrowser();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedBrowsers = ref.watch(protectionProvider.select((value) => value.))

//     return AppsSelectionList(
//       selectedApps: selectedApps,
//       onSelect: onSelect,
//       onDeselect: onDeselect,
//     );
//   }
// }
