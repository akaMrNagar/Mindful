import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/categorical_usage_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverCategoricalUsage extends ConsumerWidget {
  const SliverCategoricalUsage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usage = ref.watch(categoricalUsageProvider);

    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.25,
      children: [
        _UsageContainer(
          icon: FluentIcons.video_clip_multiple_20_regular,
          title: "Entertainment",
          screenUsage: usage.entertainmentScreenTime.seconds.toTimeShort(),
          dataUsage: usage.entertainmentDataUsage.toData(),
        ),
        _UsageContainer(
          icon: FluentIcons.production_20_regular,
          title: "Productivity",
          screenUsage: usage.productivityScreenTime.seconds.toTimeShort(),
          dataUsage: usage.productivityDataUsage.toData(),
        ),
        _UsageContainer(
          icon: FluentIcons.chat_multiple_20_regular,
          title: "Social",
          screenUsage: usage.socialScreenTime.seconds.toTimeShort(),
          dataUsage: usage.socialDataUsage.toData(),
        ),
        _UsageContainer(
          icon: FluentIcons.games_20_regular,
          title: "Game",
          screenUsage: usage.gameScreenTime.seconds.toTimeShort(),
          dataUsage: usage.gameDataUsage.toData(),
        ),
        _UsageContainer(
          icon: FluentIcons.app_recent_20_regular,
          title: "other",
          screenUsage: usage.otherScreenTime.seconds.toTimeShort(),
          dataUsage: usage.otherDataUsage.toData(),
        ),
      ],
    );
  }
}

class _UsageContainer extends StatelessWidget {
  const _UsageContainer({
    required this.icon,
    required this.title,
    required this.screenUsage,
    required this.dataUsage,
  });

  final IconData icon;
  final String title;
  final String screenUsage;
  final String dataUsage;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      applyBorder: true,
      circularRadius: 24,
      padding: const EdgeInsets.all(24),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          StyledText(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const Row(children: []),
          4.vBox(),
          StyledText(
            "Data: $dataUsage",
            fontSize: 14,
            isSubtitle: true,
          ),
          StyledText(
            "Screen: $screenUsage",
            fontSize: 14,
            isSubtitle: true,
          ),
        ],
      ),
    );
  }
}
