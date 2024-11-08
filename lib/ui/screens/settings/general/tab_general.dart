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
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/locales.dart';
import 'package:mindful/providers/mindful_settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabGeneral extends ConsumerWidget {
  const TabGeneral({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mindfulSettings = ref.watch(mindfulSettingsProvider);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appearance
        ContentSectionHeader(
          title: context.locale.appearance_heading,
        ).sliver,

        /// Theme mode
        DefaultDropdownTile<AppThemeMode>(
          position: ItemPosition.start,
          value: mindfulSettings.themeMode,
          dialogIcon: FluentIcons.dark_theme_20_filled,
          titleText: context.locale.theme_mode_tile_title,
          onSelected:
              ref.read(mindfulSettingsProvider.notifier).changeThemeMode,
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
          position: ItemPosition.mid,
          titleText: context.locale.material_color_tile_title,
          dialogIcon: FluentIcons.color_20_filled,
          value: mindfulSettings.accentColor,
          onSelected: ref.read(mindfulSettingsProvider.notifier).changeColor,
          trailingBuilder: (item) => RoundedContainer(
            height: 18,
            width: 18,
            circularRadius: 18,
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

        /// Amoled dark
        DefaultListTile(
          position: ItemPosition.mid,
          switchValue: mindfulSettings.useAmoledDark,
          titleText: context.locale.amoled_dark_tile_title,
          subtitleText: context.locale.amoled_dark_tile_subtitle,
          onPressed:
              ref.read(mindfulSettingsProvider.notifier).switchAmoledDark,
        ).sliver,

        /// Amoled dark
        DefaultListTile(
          position: ItemPosition.end,
          switchValue: mindfulSettings.useDynamicColors,
          titleText: "Dynamic colors",
          subtitleText: "Use device colors if supported.",
          onPressed:
              ref.read(mindfulSettingsProvider.notifier).switchDynamicColor,
        ).sliver,

        /// Default settings
        12.vSliverBox,
        ContentSectionHeader(title: context.locale.defaults_heading).sliver,

        /// App Language
        DefaultDropdownTile<String>(
          position: ItemPosition.start,
          titleText: context.locale.app_language_tile_title,
          dialogIcon: FluentIcons.color_20_filled,
          value: mindfulSettings.localeCode,
          onSelected: ref.read(mindfulSettingsProvider.notifier).changeLocale,
          items: AppLocalizations.supportedLocales
              .map((e) => DefaultDropdownItem(
                    value: e.languageCode,
                    label:
                        Locales.knownLocales[e.languageCode] ?? e.languageCode,
                  ))
              .toList(),
        ).sliver,

        /// Default home tab
        DefaultDropdownTile<DefaultHomeTab>(
          position: ItemPosition.mid,
          titleText: "Home tab",
          dialogIcon: FluentIcons.color_20_filled,
          value: DefaultHomeTab.dashboard,
          onSelected: (_) {},
          items: [
            DefaultDropdownItem(
              label: context.locale.dashboard_tab_title,
              value: DefaultHomeTab.dashboard,
            ),
            DefaultDropdownItem(
              label: context.locale.statistics_tab_title,
              value: DefaultHomeTab.statistics,
            ),
            DefaultDropdownItem(
              label: context.locale.wellbeing_tab_title,
              value: DefaultHomeTab.wellbeing,
            ),
            DefaultDropdownItem(
              label: context.locale.bedtime_tab_title,
              value: DefaultHomeTab.bedtime,
            ),
          ],
        ).sliver,

        /// Bottom navigation
        DefaultListTile(
          position: ItemPosition.mid,
          switchValue: mindfulSettings.useBottomNavigation,
          titleText: context.locale.bottom_navigation_tile_title,
          subtitleText: context.locale.bottom_navigation_tile_subtitle,
          onPressed:
              ref.read(mindfulSettingsProvider.notifier).switchBottomNavigation,
        ).sliver,

        /// Data reset time
        DefaultListTile(
          position: ItemPosition.end,
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
                  .read(mindfulSettingsProvider.notifier)
                  .changeDataResetTime(pickedTime);
            }
          },
        ).sliver,
      ],
    );
  }
}
