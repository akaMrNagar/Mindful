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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';

class DefaultDropdownTile<T> extends StatelessWidget {
  /// Custom dropdown list tile when clicked displays alert dialog with list items
  const DefaultDropdownTile({
    super.key,
    required this.value,
    required this.items,
    required this.onSelected,
    required this.titleText,
    this.enabled = true,
    this.infoText,
    this.width,
    this.position,
    this.leadingIcon,
    this.dialogIcon,
    this.trailingBuilder,
  });

  final IconData? leadingIcon;
  final IconData? dialogIcon;
  final bool enabled;

  final String titleText;
  final String? infoText;
  final double? width;
  final ItemPosition? position;
  final T value;
  final List<DefaultDropdownItem<T>> items;
  final ValueChanged<T> onSelected;
  final Widget Function(T? item)? trailingBuilder;

  @override
  Widget build(BuildContext context) {
    final heroTag = "DefaultDropdown.$titleText";
    final selected =
        items.isNotEmpty ? items.firstWhere((e) => e.value == value) : null;

    return DefaultHero(
      tag: heroTag,
      child: DefaultListTile(
        position: position,
        enabled: enabled,
        leadingIcon: leadingIcon,
        titleText: titleText,
        subtitleText: selected?.label,
        trailing: trailingBuilder?.call(selected?.value) ??
            Icon(
              FluentIcons.caret_down_20_filled,
              color: enabled ? null : Theme.of(context).disabledColor,
            ),
        onPressed: () {
          Navigator.of(context).push(
            HeroPageRoute(
              builder: (context) => _DropdownMenuDialog<T>(
                label: titleText,
                info: infoText,
                heroTag: heroTag,
                iconData: dialogIcon,
                selected: selected,
                onSelected: onSelected,
                trailingBuilder: trailingBuilder,
                items: items,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DropdownMenuDialog<T> extends StatelessWidget {
  const _DropdownMenuDialog({
    required this.heroTag,
    required this.selected,
    required this.label,
    required this.info,
    required this.iconData,
    required this.onSelected,
    required this.items,
    required this.trailingBuilder,
  });

  final Object heroTag;
  final String label;
  final String? info;
  final IconData? iconData;
  final DefaultDropdownItem<T>? selected;
  final Widget Function(T? item)? trailingBuilder;

  final ValueChanged<T> onSelected;
  final List<DefaultDropdownItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(48),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: DefaultHero(
            tag: heroTag,
            child: AlertDialog(
              scrollable: true,
              icon: Icon(iconData ?? FluentIcons.info_20_regular),
              title: StyledText(label, fontSize: 16),
              insetPadding: EdgeInsets.zero,
              contentPadding: const EdgeInsets.all(12),
              actionsPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: Text(context.locale.dialog_button_cancel),
                ),
              ],
              content: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Info
                      if (info != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: StyledText(
                            info!,
                          ),
                        ),

                      /// Options
                      ...List.generate(
                        items.length,
                        (index) => DefaultListTile(
                          color:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          position: getItemPositionInList(index, items.length),
                          leading: IgnorePointer(
                            child: Radio(
                              value: items[index].value == selected?.value,
                              groupValue: true,
                              splashRadius: 0,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (v) {},
                            ),
                          ),
                          title: StyledText(items[index].label, fontSize: 14),
                          trailing: trailingBuilder?.call(items[index].value),
                          onPressed: () {
                            Navigator.of(context).maybePop();
                            onSelected(items[index].value);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultDropdownItem<T> {
  final String label;
  final T value;

  DefaultDropdownItem({
    required this.label,
    required this.value,
  });
}
