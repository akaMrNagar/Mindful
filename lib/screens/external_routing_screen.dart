import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/screens/app_stats_screen.dart';
import 'package:mindful/screens/home_screen.dart';
import 'package:mindful/widgets/_common/async_error_indicator.dart';
import 'package:mindful/widgets/_common/async_loading_indicator.dart';

class ExternalRoutingScreen extends ConsumerWidget {
  const ExternalRoutingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(appsProvider).when(
          loading: () => const AsyncLoadingIndicator(),
          error: (e, st) => AsyncErrorIndicator(e, st),
          data: (apps) {
            final package = MindfulNativePlugin.instance.goToApp;
            if (package.isNotEmpty) {
              for (var app in apps) {
                if (app.packageName == package) {
                  return AppStatsScreen(app: app, chartIndex: 0);
                }
              }
            }
            return const HomeScreen();
          },
        );
  }
}
