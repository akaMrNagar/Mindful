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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/tab_controller_provider.dart';

@immutable
class NavbarItem {
  final IconData icon;
  final IconData filledIcon;
  final String titleText;
  final Widget? title;
  final Widget? fab;
  final Widget sliverBody;
  final Widget? appBarBg;
  final List<Widget>? actions;

  const NavbarItem({
    required this.titleText,
    required this.icon,
    required this.filledIcon,
    required this.sliverBody,
    this.title,
    this.fab,
    this.appBarBg,
    this.actions,
  });
}

class ScaffoldShell extends StatefulWidget {
  const ScaffoldShell({
    super.key,
    this.initialTab = 0,
    this.appBarExpandedHeight = 200,
    this.bodyPadding = const EdgeInsets.symmetric(horizontal: 12),
    required this.items,
  });

  final int initialTab;
  final double appBarExpandedHeight;
  final EdgeInsets bodyPadding;
  final List<NavbarItem> items;

  @override
  State<ScaffoldShell> createState() => _ScaffoldShellState();
}

class _ScaffoldShellState extends State<ScaffoldShell>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  late final bool _haveMultiTabs = widget.items.length > 1;
  late int _selectedTabIndex = widget.initialTab;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.items.length,
      initialIndex: widget.initialTab,
      vsync: this,
    );

    _tabController.addListener(() {
      if (mounted) {
        setState(() => _selectedTabIndex = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          widget.items[_selectedTabIndex].fab ?? const SizedBox.shrink(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: _haveMultiTabs ? bottomNavBar() : null,
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.items.map(
          (e) {
            final scrollController = ScrollController();
            return NestedScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                sliverAppBar(
                  scrollController,
                  innerBoxIsScrolled,
                ),
              ],

              /// Provides access to the tab controller to the children in tree
              /// To get =>  TabControllerProvider.of(context)?.controller;
              body: TabControllerProvider(
                controller: _tabController,
                child: Padding(
                  padding: widget.bodyPadding,
                  child: e.sliverBody,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget sliverAppBar(
    ScrollController scrollController,
    bool innerBoxIsScrolled,
  ) {
    final canGoBack = Navigator.of(context).canPop();
    final navItem = widget.items[_selectedTabIndex];

    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, constraints) {
        // Calculate the scroll percentage
        final offset = scrollController.hasClients
            ? scrollController.offset.clamp(0.0, widget.appBarExpandedHeight)
            : 0.0;

        final percentage =
            (offset / (widget.appBarExpandedHeight - kToolbarHeight))
                .clamp(0.0, 1.0);

        // Interpolate the color for the AppBar
        final appBarColor = Color.lerp(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.secondaryContainer,
          percentage,
        );

        // Interpolate left padding for the AppBar's title
        final leftPadding = canGoBack ? 44 * percentage : 0.0;

        return SliverAppBar(
          expandedHeight: widget.appBarExpandedHeight,
          collapsedHeight: kToolbarHeight,
          pinned: !_haveMultiTabs,
          stretch: true,
          primary: true,
          backgroundColor: _haveMultiTabs
              ? Theme.of(context).colorScheme.surface
              : appBarColor,
          surfaceTintColor:
              _haveMultiTabs ? Theme.of(context).colorScheme.surfaceTint : null,
          automaticallyImplyLeading: false,
          actions: [
            ...navItem.actions ?? [],
            widget.bodyPadding.right.hBox,
          ],
          leading: canGoBack
              ? IconButton(
                  icon: Icon(
                    FluentIcons.chevron_left_24_filled,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                )
              : null,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1.75,
            background: innerBoxIsScrolled ? null : navItem.appBarBg,
            titlePadding: EdgeInsets.only(
              bottom: 13,
              left: widget.bodyPadding.left + leftPadding,
            ),
            title: navItem.title ??
                StyledText(
                  navItem.titleText,
                  fontSize: 24,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
          ),
        );
      },
    );
  }

  Widget bottomNavBar() {
    return NavigationBar(
      selectedIndex: _selectedTabIndex,
      animationDuration: AppConstants.defaultAnimDuration,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      onDestinationSelected: (index) => _tabController.animateTo(
        index,
        duration: AppConstants.defaultAnimDuration,
        curve: AppConstants.defaultCurve,
      ),
      destinations: widget.items
          .map(
            (e) => NavigationDestination(
              label: e.titleText,
              icon: Icon(e.icon).animate(target: 0),
              selectedIcon: Icon(e.filledIcon).animate().scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1.05, 1.05),
                    curve: Curves.elasticOut,
                    duration: 1.seconds,
                  ),
            ),
          )
          .toList(),
    );
  }
}
