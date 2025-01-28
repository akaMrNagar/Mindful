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
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/system/mindful_settings_provider.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class GreetingsUsername extends ConsumerWidget {
  const GreetingsUsername({super.key});

  void _editUserName(
      BuildContext context, WidgetRef ref, String initialName) async {
    final userName = await showUsernameInputDialog(
      context: context,
      heroTag: HeroTags.editUsernameTag,
      initialText: initialName,
    );

    if (userName == null) return;
    ref.read(mindfulSettingsProvider.notifier).changeUsername(userName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username =
        ref.watch(mindfulSettingsProvider.select((v) => v.username));

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        StyledText(
          "👋 ${context.locale.welcome_greetings}",
          fontSize: 8,
          height: 1,
        ),

        /// User name
        DefaultHero(
          tag: HeroTags.editUsernameTag,
          child: InkWell(
            onLongPress: () => _editUserName(context, ref, username),
            onTap: () => context.showSnackAlert(
              context.locale.username_snack_alert,
              icon: FluentIcons.edit_20_filled,
            ),
            splashColor: Theme.of(context).colorScheme.surfaceContainerLow,
            child: StyledText(
              username,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
