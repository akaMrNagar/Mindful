import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DistractionBlockerPage extends ConsumerWidget {
  const DistractionBlockerPage({super.key});

  void _switchDistractionBlocker(WidgetRef ref, bool shouldBlock) async {
    final state = ref.read(wellbeingProvider);

    if (!shouldBlock ||
        state.blockNsfwSites ||
        state.blockShortContent ||
        state.blockedWebsites.isNotEmpty) {
      ref
          .read(wellbeingProvider.notifier)
          .switchDistractionBlocker(shouldBlock);
      return;
    }

    /// Show toast if no blocked apps
    await MethodChannelService.instance.showToast(
      "Either block nsfw or short content else add atleas one distractiong website",
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockedSites =
        ref.watch(wellbeingProvider.select((v) => v.blockedWebsites));

    final blockNsfw =
        ref.watch(wellbeingProvider.select((v) => v.blockNsfwSites));

    final blockShortContent =
        ref.watch(wellbeingProvider.select((v) => v.blockShortContent));

    final isDistractionBlockerOn =
        ref.watch(wellbeingProvider.select((v) => v.isDistractionBlockerOn));

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
                leadingIcon: FluentIcons.cursor_prohibited_20_regular,
                titleText: "Distraction blocker",
                subTitleText: "Switch blocker On/Off",
                value: isDistractionBlockerOn,
                onPressed: () =>
                    _switchDistractionBlocker(ref, !isDistractionBlockerOn),
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
          leadingIcon: FluentIcons.slide_multiple_search_20_regular,
          titleText: "Block Nsfw sites",
          subTitleText: "Block adult and porn websites",
          value: blockNsfw,
          onPressed: () =>
              ref.read(wellbeingProvider.notifier).switchBlockNsfw(!blockNsfw),
        ),

        /// Short content switch
        SwitchableListTile(
          leadingIcon: FluentIcons.video_clip_multiple_20_regular,
          titleText: "Block short content",
          subTitleText:
              "Block shorts on instgram, facebook, youtube and snapchat",
          value: blockShortContent,
          onPressed: () => ref
              .read(wellbeingProvider.notifier)
              .switchBlockShortContent(!blockShortContent),
        ),

        4.vSliverBox(),

        /// Distracting websites header
        const SliverFlexiblePinnedHeader(
          minHeight: 32,
          maxHeight: 48,
          alignment: Alignment.centerLeft,
          child: Text("Distracting websites"),
        ),

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
                          .read(wellbeingProvider.notifier)
                          .insertRemoveBlockedSite(blockedSites[index], false),
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
