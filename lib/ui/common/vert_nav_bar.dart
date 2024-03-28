import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/vert_nav_bar_item.dart';
import 'package:mindful/providers/mindful_theme_provider.dart';

class VertNavBar extends StatefulWidget {
  const   VertNavBar({
    super.key,
    required this.tabItems,
    required this.onPressed,
    required this.isHome,
  });

  final List<VertNavBarItem> tabItems;
  final bool isHome;
  final Function(int index) onPressed;

  @override
  State<VertNavBar> createState() => _VertNavBarState();
}

class _VertNavBarState extends State<VertNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        const SizedBox(height: 40),

        /// Settings button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: widget.isHome
              ? Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return IconButton(
                      onPressed: () =>
                          ref.read(mindfulThemeProvider.notifier).update(
                                (state) => state == ThemeMode.dark
                                    ? ThemeMode.light
                                    : ThemeMode.dark,
                              ),
                      icon: const Icon(FluentIcons.device_eq_20_filled),
                    );
                  },
                )

              /// Back button
              : IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(FluentIcons.chevron_left_20_filled),
                ),
        ),
        const SizedBox(height: 40),

        ///
        ...List.generate(
          widget.tabItems.length,
          (index) {
            final isSelected = index == currentIndex;
            return RotatedBox(
              quarterTurns: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: IconButton(
                  onPressed: () {
                    widget.onPressed(index);
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  style: const ButtonStyle().copyWith(
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    ),
                  ),
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedSlide(
                        offset: Offset(0, isSelected ? 0 : -3),
                        duration: const Duration(milliseconds: 250),
                        child: AnimatedOpacity(
                          opacity: isSelected ? 1 : 0,
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            widget.tabItems[index].icon,
                            size: 14,
                          ),
                        ),
                      ),
                      Text(
                        widget.tabItems[index].label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w500 : null,
                          color: isSelected
                              ? null
                              : Theme.of(context).disabledColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
