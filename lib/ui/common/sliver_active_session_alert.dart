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
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class SliverActiveSessionAlert extends ConsumerWidget {
  const SliverActiveSessionAlert({
    super.key,
    this.margin = const EdgeInsets.only(bottom: 8),
  });
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSession =
        ref.watch(focusModeProvider.select((v) => v.activeSession));

    return SliverPrimaryActionContainer(
      isVisible: activeSession != null,
      margin: margin,
      icon: FluentIcons.timer_20_regular,
      title: context.locale.active_session_card_title,
      information: context.locale.active_session_card_info,
      positiveBtn: FilledButton(
        child: Text(context.locale.active_session_card_view_button),
        onPressed: () => Navigator.of(context).pushNamed(
          AppRoutes.activeSessionScreen,
          arguments: activeSession,
        ),
      ),
    );
  }
}
