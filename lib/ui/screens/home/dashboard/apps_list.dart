import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/sorted_apps_provider.dart';
import 'package:mindful/ui/screens/home/dashboard/application_tile.dart';
import 'package:mindful/ui/widgets/async_error_indicator.dart';
import 'package:mindful/ui/widgets/async_loading_indicator.dart';
import 'package:mindful/ui/widgets/custom_text.dart';
import 'package:mindful/ui/widgets/interactive_card.dart';

class AppsList extends ConsumerStatefulWidget {
  const AppsList({
    required this.selectedDay,
    required this.sortByTime,
    super.key,
  });

  final int selectedDay;
  final bool sortByTime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppsListState();
}

class _AppsListState extends ConsumerState<AppsList> {
  /// Only animating top 10 tiles as the below tiles are not visible while changing days
  final animateMaxChild = 10;
  bool _showAllApps = false;

  // ignore: prefer_final_fields
  Map<String, int> _prevIndices = {};

  @override
  Widget build(BuildContext context) {
    final sortedApps = ref.watch(sortedAppsProvider(_showAllApps));

    return Column(
      children: [
        sortedApps.when(
          loading: () => const AsyncLoadingIndicator(),
          error: (e, st) => AsyncErrorIndicator(e, st),
          data: (packages) {
            /// Update indices of tiles based on packages
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                for (var i = 0; i < packages.length; i++) {
                  _prevIndices.update(
                    packages[i],
                    (value) => i,
                    ifAbsent: () => i,
                  );
                }
              },
            );

            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemExtent: 72,
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final app = ref.read(appsProvider).value?[packages[index]];
                final yOffset = _prevIndices.containsKey(packages[index])
                    ? _prevIndices[packages[index]]! - index
                    : 0;

                return app == null
                    ? const SizedBox()
                    : Animate(
                        key: Key(app.packageName),
                        effects: index < animateMaxChild
                            ? [
                                FadeEffect(
                                  duration: 250.ms,
                                  begin: 0.4,
                                  end: 1,
                                  curve: Curves.ease,
                                ),
                                MoveEffect(
                                  duration: 250.ms,
                                  curve: Curves.easeOut,
                                  begin: Offset(0, yOffset * 72),
                                  end: const Offset(0, 0),
                                ),
                              ]
                            : [],
                        child: ApplicationTile(
                          app: app,
                          isDataTile: !widget.sortByTime,
                          day: widget.selectedDay,
                        ),
                      );
              },
            );
          },
        ),
        if (!_showAllApps && sortedApps.hasValue)
          InteractiveCard(
            margin: const EdgeInsets.symmetric(vertical: 16),
            onPressed: () => setState(() => _showAllApps = true),
            child: const TitleText("Show all apps"),
          ),
      ],
    );
  }
}
