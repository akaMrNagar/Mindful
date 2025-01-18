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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class DefaultFabButton extends StatelessWidget {
  const DefaultFabButton({
    super.key,
    this.heroTag,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final Object? heroTag;
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return DefaultHero(
      tag: heroTag ?? "defaultScaffoldFabButton",
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        label: StyledText(
          label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        style: const ButtonStyle().copyWith(
          padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
          overlayColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.primary.withOpacity(0.25),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.primaryContainer,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
    ).animate().scale(
          duration: AppConstants.defaultAnimDuration,
          curve: AppConstants.defaultCurve,
        );
  }
}
