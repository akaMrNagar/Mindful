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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/enums/shorts_platform_features.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/restrictions/wellbeing_provider.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';

class SliverShortsQuickActions extends ConsumerWidget {
  const SliverShortsQuickActions({
    super.key,
    required this.haveNecessaryPerms,
    required this.isModifiable,
  });

  final bool haveNecessaryPerms;
  final bool isModifiable;

  void _toggleFeature(
    BuildContext context,
    WidgetRef ref,
    List<ShortsPlatformFeatures> blockedFeatures,
    ShortsPlatformFeatures feature,
  ) {
    /// If restricted by invincible mode
    if (!isModifiable && blockedFeatures.contains(feature)) {
      context.showSnackAlert(context.locale.invincible_mode_snack_alert);
      return;
    }

    ref.read(wellBeingProvider.notifier).insertRemoveBlockedFeature(feature);
  }

  Widget _buildIcon(BuildContext context, String path) => Opacity(
        opacity: haveNecessaryPerms ? 1 : 0.5,
        child: SvgPicture.asset(
          path,
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color ?? Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockedFeatures =
        ref.watch(wellBeingProvider.select((v) => v.blockedFeatures));

    return SliverList.list(
      children: [
        /// Block instagram features
        DefaultExpandableListTile(
          position: ItemPosition.top,
          leading: _buildIcon(context, "assets/vectors/instagram.svg"),
          enabled: haveNecessaryPerms,
          titleText: context.locale.instagram_features_tile_title,
          subtitleText: context.locale.instagram_features_tile_subtitle,
          content: Column(
            children: [
              /// Reels
              DefaultListTile(
                position: ItemPosition.mid,
                titleText: context.locale.instagram_features_block_reels,
                switchValue: blockedFeatures
                    .contains(ShortsPlatformFeatures.instagramReels),
                onPressed: () => _toggleFeature(
                  context,
                  ref,
                  blockedFeatures,
                  ShortsPlatformFeatures.instagramReels,
                ),
              ),

              /// Explore
              DefaultListTile(
                position: ItemPosition.mid,
                titleText: context.locale.instagram_features_block_explore,
                switchValue: blockedFeatures
                    .contains(ShortsPlatformFeatures.instagramExplore),
                onPressed: () => _toggleFeature(
                  context,
                  ref,
                  blockedFeatures,
                  ShortsPlatformFeatures.instagramExplore,
                ),
              ),
            ],
          ),
        ),

        /// Block snapchat features
        DefaultExpandableListTile(
          position: ItemPosition.mid,
          leading: _buildIcon(context, "assets/vectors/snapchat.svg"),
          enabled: haveNecessaryPerms,
          titleText: context.locale.snapchat_features_tile_title,
          subtitleText: context.locale.snapchat_features_tile_subtitle,
          content: Column(
            children: [
              /// Spotlight
              DefaultListTile(
                position: ItemPosition.mid,
                titleText: context.locale.snapchat_features_block_spotlight,
                switchValue: blockedFeatures
                    .contains(ShortsPlatformFeatures.snapchatSpotlight),
                onPressed: () => _toggleFeature(
                  context,
                  ref,
                  blockedFeatures,
                  ShortsPlatformFeatures.snapchatSpotlight,
                ),
              ),

              /// Discover
              DefaultListTile(
                position: ItemPosition.mid,
                titleText: context.locale.snapchat_features_block_discover,
                switchValue: blockedFeatures
                    .contains(ShortsPlatformFeatures.snapchatDiscover),
                onPressed: () => _toggleFeature(
                  context,
                  ref,
                  blockedFeatures,
                  ShortsPlatformFeatures.snapchatDiscover,
                ),
              )
            ],
          ),
        ),

        /// Block youtube shorts
        DefaultListTile(
          position: ItemPosition.mid,
          leading: _buildIcon(context, "assets/vectors/youtube.svg"),
          enabled: haveNecessaryPerms,
          titleText: context.locale.youtube_features_tile_title,
          subtitleText: context.locale.youtube_features_tile_subtitle,
          switchValue:
              blockedFeatures.contains(ShortsPlatformFeatures.youtubeShorts),
          onPressed: () => _toggleFeature(
            context,
            ref,
            blockedFeatures,
            ShortsPlatformFeatures.youtubeShorts,
          ),
        ),

        /// Block facebook reels
        DefaultListTile(
          position: ItemPosition.mid,
          leading: _buildIcon(context, "assets/vectors/facebook.svg"),
          enabled: haveNecessaryPerms,
          titleText: context.locale.facebook_features_tile_title,
          subtitleText: context.locale.facebook_features_tile_subtitle,
          switchValue:
              blockedFeatures.contains(ShortsPlatformFeatures.facebookReels),
          onPressed: () => _toggleFeature(
            context,
            ref,
            blockedFeatures,
            ShortsPlatformFeatures.facebookReels,
          ),
        ),

        /// Block reddit shorts
        DefaultListTile(
          position: ItemPosition.bottom,
          leading: _buildIcon(context, "assets/vectors/reddit.svg"),
          enabled: haveNecessaryPerms,
          titleText: context.locale.reddit_features_tile_title,
          subtitleText: context.locale.reddit_features_tile_subtitle,
          switchValue:
              blockedFeatures.contains(ShortsPlatformFeatures.redditShorts),
          onPressed: () => _toggleFeature(
            context,
            ref,
            blockedFeatures,
            ShortsPlatformFeatures.redditShorts,
          ),
        ),
      ],
    );
  }
}
