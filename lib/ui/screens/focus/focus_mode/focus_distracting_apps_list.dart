import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/sliver_distracting_apps_list.dart';

class FocusDistractingAppsList extends ConsumerWidget {
  const FocusDistractingAppsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distractingApps =
        ref.watch(focusModeProvider.select((v) => v.distractingApps));

    return SliverDistractingAppsList(
      distractingApps: distractingApps,
      onSelectionChanged: (package, isSelected) => ref
          .read(focusModeProvider.notifier)
          .insertRemoveDistractingApp(package, isSelected),
    );
  }
}
