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
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/controllers/tab_controller_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@immutable
class NavbarItem {
  final IconData icon;
  final IconData filledIcon;
  final String? titleText;
  final Widget Function(double collapsingPercentage)? titleBuilder;
  final Widget? fab;
  final Widget sliverBody;
  final Widget? appBarBg;
  final List<Widget>? actions;

  const NavbarItem({
    required this.icon,
    required this.filledIcon,
    required this.sliverBody,
    this.titleText,
    this.titleBuilder,
    this.fab,
    this.appBarBg,
    this.actions,
  }) : assert(titleText != null || titleBuilder != null,
            "Title and TitleBuilder both can't be null, Specify at least one of them");
}

/// Global Scaffold navigation bar and tab bar used throughout the app for consistent ui/ux
class ScaffoldShell extends StatefulWidget {
  const ScaffoldShell({
    super.key,
    this.initialTab,
    this.canGoBack = true,
    this.appBarExpandedHeight = 200,
    this.bodyPadding = const EdgeInsets.symmetric(horizontal: 12),
    required this.items,
  });

  final int? initialTab;
  final bool canGoBack;
  final double appBarExpandedHeight;
  final EdgeInsets bodyPadding;
  final List<NavbarItem> items;

  @override
  State<ScaffoldShell> createState() => _ScaffoldShellState();
}

class _ScaffoldShellState extends State<ScaffoldShell>
    with SingleTickerProviderStateMixin {
  final _isBottomNavVisible = ValueNotifier<bool>(true);
  final _appBarScrollOffSet = ValueNotifier<double>(0);
  late final TabController _tabController;

  late final bool _haveMultiTabs = widget.items.length > 1;
  int _selectedTabIndex = 0;
  double _wholeScreenScrollOffSet = 0;

  @override
  void initState() {
    super.initState();

    /// Resolve initial tab index
    _selectedTabIndex = (widget.initialTab ?? 0) % widget.items.length;

    /// Handle tab controller
    _tabController = TabController(
      length: widget.items.length,
      initialIndex: _selectedTabIndex,
      vsync: this,
    );

    _tabController.addListener(() {
      if (mounted) {
        setState(() {
          _selectedTabIndex = _tabController.index;
          _isBottomNavVisible.value = true;
        });
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: _haveMultiTabs ? _bottomNavBar() : null,
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: List.generate(
          widget.items.length,
          (i) => NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                /// Add app bar offset if current scroll offset is from body
                final currentOffset = notification.metrics.pixels +
                    (notification.depth == 1 ? _appBarScrollOffSet.value : 0);

                /// Show/Hide bottom bar
                if (currentOffset >= widget.appBarExpandedHeight &&
                    (currentOffset >= _wholeScreenScrollOffSet + 1)) {
                  _isBottomNavVisible.value = false;
                } else if (currentOffset <= _wholeScreenScrollOffSet - 1) {
                  _isBottomNavVisible.value = true;
                }

                /// Cache offset for whole screen
                _wholeScreenScrollOffSet = currentOffset == 0
                    ? _wholeScreenScrollOffSet
                    : currentOffset;

                /// Cache offset for just the app bar only
                if (notification.depth == 0) {
                  _appBarScrollOffSet.value = currentOffset == 0
                      ? _appBarScrollOffSet.value
                      : currentOffset;
                }
              }
              return false;
            },
            child: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (_, innerBoxIsScrolled) =>
                  [_sliverAppBar(i, innerBoxIsScrolled)],
              body: TabControllerProvider(
                controller: _tabController,
                child: Padding(
                  padding: widget.bodyPadding,
                  child: widget.items[i].sliverBody,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sliverAppBar(
    int tabIndex,
    bool innerBoxIsScrolled,
  ) {
    final navItem = widget.items[tabIndex];
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return AnimatedBuilder(
      animation: _appBarScrollOffSet,
      builder: (context, constraints) {
        // Calculate the scroll percentage
        final percentage = (_appBarScrollOffSet.value /
                (widget.appBarExpandedHeight - kToolbarHeight))
            .clamp(0.0, 1.0);

        // Interpolate the color for the AppBar
        final appBarColor = Color.lerp(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.secondaryContainer,
          percentage,
        );

        // Interpolate left padding for the AppBar's title
        final leftPadding = widget.canGoBack ? 44 * percentage : 0.0;

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
          leading: widget.canGoBack
              ? IconButton(
                  icon: Icon(
                    FluentIcons.chevron_left_24_filled,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  onPressed: () => context.popOrPushReplace(AppRoutes.homePath),
                )
              : null,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1.75,
            background: innerBoxIsScrolled ? null : navItem.appBarBg,
            collapseMode: CollapseMode.parallax,
            titlePadding: EdgeInsets.only(
              bottom: 13,
              left: isRtl ? 0 : widget.bodyPadding.left + leftPadding,
              right: isRtl ? widget.bodyPadding.right + leftPadding : 0,
            ),
            title: navItem.titleBuilder?.call(1 - percentage) ??
                AppBarTitle(titleText: navItem.titleText!),
          ),
        );
      },
    );
  }

  Widget _bottomNavBar() {
    return ValueListenableBuilder<bool>(
      valueListenable: _isBottomNavVisible,
      builder: (context, isVisible, child) => AnimatedContainer(
        height: isVisible ? (80 + MediaQuery.of(context).padding.bottom) : 0,
        duration: 300.ms,
        curve: isVisible ? Curves.easeOut : Curves.easeOut.flipped,
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(child: child),
      ),
      child: NavigationBar(
        selectedIndex: _selectedTabIndex,
        animationDuration: AppConstants.defaultAnimDuration,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        onDestinationSelected: (index) => _tabController.animateTo(
          index,
          duration: AppConstants.defaultAnimDuration,
          curve: AppConstants.defaultCurve,
        ),
        destinations: widget.items.map((e) {
          final title = e.titleText!;
          final trimmedTitle =
              title.length >= 14 ? "${title.substring(0, 9)}..." : title;

          return NavigationDestination(
            label: trimmedTitle,
            icon: Icon(e.icon),
            selectedIcon: Icon(e.filledIcon).animate().scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.05, 1.05),
                  curve: Curves.elasticOut,
                  duration: 1.seconds,
                ),
          );
        }).toList(),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.titleText,
  });

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: StyledText(
        titleText.isEmpty ? "Title" : titleText,
        fontSize: 24,
        maxLines: 2,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
