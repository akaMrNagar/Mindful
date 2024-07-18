import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/screens/home/home_screen.dart';

/// This widget is responsible for forwarding the user to [AppDashboardScreen]
/// when the user clicks on the setting button of the TLE dialog.
class AppDashboardRoutingScreen extends ConsumerStatefulWidget {
  const AppDashboardRoutingScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppDashboardRoutingScreenState();
}

class _AppDashboardRoutingScreenState
    extends ConsumerState<AppDashboardRoutingScreen> {
  late ProviderSubscription<AsyncValue<Map<String, AndroidApp>>>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = ref.listenManual(appsProvider, onApps);
  }

  void onApps(
    AsyncValue<Map<String, AndroidApp>>? _,
    AsyncValue<Map<String, AndroidApp>> asyncApps,
  ) {
    asyncApps.whenData(
      (appsMap) {
        /// Remove listener
        _subscription?.close();

        /// Do the needful
        final target = MethodChannelService.instance.targetedAppPackage;
        if (target.isNotEmpty && appsMap.containsKey(target)) {
          /// Go to app dashboard
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.appDashboardScreen,
            arguments: (
              app: appsMap[target]!,
              selectedUsageType: UsageType.screenUsage,
              selectedDoW: dayOfWeek,
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.close();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
