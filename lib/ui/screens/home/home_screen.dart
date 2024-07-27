import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/screens/home/bedtime/tab_bedtime.dart';
import 'package:mindful/ui/screens/home/dashboard/tab_dashboard.dart';
import 'package:mindful/ui/screens/home/wellbeing/tab_wellbeing.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ProviderSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    /// Check if target package in method channel service is not empty,
    /// that means user launched the app from overlay dialog
    _subscription = ref.listenManual<AsyncValue<Map<String, AndroidApp>>>(
      appsProvider,
      (_, apps) {
        if (!apps.hasValue) return;
        final targetPackage = MethodChannelService.instance.targetedAppPackage;
        if (targetPackage.isNotEmpty &&
            apps.value!.containsKey(targetPackage)) {
          _gotoAppDashboard(apps.value![targetPackage]!);
        }

        _subscription?.close();
      },
    );
  }

  /// Go to app dashboard screen after 300ms of loading
  void _gotoAppDashboard(AndroidApp app) async {
    await Future.delayed(300.ms);
    if (mounted) {
      Navigator.of(context).pushNamed(
        AppRoutes.appDashboardScreen,
        arguments: (
          app: app,
          selectedUsageType: UsageType.screenUsage,
          selectedDoW: todayOfWeek,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultNavbar(
        leading: IconButton(
          icon: const Icon(FluentIcons.settings_20_regular),
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoutes.settingsScreen),
        ),
        navbarItems: const [
          NavbarItem(
            title: "Dashboard",
            icon: FluentIcons.data_pie_24_filled,
            body: TabDashboard(),
          ),
          NavbarItem(
            title: "Bedtime",
            icon: FluentIcons.sleep_20_filled,
            body: TabBedtime(),
          ),
          NavbarItem(
            title: "Wellbeing",
            icon: FluentIcons.brain_circuit_20_filled,
            body: TabWellBeing(),
          ),
        ],
      ),
    );
  }
}
