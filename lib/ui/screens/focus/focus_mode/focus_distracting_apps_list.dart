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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/active_session_provider.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/sliver_distracting_apps_list.dart';

class FocusDistractingAppsList extends ConsumerWidget {
  const FocusDistractingAppsList({
    super.key,
  });

  _onDistractingAppsChanged(
    BuildContext context,
    WidgetRef ref,
    String package,
    bool isSelected,
  ) async {
    // User want to remove app from list and session is active
    if (!isSelected && ref.read(activeSessionProvider).value != null) {
      context.showSnackAlert(
        "Removal of apps from the distracting apps list is not permitted while a Focus Session is active. However, you may still add additional apps to the list during this time.",
      );
      return;
    }

    // User want to add app to list
    ref
        .read(focusModeProvider.notifier)
        .insertRemoveDistractingApp(package, isSelected);

    MethodChannelService.instance.updateFocusSession(
      distractingApps: ref.read(focusModeProvider).distractingApps,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distractingApps =
        ref.watch(focusModeProvider.select((v) => v.distractingApps));

    return SliverDistractingAppsList(
      distractingApps: distractingApps,
      onSelectionChanged: (package, isSelected) => _onDistractingAppsChanged(
        context,
        ref,
        package,
        isSelected,
      ),
    );
  }
}
