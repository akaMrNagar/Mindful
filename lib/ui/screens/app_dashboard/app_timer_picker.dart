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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/restriction_infos_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class AppTimerPicker extends ConsumerWidget {
  const AppTimerPicker({
    required this.app,
    this.isIconButton = false,
    super.key,
  });

  final AndroidApp app;
  final bool isIconButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTimer = ref.watch(restrictionInfosProvider
            .select((value) => value[app.packageName]?.timerSec)) ??
        0;

    final isPurged =
        appTimer > 0 && appTimer < app.screenTimeThisWeek[todayOfWeek];

    return isIconButton
        ? IconButton(
            icon: Semantics(
              hint: "Set timer for ${app.name}",
              child: appTimer > 0
                  ? TimeTextShort(timeDuration: appTimer.seconds)
                  : const Icon(FluentIcons.timer_20_regular),
            ),
            onPressed: () => _pickAppTimer(
              context,
              ref,
              appTimer,
            ),
          )
        : DefaultHero(
            tag: HeroTags.appTimerTileTag(app.packageName),
            child: DefaultListTile(
              titleText: "App timer",
              enabled: !app.isImpSysApp,
              subtitleText: app.isImpSysApp
                  ? "Timer not available for important apps"
                  : appTimer > 0
                      ? appTimer.seconds.toTimeFull()
                      : "No timer",
              leadingIcon: FluentIcons.timer_20_regular,
              accent: isPurged ? Theme.of(context).colorScheme.error : null,
              trailing: isPurged ? const Text("Paused") : null,
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
    final isInvincibleModeOn = ref.read(
      settingsProvider.select((v) => v.isInvincibleModeOn),
    );

    if (isInvincibleModeOn &&
        prevTimer > 0 &&
        app.screenTimeThisWeek[todayOfWeek] >= prevTimer) {
      context.showSnackAlert(
        "Due to invincible mode, modifications to paused app's timer is not allowed.",
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
        .read(restrictionInfosProvider.notifier)
        .updateAppTimer(app.packageName, newTimer);
  }
}
