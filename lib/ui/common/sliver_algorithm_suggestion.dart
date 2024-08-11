import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/aggregated_usage_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class SliverAlgorithmSuggestion extends ConsumerStatefulWidget {
  const SliverAlgorithmSuggestion({super.key});

  @override
  ConsumerState<SliverAlgorithmSuggestion> createState() =>
      _SliverAlgorithmSuggestionState();
}

class _SliverAlgorithmSuggestionState
    extends ConsumerState<SliverAlgorithmSuggestion> {
  bool _isClosedByUser = false;

  @override
  Widget build(BuildContext context) {
    const oneDayInSec = 24 * 60 * 60;
    final screenUsage =
        ref.watch(aggregatedUsageProvider.select((v) => v.screenTimeThisWeek));

    final timeExceeded24H =
        screenUsage.where((e) => e >= oneDayInSec).isNotEmpty;

    return SliverPrimaryActionContainer(
      isVisible: timeExceeded24H && !_isClosedByUser,
      margin: const EdgeInsets.only(bottom: 8),
      actionBtnLabel: "Dismiss",
      title: "Suggestion",
      information:
          "If the screen time does not accurately reflect your usage, try changing the usage calculation algorithm from the settings.",
      onTapAction: () => setState(() => _isClosedByUser = true),
    );
  }
}
