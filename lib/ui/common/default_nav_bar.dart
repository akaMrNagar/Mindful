import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:mindful/core/extensions/ext_num.dart';

class DefaultNavbar extends StatefulWidget {
  /// Global navigation bar or vertical tab bar used throughout the app for consistent ui/ux
  const DefaultNavbar({
    super.key,
    this.leading,
    this.onTabChanged,
    required this.navbarItems,
  });

  /// List of all tab items with title, icon and body
  final List<NavbarItem> navbarItems;

  /// If leading is null then it will automatically imply a back button
  final Widget? leading;

  /// Callback when user change tabs by clicking on tab bar buttons
  /// The callback includes the current tab index
  final ValueChanged<int>? onTabChanged;

  @override
  State<DefaultNavbar> createState() => _DefaultNavbarState();
}

class _DefaultNavbarState extends State<DefaultNavbar>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      initialIndex: 0,
      length: widget.navbarItems.length,
      animationDuration: 300.ms,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SafeArea(
            child: Column(
              children: [
                40.vBox,

                /// Leading widget
                widget.leading ?? const SizedBox(),

                /// Automatically imply back button if leading is null
                if (widget.leading == null && Navigator.canPop(context))
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_left_20_filled),
                    onPressed: () => Navigator.maybePop(context),
                  ),

                40.vBox,

                /// Tab buttons
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.navbarItems.length,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) => _TabBarButton(
                      title: widget.navbarItems[index].title,
                      icon: widget.navbarItems[index].icon,
                      isSelected: _controller.index == index,
                      onTap: () => setState(
                        () {
                          _controller.animateTo(
                            index,
                            curve: Curves.fastEaseInToSlowEaseOut,
                          );
                          widget.onTabChanged?.call(index);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Tab bar view with tab body
        Expanded(
          flex: 7,
          child: RotatedBox(
            quarterTurns: 1,
            child: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.navbarItems
                  .map((e) => RotatedBox(quarterTurns: -1, child: e.body))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _TabBarButton extends StatelessWidget {
  const _TabBarButton({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const animDur = Duration(milliseconds: 250);

    return RotatedBox(
      quarterTurns: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: IconButton(
          onPressed: onTap,
          style: const ButtonStyle().copyWith(
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedSlide(
                offset: Offset(0, isSelected ? 0 : -3),
                duration: animDur,
                child: AnimatedOpacity(
                  opacity: isSelected ? 1 : 0,
                  duration: animDur,
                  child: Icon(icon, size: 14),
                ),
              ),
              Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  height: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: isSelected ? FontWeight.bold : null,
                  color: isSelected ? null : Theme.of(context).disabledColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
class NavbarItem {
  final String title;
  final IconData icon;
  final Widget body;

  const NavbarItem({
    required this.icon,
    required this.title,
    required this.body,
  });
}
