import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/protection_provider.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BlockWebsitesPage extends ConsumerWidget {
  const BlockWebsitesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockedSites =
        ref.watch(protectionProvider.select((v) => v.blockedWebsites));

    final blockNsfw =
        ref.watch(protectionProvider.select((v) => v.blockNsfwSites));

    final isWebsitesBlockerOn =
        ref.watch(protectionProvider.select((v) => v.websitesBlocker));

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
                subTitleText: "Switch blocker On/Off",
                value: isWebsitesBlockerOn,
                onPressed: () => ref
                    .read(protectionProvider.notifier)
                    .toggleWebsitesBlocker(!isWebsitesBlockerOn),
              ),
            ],
          ),
        ),

        4.vSliverBox(),

        /// Nsfw switch
        SwitchableListTile(
          leadingIcon: FluentIcons.globe_video_20_regular,
          titleText: "Block Nsfw sites",
          subTitleText: "Block adult and porn websites",
          value: blockNsfw,
          onPressed: () =>
              ref.read(protectionProvider.notifier).toggleBlockNsfw(!blockNsfw),
        ),

        4.vSliverBox(),

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
                          .insetRemoveBlockedSite(blockedSites[index], false),
                    ),
                  ),
                ),
              )
            : SliverFillRemaining(
                hasScrollBody: false,
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

        if (blockedSites.isNotEmpty) 72.vSliverBox(),
      ],
    );
  }
}
