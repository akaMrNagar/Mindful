import 'package:flutter/material.dart';
import 'package:mindful/models/scaffold_tab_item.dart';
import 'package:mindful/models/vert_nav_bar_item.dart';
import 'package:mindful/ui/widgets/vert_nav_bar.dart';

class DefaultScaffold extends StatefulWidget {
  const DefaultScaffold({
    super.key,
    required this.tabs,
    this.isHome = false,
  });

  final List<ScaffoldTabItem> tabs;
  final bool isHome;

  @override
  State<DefaultScaffold> createState() => _DefaultScaffoldState();
}

class _DefaultScaffoldState extends State<DefaultScaffold>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(
        length: widget.tabs.length,
        vsync: this,
        animationDuration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        scrolledUnderElevation: 0,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Row(
        children: [
          /// Nav Bar
          SizedBox(
            width: 60,
            child: VertNavBar(
              isHome: widget.isHome,
              onPressed: (index) => controller.animateTo(index),
              tabItems: widget.tabs
                  .map(
                    (e) => VertNavBarItem(
                      icon: e.icon,
                      label: e.tabLabel ?? e.title,
                    ),
                  )
                  .toList(),
            ),
          ),

          /// Body
          Expanded(
            child: RotatedBox(
              quarterTurns: 1,
              child: TabBarView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: widget.tabs
                    .map(
                      (e) => RotatedBox(
                        quarterTurns: 3,
                        child: SingleChildScrollView(
                          primary: true,
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 40),

                                /// Tab Title
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    e.title,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// Tab body
                                e.body,
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
