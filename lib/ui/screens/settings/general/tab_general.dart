/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_themes.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/locales.dart';
import 'package:mindful/providers/new/mindful_settings_notifier.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabGeneral extends ConsumerWidget {
  const TabGeneral({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mindfulSettings = ref.watch(mindfulSettingsNotifierProvider);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appearance
        SliverContentTitle(title: context.locale.appearance_heading),

        /// Amoled dark
        DefaultListTile(
          switchValue: mindfulSettings.useAmoledDark,
          titleText: context.locale.amoled_dark_tile_title,
          subtitleText: context.locale.amoled_dark_tile_subtitle,
          onPressed: ref
              .read(mindfulSettingsNotifierProvider.notifier)
              .switchAmoledDark,
        ).sliver,

        /// Theme mode
        DefaultDropdownTile<AppThemeMode>(
          value: mindfulSettings.themeMode,
          dialogIcon: FluentIcons.dark_theme_20_filled,
          label: context.locale.theme_mode_tile_title,
          // onSelected: ref.read(settingsProvider.notifier).changeThemeMode,
          onSelected: ref
              .read(mindfulSettingsNotifierProvider.notifier)
              .changeThemeMode,
          items: [
            DefaultDropdownItem(
              label: context.locale.theme_mode_system_label,
              value: AppThemeMode.system,
            ),
            DefaultDropdownItem(
              label: context.locale.theme_mode_light_label,
              value: AppThemeMode.light,
            ),
            DefaultDropdownItem(
              label: context.locale.theme_mode_dark_label,
              value: AppThemeMode.dark,
            ),
          ],
        ).sliver,

        /// Material Color
        DefaultDropdownTile<String>(
          label: context.locale.material_color_tile_title,
          dialogIcon: FluentIcons.color_20_filled,
          value: mindfulSettings.accentColor,
          onSelected:
              ref.read(mindfulSettingsNotifierProvider.notifier).changeColor,
          trailingBuilder: (item) => RoundedContainer(
            height: 18,
            width: 18,
            circularRadius: 15,
            color: AppTheme.materialColors[item],
          ),
          items: AppTheme.materialColors.entries
              .map((e) => DefaultDropdownItem(
                    // using key for both label and value as we are storing color name in database
                    label: e.key,
                    value: e.key,
                  ))
              .toList(),
        ).sliver,

        /// Default settings
        12.vSliverBox,
        SliverContentTitle(title: context.locale.defaults_heading),

        /// App Language
        DefaultDropdownTile<String>(
          label: context.locale.app_language_tile_title,
          dialogIcon: FluentIcons.color_20_filled,
          value: mindfulSettings.localeCode,
          onSelected:
              ref.read(mindfulSettingsNotifierProvider.notifier).changeLocale,
          items: AppLocalizations.supportedLocales
              .map((e) => DefaultDropdownItem(
                    value: e.languageCode,
                    label:
                        Locales.knownLocales[e.languageCode] ?? e.languageCode,
                  ))
              .toList(),
        ).sliver,

        /// Bottom navigation
        DefaultListTile(
          switchValue: mindfulSettings.useBottomNavigation,
          titleText: context.locale.bottom_navigation_tile_title,
          subtitleText: context.locale.bottom_navigation_tile_subtitle,
          onPressed: ref
              .read(mindfulSettingsNotifierProvider.notifier)
              .switchBottomNavigation,
        ).sliver,

        /// Data reset time
        DefaultListTile(
          titleText: context.locale.data_reset_time_tile_title,
          subtitleText: context.locale.data_reset_time_tile_subtitle,
          trailing: StyledText(
            mindfulSettings.dataResetTimeMins.toTimeOfDay.format(context),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () async {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: mindfulSettings.dataResetTimeMins.toTimeOfDay,
              helpText: context.locale.data_reset_time_dialog_hint,
            );

            if (pickedTime != null && context.mounted) {
              ref
                  .read(mindfulSettingsNotifierProvider.notifier)
                  .changeDataResetTime(pickedTime);
            }
          },
        ).sliver,
      ],
    );
  }
}
