import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/hero_page_route.dart';

class DefaultDropdownButton<T> extends StatelessWidget {
  const DefaultDropdownButton({
    super.key,
    required this.value,
    required this.items,
    required this.onSelected,
    required this.label,
    this.leadingIcon,
    this.dialogIcon,
    this.trailingBuilder,
  });

  final IconData? leadingIcon;
  final IconData? dialogIcon;

  final String label;
  final T value;
  final List<DefaultDropdownItem<T>> items;
  final ValueChanged<T> onSelected;
  final Widget Function(T? item)? trailingBuilder;

  @override
  Widget build(BuildContext context) {
    final heroTag = "DefaultDropdown.$label";
    final selected =
        items.isNotEmpty ? items.firstWhere((e) => e.value == value) : null;

    return Material(
      child: Hero(
        tag: heroTag,
        child: DefaultListTile(
          height: 64,
          leadingIcon: leadingIcon,
          titleText: label,
          subtitleText: selected?.label,
          trailing: trailingBuilder?.call(selected?.value) ??
              const Icon(FluentIcons.caret_down_20_filled),
          onPressed: () {
            Navigator.of(context).push(
              HeroPageRoute(
                builder: (context) => _DropdownMenu<T>(
                  label: label,
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
      ),
    );
  }
}

class _DropdownMenu<T> extends StatelessWidget {
  const _DropdownMenu({
    required this.heroTag,
    required this.selected,
    required this.label,
    required this.iconData,
    required this.onSelected,
    required this.items,
    required this.trailingBuilder,
  });

  final Object heroTag;
  final String label;
  final IconData? iconData;
  final DefaultDropdownItem<T>? selected;
  final Widget Function(T? item)? trailingBuilder;

  final ValueChanged<T> onSelected;
  final List<DefaultDropdownItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(48),
      alignment: Alignment.center,
      child: Hero(
        tag: heroTag,
        child: SingleChildScrollView(
          child: AlertDialog(
            icon: Icon(iconData ?? FluentIcons.info_20_regular),
            title: StyledText(label, fontSize: 16),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items
                      .map(
                        (e) => DefaultListTile(
                          leading: Radio(
                            value: e.value == selected?.value,
                            groupValue: true,
                            splashRadius: 0,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (v) {},
                          ),
                          title: StyledText(e.label, fontSize: 14),
                          trailing: trailingBuilder?.call(e.value),
                          onPressed: () {
                            onSelected(e.value);
                            Navigator.of(context).maybePop();
                          },
                        ),
                      )
                      .toList(),
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
