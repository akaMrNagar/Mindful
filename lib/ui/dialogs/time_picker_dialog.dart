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
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';

/// Animates the hero widget to a alert dialog to pick Timer in 24H format
///
/// Returns selected [TimeOfDay] or null
Future<TimeOfDayAdapter?> showCustomTimePickerDialog({
  required BuildContext context,
  required Object heroTag,
  required TimeOfDayAdapter initialTime,
  required String info,
}) async {
  final tod = await Navigator.of(context).push<TimeOfDay>(
    HeroPageRoute(
      builder: (context) => _CustomTimePickerDialog(
        initialTime: initialTime,
        heroTag: heroTag,
        info: info,
      ),
    ),
  );

  return TimeOfDayAdapter(
    hour: tod?.hour ?? initialTime.hour,
    minute: tod?.minute ?? initialTime.minute,
  );
}

class _CustomTimePickerDialog extends StatelessWidget {
  const _CustomTimePickerDialog({
    required this.initialTime,
    required this.heroTag,
    required this.info,
  });

  final Object heroTag;
  final TimeOfDayAdapter initialTime;
  final String info;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(48),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: DefaultHero(
            tag: heroTag,
            child: RoundedContainer(
              circularRadius: 24,
              padding: EdgeInsets.zero,
              color: Theme.of(context).colorScheme.surface,
              child: SingleChildScrollView(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: TimePickerTheme(
                    data: const TimePickerThemeData(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    ),
                    child: TimePickerDialog(
                      helpText: info,
                      initialTime: initialTime,
                      initialEntryMode: TimePickerEntryMode.dialOnly,
                      cancelText: context.locale.dialog_button_cancel,
                      confirmText: context.locale.dialog_button_set,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
