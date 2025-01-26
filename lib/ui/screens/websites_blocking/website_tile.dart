/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/restrictions/wellbeing_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class WebsiteTile extends ConsumerWidget {
  const WebsiteTile({
    super.key,
    required this.websitehost,
    this.position,
  });

  final String websitehost;
  final ItemPosition? position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultHero(
      tag: HeroTags.websiteTileTag(websitehost),
      child: DefaultListTile(
        position: position,
        color: Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.5),
        leading: RoundedContainer(
          width: 14,
          height: 14,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.75),
        ),
        titleText: websitehost,
        trailing: IconButton(
          iconSize: 18,
          icon: const Icon(FluentIcons.delete_dismiss_20_regular),
          onPressed: () async {
            final confirm = await showConfirmationDialog(
              context: context,
              heroTag: HeroTags.websiteTileTag(websitehost),
              icon: FluentIcons.delete_dismiss_20_filled,
              positiveLabel: context.locale.dialog_button_remove,
              title: context.locale.remove_website_dialog_title,
              info: context.locale.remove_website_dialog_info(websitehost),
            );

            if (confirm) {
              ref
                  .read(wellBeingProvider.notifier)
                  .insertRemoveBlockedSite(websitehost, false);
            }
          },
        ),
      ),
    );
  }
}
