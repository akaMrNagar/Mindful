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
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';
import 'package:mindful/ui/common/styled_text.dart';

/// Animates the hero widget to a alert dialog for the confirmation with the provided configurations
///
/// Returns a boolean indicating the user's intention TRUE if confirm otherwise FALSE
Future<bool> showConfirmationDialog({
  required BuildContext context,
  required Object heroTag,
  required String title,
  required String info,
  required IconData icon,
  required String positiveLabel,
  String negativeLabel = "Cancel",
}) async {
  return await Navigator.of(context).push<bool>(
        HeroPageRoute(
          builder: (context) => _ConfirmationDialog(
            heroTag: heroTag,
            title: title,
            info: info,
            icon: icon,
            positiveLabel: positiveLabel,
            negativeLabel: negativeLabel,
          ),
        ),
      ) ??
      false;
}

class _ConfirmationDialog extends StatelessWidget {
  const _ConfirmationDialog({
    required this.heroTag,
    required this.title,
    required this.info,
    required this.icon,
    required this.positiveLabel,
    required this.negativeLabel,
  });

  final Object heroTag;
  final String title;
  final String info;
  final IconData icon;
  final String positiveLabel;
  final String negativeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(48),
      alignment: Alignment.center,
      child: DefaultHero(
        tag: heroTag,
        child: SingleChildScrollView(
          child: AlertDialog(
            icon: Icon(icon),
            title: StyledText(title, fontSize: 16),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StyledText(info),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.maybePop(context, false),
                child: Text(negativeLabel),
              ),
              FilledButton.tonal(
                onPressed: () => Navigator.maybePop(context, true),
                child: Text(positiveLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
