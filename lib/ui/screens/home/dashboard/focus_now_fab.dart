import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/utils/hero_tags.dart';

class FocusNowFab extends StatelessWidget {
  const FocusNowFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: HeroTags.focusModeTimerTileTag,
      label: Text(context.locale.focus_now_fab_button),
      icon: const Icon(FluentIcons.target_arrow_20_filled),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: () =>
          Navigator.of(context).pushNamed(AppRoutes.focusScreen, arguments: 0),
    );
  }
}
