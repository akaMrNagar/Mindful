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
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';

class DefaultScaffold extends ConsumerStatefulWidget {
  /// Global Scaffold navigation bar or vertical tab bar used throughout the app for consistent ui/ux
  const DefaultScaffold({
    super.key,
    this.leading,
    this.onTabChanged,
    this.initialTabIndex = 0,
    required this.navbarItems,
  });

  /// Index of the initial tab must be [initialTabIndex] < [navbarItems] length.
  final int initialTabIndex;

  /// List of all tab items with title, icon and body
  final List<NavbarItem> navbarItems;

  /// If leading is null then it will automatically imply a back button
  final Widget? leading;

  /// Callback when user change tabs by clicking on tab bar buttons
  /// The callback includes the current tab index
  final ValueChanged<int>? onTabChanged;

  @override
  ConsumerState<DefaultScaffold> createState() => _DefaultScaffoldState();
}

class _DefaultScaffoldState extends ConsumerState<DefaultScaffold>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      initialIndex: widget.initialTabIndex < widget.navbarItems.length
          ? widget.initialTabIndex
          : 0,
      length: widget.navbarItems.length,
      animationDuration: 300.ms,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onTabButtonPressed(int tabIndex) {
    _controller.animateTo(
      tabIndex,
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    widget.onTabChanged?.call(tabIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final useBottomNavigation =
        ref.watch(settingsProvider.select((v) => v.bottomNavigation));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor:
            useBottomNavigation && widget.navbarItems.length >= 2
                ? Theme.of(context).colorScheme.surfaceContainer
                : Theme.of(context).colorScheme.surface,
        systemNavigationBarIconBrightness:
            Theme.of(context).colorScheme.brightness,
      ),
      child: Scaffold(
        floatingActionButton: widget.navbarItems[_controller.index].fab,

        /// Only visible when using bottom navigation and screen have more than 1 tab
        bottomNavigationBar:
            useBottomNavigation && widget.navbarItems.length >= 2
                ? NavigationBar(
                    selectedIndex: _controller.index,
                    onDestinationSelected: _onTabButtonPressed,
                    destinations: widget.navbarItems
                        .map((e) => NavigationDestination(
                              icon: Icon(e.icon),
                              selectedIcon: Icon(e.filledIcon),
                              label: e.title,
                            ))
                        .toList())
                : null,
        body: Row(
          children: [
            /// Vertical nav bar
            if (!useBottomNavigation)
              Expanded(
                flex: 1,
                child: SafeArea(
                  child: Column(
                    children: [
                      40.vBox,

                      /// Automatically imply back button if leading is null
                      widget.leading ?? _backButton(context),

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
                            onTap: () => _onTabButtonPressed(index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            /// Tab bar view with tab body
            Expanded(
              flex: 6,
              child: RotatedBox(
                quarterTurns: useBottomNavigation ? 0 : 1,
                child: TabBarView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: widget.navbarItems
                      .map(
                        (e) => RotatedBox(
                          quarterTurns: useBottomNavigation ? 0 : -1,
                          child: NestedScrollView(
                            physics: const BouncingScrollPhysics(),
                            headerSliverBuilder:
                                (context, innerBoxIsScrolled) => [
                              SliverFlexibleAppBar(
                                title: e.appBarTitle ?? e.title,
                                materialBarLeading:
                                    widget.leading ?? _backButton(context),
                              ),
                            ],
                            body: Padding(
                              padding: useBottomNavigation
                                  ? const EdgeInsets.symmetric(horizontal: 12)
                                  : const EdgeInsets.only(left: 2, right: 8),
                              child: e.sliverBody,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Navigator.of(context).canPop()
        ? IconButton(
            icon: Semantics(
              hint: "Double tab to go back",
              child: const Icon(FluentIcons.chevron_left_20_filled),
            ),
            onPressed: () => Navigator.maybePop(context),
          )
        : 0.vBox;
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
          tooltip: "Switch to $title tab",
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
  final IconData filledIcon;
  final Widget sliverBody;
  final Widget? fab;
  final String? appBarTitle;

  const NavbarItem({
    required this.icon,
    required this.filledIcon,
    required this.title,
    required this.sliverBody,
    this.fab,
    this.appBarTitle,
  });
}
