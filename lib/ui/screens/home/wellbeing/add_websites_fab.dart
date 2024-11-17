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
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';

class AddWebsitesFAB extends ConsumerWidget {
  const AddWebsitesFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final haveAccessibilityPermission = ref.watch(
      permissionProvider.select((value) => value.haveAccessibilityPermission),
    );

    return haveAccessibilityPermission
        ? FloatingActionButton.extended(
            heroTag: HeroTags.addDistractingSiteFABTag,
            label: Text(context.locale.add_website_fab_button),
            icon: const Icon(FluentIcons.link_add_20_regular),
            onPressed: () => _onPressedFab(context, ref),
          )
        : const SizedBox.shrink();
  }

  void _onPressedFab(BuildContext context, WidgetRef ref) async {
    final url = await showWebsiteInputDialog(
      context: context,
      heroTag: HeroTags.addDistractingSiteFABTag,
    );

    if (url == null || url.isEmpty) return;

    final host =
        await MethodChannelService.instance.parseHostFromUrl(url.toLowerCase());

    if (host.isNotEmpty && host.contains('.') && !host.contains(' ')) {
      /// Check if url is already blocked
      if (context.mounted &&
          ref.read(wellBeingProvider).blockedWebsites.contains(host)) {
        context.showSnackAlert(
          context.locale.add_website_already_exist_snack_alert,
        );
        return;
      }

      /// Add to blocked sites list
      ref.read(wellBeingProvider.notifier).insertRemoveBlockedSite(host, true);
    } else if (context.mounted) {
      context.showSnackAlert(
        context.locale.add_website_invalid_url_snack_alert,
      );
    }
  }
}
