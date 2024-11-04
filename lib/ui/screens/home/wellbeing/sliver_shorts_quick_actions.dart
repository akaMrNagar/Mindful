/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';

class SliverShortsQuickActions extends ConsumerWidget {
  const SliverShortsQuickActions({
    super.key,
    required this.haveNecessaryPerms,
    required this.isModifiable,
  });

  final bool haveNecessaryPerms;
  final bool isModifiable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockInstaReels =
        ref.watch(wellBeingProvider.select((v) => v.blockInstaReels));

    final blockYtShorts =
        ref.watch(wellBeingProvider.select((v) => v.blockYtShorts));

    final blockSnapSpotlight =
        ref.watch(wellBeingProvider.select((v) => v.blockSnapSpotlight));

    final blockFbReels =
        ref.watch(wellBeingProvider.select((v) => v.blockFbReels));

    final blockRedditShorts =
        ref.watch(wellBeingProvider.select((v) => v.blockRedditShorts));

    final canModifyInsta =
        haveNecessaryPerms && (isModifiable || !blockInstaReels);

    final canModifyYt = haveNecessaryPerms && (isModifiable || !blockYtShorts);

    final canModifySnap =
        haveNecessaryPerms && (isModifiable || !blockSnapSpotlight);

    final canModifyFb = haveNecessaryPerms && (isModifiable || !blockFbReels);

    final canModifyReddit =
        haveNecessaryPerms && (isModifiable || !blockRedditShorts);

    return SliverList.list(
      children: [
        /// Block instagram reels
        DefaultListTile(
          position: ItemPosition.start,
          leading: Opacity(
            opacity: canModifyInsta ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/instaReels.png",
              width: 32,
            ),
          ),
          enabled: canModifyInsta,
          titleText: context.locale.block_insta_reels_title,
          subtitleText: context.locale.block_insta_reels_subtitle,
          switchValue: blockInstaReels,
          onPressed: ref.read(wellBeingProvider.notifier).switchBlockInstaReels,
        ),

        /// Block youtube shorts
        DefaultListTile(
          position: ItemPosition.mid,
          leading: Opacity(
            opacity: canModifyYt ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/ytShorts.png",
              width: 32,
            ),
          ),
          enabled: canModifyYt,
          titleText: context.locale.block_yt_shorts_title,
          subtitleText: context.locale.block_yt_shorts_subtitle,
          switchValue: blockYtShorts,
          onPressed: ref.read(wellBeingProvider.notifier).switchBlockYtShorts,
        ),

        /// Block snapchat spotlight
        DefaultListTile(
          position: ItemPosition.mid,
          leading: Opacity(
            opacity: canModifySnap ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/snapSpotlight.png",
              width: 32,
            ),
          ),
          enabled: canModifySnap,
          titleText: context.locale.block_snap_spotlight_title,
          subtitleText: context.locale.block_snap_spotlight_subtitle,
          switchValue: blockSnapSpotlight,
          onPressed:
              ref.read(wellBeingProvider.notifier).switchBlockSnapSpotlight,
        ),

        /// Block facebook reels
        DefaultListTile(
          position: ItemPosition.mid,
          leading: Opacity(
            opacity: canModifyFb ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/fbReels.png",
              width: 32,
            ),
          ),
          enabled: canModifyFb,
          titleText: context.locale.block_fb_reels_title,
          subtitleText: context.locale.block_fb_reels_subtitle,
          switchValue: blockFbReels,
          onPressed: ref.read(wellBeingProvider.notifier).switchBlockFbReels,
        ),

        /// Block reddit shorts
        DefaultListTile(
          position: ItemPosition.end,
          leading: Opacity(
            opacity: canModifyReddit ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/redditShorts.png",
              width: 32,
            ),
          ),
          enabled: canModifyReddit,
          titleText: context.locale.block_reddit_shorts_title,
          subtitleText: context.locale.block_reddit_shorts_subtitle,
          switchValue: blockRedditShorts,
          onPressed:
              ref.read(wellBeingProvider.notifier).switchBlockRedditShorts,
        ),
      ],
    );
  }
}
