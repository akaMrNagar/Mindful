import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/models/scaffold_tab_item.dart';
import 'package:mindful/ui/screens/app_dashboard/app_settings.dart';
import 'package:mindful/ui/widgets/application_icon.dart';
import 'package:mindful/ui/widgets/base_bar_chart.dart';
import 'package:mindful/ui/widgets/custom_text.dart';
import 'package:mindful/ui/widgets/default_scaffold.dart';
import 'package:mindful/ui/widgets/segmented_icon_buttons.dart';
import 'package:mindful/ui/widgets/usage_info_cards.dart';
import 'package:mindful/ui/widgets/widgets_revealer.dart';

final _selectedDayOfWeekProvider = StateProvider<int>((ref) => dayOfWeek);
final _filterByScreenProvider = StateProvider<bool>((ref) => true);

class AppDashboard extends ConsumerWidget {
  const AppDashboard({
    super.key,
    required this.app,
  });

  final AndroidApp app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultScaffold(
      tabs: [
        ScaffoldTabItem(
          title: app.name,
          tabLabel: "Dashboard",
          icon: FluentIcons.data_pie_20_filled,
          body: WidgetsRevealer(
            children: [
              const SizedBox(height: 40),

              Consumer(
                builder: (_, WidgetRef ref, __) {
                  final selectedDayBar = ref.watch(_selectedDayOfWeekProvider);
                  final filterByScreen = ref.watch(_filterByScreenProvider);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        /// App Icon
                        ApplicationIcon(app: app, size: 32),
                        const SizedBox(height: 12),

                        /// Selected Date
                        Center(
                          child: SubtitleText(
                            selectedDayBar.toDateDiffToday(),
                            size: 14,
                          ),
                        ),
                        SubtitleText(app.packageName),
                        const SizedBox(height: 24),

                        SegmentedIconButton(
                          selected: filterByScreen ? 0 : 1,
                          segments: const [
                            FluentIcons.phone_screen_time_20_regular,
                            FluentIcons.earth_20_regular,
                          ],
                          onChange: (value) => ref
                              .read(_filterByScreenProvider.notifier)
                              .update((state) => value == 0),
                        ),
                        const SizedBox(height: 48),

                        /// Usage charts [screen + data]
                        SizedBox(
                          height: 208,
                          child: BaseBarChart(
                            isTimeChart: filterByScreen,
                            selectedBar: selectedDayBar,
                            intervalBuilder: (max) => max * 0.275,
                            onBarTap: (barIndex) => ref
                                .read(_selectedDayOfWeekProvider.notifier)
                                .update((state) => barIndex),
                            data: filterByScreen
                                ? app.screenTimeThisWeek
                                : app.networkUsageThisWeek,
                          ),
                        ),
                        const SizedBox(height: 12),

                        filterByScreen
                            ? UsageInfoCard(
                                label: "Screen time",
                                info: app
                                    .screenTimeThisWeek[selectedDayBar].seconds
                                    .toTimeFull(),
                                iconData:
                                    FluentIcons.phone_screen_time_20_regular,
                              )
                            : DataUsageInfoCard(
                                mobile: app.mobileUsageThisWeek[selectedDayBar],
                                wifi: app.wifiUsageThisWeek[selectedDayBar],
                              ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              /// Available app setting or functions
              if (app.packageName != Constants.removedAppPackage &&
                  app.packageName != Constants.tetheringAppPackage)
                AppSettings(app: app),

              const SizedBox(height: 50),
            ],
          ),
        )
      ],
    );
  }
}
