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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/restrictions/web_restrictions_provider.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
import 'package:mindful/ui/common/default_fab_button.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';

class AddWebsitesFAB extends ConsumerWidget {
  const AddWebsitesFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final haveAccessibilityPermission = ref.watch(
      permissionProvider.select((value) => value.haveAccessibilityPermission),
    );

    return haveAccessibilityPermission
        ? DefaultFabButton(
            heroTag: HeroTags.addDistractingSiteFABTag,
            label: context.locale.add_website_fab_button,
            icon: FluentIcons.link_add_20_regular,
            onPressed: () => _onPressedFab(context, ref),
          )
        : const SizedBox.shrink();
  }

  void _onPressedFab(BuildContext context, WidgetRef ref) async {
    bool isNsfw = false;

    final url = await showWebsiteInputDialog(
      context: context,
      heroTag: HeroTags.addDistractingSiteFABTag,
      moreContent: StatefulBuilder(
        builder: (context, setState) {
          return DefaultListTile(
            isSelected: isNsfw,
            color: Colors.transparent,
            titleText: context.locale.add_website_dialog_is_nsfw,
            onPressed: () => setState(() => isNsfw = !isNsfw),
          );
        },
      ),
    );

    if (url == null) return;

    final host =
        await MethodChannelService.instance.parseHostFromUrl(url.toLowerCase());

    if (host.isNotEmpty && host.contains('.') && !host.contains(' ')) {
      /// Check if url is already blocked
      if (context.mounted && ref.read(webRestrictionsProvider).keys.contains(host)) {
        context.showSnackAlert(
          context.locale.add_website_already_exist_snack_alert,
        );
        return;
      }

      ref.read(webRestrictionsProvider.notifier).addWebsite(host, isNsfw);
    } else if (context.mounted) {
      context.showSnackAlert(
        context.locale.add_website_invalid_url_snack_alert,
      );
    }
  }
}
