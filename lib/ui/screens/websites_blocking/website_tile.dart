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
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/restrictions/web_restrictions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_slide_to_remove.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/config/navigation/app_routes.dart';

class WebsiteTile extends ConsumerWidget {
  const WebsiteTile({
    super.key,
    required this.websitehost,
    required this.isRemovable,
    this.position,
  });

  final String websitehost;
  final ItemPosition? position;
  final bool isRemovable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultHero(
      tag: HeroTags.websiteTileTag(websitehost),
      child: DefaultSlideToRemove(
        key: Key(websitehost),
        position: position ?? ItemPosition.none,
        removable: isRemovable,
        onDismiss: () => ref
            .read(webRestrictionsProvider.notifier)
            .removeHost(websitehost),
        child: DefaultListTile(
          position: ItemPosition.fit,
          margin: const EdgeInsets.all(0),
          onPressed: isRemovable ? () {
            Navigator.of(context).pushNamed(
              AppRoutes.webDashboardPath,
              arguments: {
                "host": websitehost,
              },
            );
          } : null,
          leading: RoundedContainer(
            width: 14,
            height: 14,
            color: isRemovable
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.error,
          ),
          titleText: websitehost,
        ),
      ),
    );
  }
}
