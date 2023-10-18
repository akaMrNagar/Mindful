import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/mindful_theme_provider.dart';
import 'package:mindful/widgets/shared/custom_text.dart';
import 'package:mindful/widgets/shared/interactive_card.dart';

class MindfulAppBar extends StatelessWidget {
  const MindfulAppBar({
    super.key,
    this.title = "",
    this.floating = true,
    this.isHome = false,
  });

  final String title;
  final bool floating;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 64,
      floating: floating,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 12,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: TitleText(
        title,
        weight: FontWeight.w500,
        size: 18,
      ),
      actions: [isHome ? const _CustomSettingsButton() : const SizedBox()],
      leading: !isHome
          ? IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(FluentIcons.chevron_left_20_regular),
            )
          : null,
    );
  }
}

class _CustomSettingsButton extends ConsumerWidget {
  const _CustomSettingsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InteractiveCard(
        height: 48,
        width: 48,
        padding: const EdgeInsets.all(0),
        child: const Icon(FluentIcons.settings_20_regular),
        onPressed: () {
          int current = ref.read(mindfulThemeProvider).index;
          current++;
          current %= 2;

          ref.read(mindfulThemeProvider.notifier).update(
                (state) => ThemeMode.values[current],
              );
          // ref.read(appsProvider.notifier).refreshDeviceApps();
        },
      ),
    );
  }
}
