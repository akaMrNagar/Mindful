import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/selected_day_provider.dart';
import 'package:mindful/widgets/_common/application_icon.dart';
import 'package:mindful/widgets/_common/custom_app_bar.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/widgets_revealer.dart';
import 'package:mindful/widgets/app_stats_screen/app_settings.dart';
import 'package:mindful/widgets/app_stats_screen/app_stats_charts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Screen which displays all the app usage statistics including screen time,
/// mobile usage, wifi usage, charts. Also available app settings.
class AppStatsScreen extends StatelessWidget {
  const AppStatsScreen({
    super.key,
    required this.app,
    required this.chartIndex,
  });

  final AndroidApp app;
  final int chartIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(),
              WidgetsRevealer(
                children: [
                  ApplicationIcon(app: app, size: 32),
                  const SizedBox(height: 8),
                  Center(
                    child: TitleText(app.name),
                  ),
                  const SizedBox(height: 2),
                  Center(
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return SubtitleText(
                          ref.watch(selectedDayProvider).toDateDiffToday(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  _ChartsPageView(app: app, chartIndex: chartIndex),

                  /// Settngs
                  const SizedBox(height: 16),

                  if (app.packageName != Constants.removedAppPackage &&
                      app.packageName != Constants.tetheringAppPackage)
                    AppSettings(app: app),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartsPageView extends ConsumerStatefulWidget {
  const _ChartsPageView({
    required this.app,
    required this.chartIndex,
  });

  final AndroidApp app;
  final int chartIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __ChartsPageViewState();
}

class __ChartsPageViewState extends ConsumerState<_ChartsPageView> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: widget.chartIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final day = ref.watch(selectedDayProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 342,
          child: PageView(
            controller: controller,
            children: [
              AppScreenTimeChart(
                app: widget.app,
                day: day,
              ),
              AppDataUsageChart(
                app: widget.app,
                day: day,
              ),
            ],
          ),
        ),
        SmoothPageIndicator(
          count: 2,
          controller: controller,
          effect: ExpandingDotsEffect(
            dotColor: Colors.grey.shade700,
            activeDotColor: Colors.pink,
            expansionFactor: 4,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }
}
