import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/mindful_theme_provider.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.showBackBtn = true,
    this.showSettingsBtn = true,
  });

  final String? title;
  final bool showBackBtn;
  final bool showSettingsBtn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (showBackBtn) const CustomBackButton(),
          if (title != null)
            Text(
              title!,
              style: const TextStyle(fontSize: 18),
            ),
          const Spacer(),
          if (showSettingsBtn) const CustomSettingsButton(),
        ],
      ),
    );
  }
}

class CustomSettingsButton extends ConsumerWidget {
  const CustomSettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InteractiveCard(
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
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveCard(
      height: 48,
      width: 48,
      elevation: 1,
      padding: const EdgeInsets.all(0),
      onPressed: () => Navigator.maybePop(context),
      child: const Icon(FluentIcons.chevron_left_20_regular),
    );
  }
}
