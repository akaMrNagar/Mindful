import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class WebsiteTile extends ConsumerWidget {
  const WebsiteTile({required this.websitehost, super.key});

  final String websitehost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultListTile(
      height: 50,
      leading: const RoundedContainer(width: 12, height: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      titleText: websitehost,
      trailing: DefaultHero(
        tag: HeroTags.websiteTileTag(websitehost),
        child: IconButton(
          iconSize: 18,
          icon: const Icon(FluentIcons.delete_dismiss_20_regular),
          onPressed: () async {
            final confirm = await showConfirmationDialog(
              context: context,
              heroTag: HeroTags.websiteTileTag(websitehost),
              icon: FluentIcons.delete_dismiss_20_filled,
              positiveLabel: "Remove",
              title: "Remove website",
              info:
                  "Are you sure? you want to remove \"$websitehost\" from blocked websites.",
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
