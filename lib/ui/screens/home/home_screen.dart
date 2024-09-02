/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

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
import 'package:mindful/providers/restriction_infos_provider.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/screens/home/bedtime/tab_bedtime.dart';
import 'package:mindful/ui/screens/home/dashboard/tab_dashboard.dart';
import 'package:mindful/ui/screens/home/statistics/tab_statistics.dart';
import 'package:mindful/ui/screens/home/wellbeing/add_websites_fab.dart';
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

    /// Initialize the provider to start the necessary services
    ref.read(restrictionInfosProvider);

    final targetPackage = MethodChannelService.instance.targetedAppPackage;
    if (targetPackage.isEmpty) return;

    /// Check if target package in method channel service is not empty,
    /// that means user launched the app from overlay dialog
    _subscription = ref.listenManual<AsyncValue<Map<String, AndroidApp>>>(
      appsProvider,
      (_, apps) {
        if (!apps.hasValue) return;
        if (apps.value!.containsKey(targetPackage)) {
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
    return DefaultScaffold(
      leading: IconButton(
        icon: Semantics(
          hint: "Double tab to open app settings",
          child: const Icon(FluentIcons.settings_20_regular),
        ),
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRoutes.settingsScreen),
      ),
      navbarItems: const [
        NavbarItem(
          title: "Dashboard",
          icon: FluentIcons.home_20_filled,
          body: TabDashboard(),
        ),
        NavbarItem(
          title: "Statistics",
          icon: FluentIcons.data_pie_24_filled,
          body: TabStatistics(),
        ),
        NavbarItem(
          title: "Wellbeing",
          icon: FluentIcons.brain_circuit_20_filled,
          body: TabWellBeing(),
          fab: AddWebsitesFAB(),
        ),
        NavbarItem(
          title: "Bedtime",
          icon: FluentIcons.sleep_20_filled,
          body: TabBedtime(),
        ),
      ],
    );
  }
}
