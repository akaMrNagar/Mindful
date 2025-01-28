/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/providers/focus/lifetime_focus_provider.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';

class FocusLifetimeGlance extends ConsumerWidget {
  const FocusLifetimeGlance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifeTimeFocus =
        ref.watch(lifetimeFocusProvider.select((v) => v.value)) ??
            Duration.zero;

    return UsageGlanceCard(
      title: context.locale.focus_lifetime_label,
      info: lifeTimeFocus.toTimeShort(context),
    );
  }
}
