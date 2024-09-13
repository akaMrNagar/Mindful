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

    final canModifyInsta =
        haveNecessaryPerms && (isModifiable || !blockInstaReels);

    final canModifyYt = haveNecessaryPerms && (isModifiable || !blockYtShorts);

    final canModifySnap =
        haveNecessaryPerms && (isModifiable || !blockSnapSpotlight);

    final canModifyFb = haveNecessaryPerms && (isModifiable || !blockFbReels);

    return SliverList.list(
      children: [
        /// Block instagram reels
        DefaultListTile(
          leading: Opacity(
            opacity: canModifyInsta ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/instaReels.png",
              width: 32,
            ),
          ),
          enabled: canModifyInsta,
          titleText: "Block reels",
          subtitleText: "Restrict reels on instagram.",
          switchValue: blockInstaReels,
          onPressed: ref.read(wellBeingProvider.notifier).switchBlockInstaReels,
        ),

        /// Block youtube shorts
        DefaultListTile(
          leading: Opacity(
            opacity: canModifyYt ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/ytShorts.png",
              width: 32,
            ),
          ),
          enabled: canModifyYt,
          titleText: "Block shorts",
          subtitleText: "Restrict shorts on youtube.",
          switchValue: blockYtShorts,
          onPressed: ref.read(wellBeingProvider.notifier).switchBlockYtShorts,
        ),

        /// Block snapchat spotlight
        DefaultListTile(
          leading: Opacity(
            opacity: canModifySnap ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/snapSpotlight.png",
              width: 32,
            ),
          ),
          enabled: canModifySnap,
          titleText: "Block spotlight",
          subtitleText: "Restrict spotlight on snapchat.",
          switchValue: blockSnapSpotlight,
          onPressed:
              ref.read(wellBeingProvider.notifier).switchBlockSnapSpotlight,
        ),

        /// Block facebook reels
        DefaultListTile(
          leading: Opacity(
            opacity: canModifyFb ? 1 : 0.5,
            child: Image.asset(
              "assets/icons/fbReels.png",
              width: 32,
            ),
          ),
          enabled: canModifyFb,
          titleText: "Block reels",
          subtitleText: "Restrict reels on facebook.",
          switchValue: blockFbReels,
          onPressed: ref.read(wellBeingProvider.notifier).switchBlockFbReels,
        ),
      ],
    );
  }
}
