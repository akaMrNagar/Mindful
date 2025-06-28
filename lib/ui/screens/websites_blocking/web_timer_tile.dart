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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/restrictions/web_restrictions_provider.dart';
import 'package:mindful/providers/system/parental_controls_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class WebTimerTile extends ConsumerWidget {
  const WebTimerTile({
    required this.host,
    required this.webTimer,
    required this.webTimeSpent,
    super.key,
  });

  final String host;
  final int webTimer;
  final int webTimeSpent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultHero(
            tag: HeroTags.webTimerTileTag(host),
            child: DefaultListTile(
              position: ItemPosition.top,
              titleText: context.locale.app_timer_tile_title,
              subtitleText: webTimeSpent > 0
                  ? webTimeSpent.seconds.toTimeFull(context)
                  : context.locale.app_limit_status_not_set,
              leadingIcon: FluentIcons.timer_20_regular,
              accent: webTimeSpent >= webTimer
                  ? Theme.of(context).colorScheme.error
                  : null,
              trailing: TimeTextShort(timeDuration: webTimer.seconds),
              onPressed: () => _pickAppTimer(context, ref),
            ),
          );
  }

  void _pickAppTimer(
    BuildContext context,
    WidgetRef ref,
  ) async {
    /// If restricted by invincible mode
    final isInvincibleRestricted = ref.read(parentalControlsProvider
            .select((v) => v.isInvincibleModeOn && v.includeAppsTimer)) &&
        !ref.read(parentalControlsProvider.notifier).isBetweenInvincibleWindow;

    if (isInvincibleRestricted && webTimer > 0) {
      context.showSnackAlert(
        context.locale.invincible_mode_snack_alert,
      );
      return;
    }

    final newTimer = await showWebTimerPicker(
      heroTag: HeroTags.webTimerTileTag(host),
      context: context,
      initialTime: webTimer,
    );

    if (newTimer == null || newTimer == webTimer) return;
    ref
        .read(webRestrictionsProvider.notifier)
        .updateWebTimer(host, newTimer);
  }
}
