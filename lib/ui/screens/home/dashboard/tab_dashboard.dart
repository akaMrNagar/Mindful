import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/aggregated_usage_provider.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/permissions/display_overlay_permission.dart';
import 'package:mindful/ui/permissions/usage_access_permission.dart';
import 'package:mindful/ui/screens/home/dashboard/primary_usage_card.dart';
import 'package:mindful/ui/screens/home/dashboard/sliver_categorical_usage.dart';

class TabDashboard extends ConsumerWidget {
  const TabDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aggregatedUsage = ref.watch(aggregatedUsageProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Appbar
              const SliverFlexibleAppBar(title: "Dashboard"),

              const UsageAccessPermission(),

              const DisplayOverlayPermission(),

              const SliverContentTitle(title: "Today's usage"),
              8.vSliverBox(),

              /// Screen time
              PrimaryUsageCard(
                icon: FluentIcons.phone_screen_time_20_regular,
                title: "Screen time",
                info: aggregatedUsage.screenTimeThisWeek[dayOfWeek].seconds
                    .toTimeFull(),
              ).toSliverBox(),

              /// Data usage mobile + wifi
              Row(
                children: [
                  Expanded(
                    child: PrimaryUsageCard(
                      icon: FluentIcons.cellular_data_1_20_regular,
                      title: "Mobile data",
                      info: aggregatedUsage.mobileUsageThisWeek[dayOfWeek]
                          .toData(),
                    ),
                  ),
                  8.hBox(),
                  Expanded(
                    child: PrimaryUsageCard(
                      icon: FluentIcons.wifi_1_20_regular,
                      title: "Wifi data",
                      info:
                          aggregatedUsage.wifiUsageThisWeek[dayOfWeek].toData(),
                    ),
                  ),
                ],
              ).toSliverBox(),

              /// Category wise usage
              const SliverContentTitle(title: "Categorical usage"),
              8.vSliverBox(),

              /// Category wise usage
              const SliverCategoricalUsage(),

              180.vSliverBox(),
            ],
          ),

          /// Emergency pause button
          if (MethodChannelService.instance.targetedAppPackage.isNotEmpty)
            Positioned(
              bottom: 32,
              right: 24,
              child: FloatingActionButton.extended(
                heroTag: 'emergencyFAB',
                label: const Text("Emergency"),
                icon: const Icon(FluentIcons.rocket_20_regular),
                onPressed: () => _useEmergency(context, ref),
              ),
            )
        ],
      ),
    );
  }

  void _useEmergency(BuildContext context, WidgetRef ref) async {
    int leftPasses =
        await MethodChannelService.instance.getLeftEmergencyPasses();

    if (!context.mounted) return;

    if (leftPasses <= 0) {
      context.showSnackWarning(
        "You have used all your emergency passes. The blocked apps cannot be unblocked until midnight.",
      );
      return;
    }

    final confirmed = await showConfirmationDialog(
      context: context,
      icon: FluentIcons.rocket_20_regular,
      heroTag: "emergencyFAB",
      title: "Emergency",
      info:
          "This will pause the app blocker for 5 minutes. You have $leftPasses emergency passes remaining. After using all passes, the app cannot be unblocked until midnight. Do you still want to proceed?",
      positiveLabel: "Use anyway",
    );

    if (confirmed) await MethodChannelService.instance.useEmergencyPass();
  }
}
