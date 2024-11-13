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
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/invincible_mode_provider.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class AppTimer extends ConsumerWidget {
  const AppTimer({
    required this.app,
    this.isIconButton = false,
    super.key,
  });

  final AndroidApp app;
  final bool isIconButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTimer = ref.watch(appsRestrictionsProvider
            .select((v) => v[app.packageName]?.timerSec)) ??
        0;

    final isPurged =
        appTimer > 0 && appTimer < app.screenTimeThisWeek[todayOfWeek];

    return isIconButton
        ? IconButton(
            icon: appTimer > 0
                ? TimeTextShort(timeDuration: appTimer.seconds)
                : const Icon(FluentIcons.timer_20_regular),
            onPressed: () => _pickAppTimer(
              context,
              ref,
              appTimer,
            ),
          )
        : DefaultHero(
            tag: HeroTags.appTimerTileTag(app.packageName),
            child: DefaultListTile(
              position: ItemPosition.start,
              titleText: context.locale.app_timer_tile_title,
              enabled: !app.isImpSysApp,
              subtitleText: appTimer > 0
                  ? appTimer.seconds.toTimeFull(context)
                  : context.locale.app_limit_status_not_set,
              leadingIcon: FluentIcons.timer_20_regular,
              accent: isPurged ? Theme.of(context).colorScheme.error : null,
              trailing:
                  isPurged ? Text(context.locale.timer_status_paused) : null,
              onPressed: () => _pickAppTimer(
                context,
                ref,
                appTimer,
              ),
            ),
          );
  }

  void _pickAppTimer(
    BuildContext context,
    WidgetRef ref,
    int prevTimer,
  ) async {
    final isInvincibleModeRestricted = ref.read(
      invincibleModeProvider
          .select((v) => v.isInvincibleModeOn && v.includeAppsTimer),
    );

    if (isInvincibleModeRestricted &&
        prevTimer > 0 &&
        app.screenTimeThisWeek[todayOfWeek] >= prevTimer) {
      context.showSnackAlert(
        context.locale.invincible_mode_snack_alert,
      );
      return;
    }

    final newTimer = await showAppTimerPicker(
      app: app,
      heroTag: isIconButton
          ? HeroTags.applicationTileTag(app.packageName)
          : HeroTags.appTimerTileTag(app.packageName),
      context: context,
      initialTime: prevTimer,
    );

    if (newTimer == prevTimer) return;
    ref
        .read(appsRestrictionsProvider.notifier)
        .updateAppTimer(app.packageName, newTimer);
  }
}
