/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
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
      title: "Active session",
      information:
          "You have an active focus session running! Click 'View' to check your progress and see how much time has elapsed.",
      actionBtnLabel: "View",
      onTapAction: () => Navigator.of(context).pushNamed(
        AppRoutes.activeSessionScreen,
        arguments: activeSession,
      ),
    );
  }
}
