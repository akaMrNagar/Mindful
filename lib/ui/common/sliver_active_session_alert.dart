import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/providers/active_session_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class SliverActiveSessionAlert extends ConsumerWidget {
  const SliverActiveSessionAlert({
    super.key,
    this.margin = const EdgeInsets.only(bottom: 8),
  });
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSession = ref.watch(activeSessionProvider).value;
    return SliverPrimaryActionContainer(
      isVisible: activeSession != null,
      margin: margin,
      title: "Active session",
      information:
          "You have an active focus session running! Click 'View' to check your progress and see how much time has elapsed.",
      actionBtnLabel: "View",
      onTapAction: activeSession == null
          ? null
          : () => Navigator.of(context).pushNamed(
                AppRoutes.activeSessionScreen,
                arguments: activeSession,
              ),
    );
  }
}
