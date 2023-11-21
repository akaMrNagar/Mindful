import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/models/scaffold_tab_item.dart';
import 'package:mindful/ui/widgets/default_scaffold.dart';
import 'package:mindful/ui/screens/home/dashboard/tab_dashboard.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(isHome: true, tabs: [
      const ScaffoldTabItem(
        title: "Dashboard",
        icon: FluentIcons.data_pie_24_filled,
        body: TabDashboard(),
      ),
      ScaffoldTabItem(
        title: "Quick Focus",
        icon: FluentIcons.target_arrow_20_filled,
        body: Container(color: Colors.green),
      ),
      ScaffoldTabItem(
        title: "Profiles",
        icon: FluentIcons.person_20_filled,
        body: Container(color: Colors.blue),
      ),
      ScaffoldTabItem(
        title: "Block sites",
        icon: FluentIcons.globe_20_filled,
        body: Container(color: Colors.cyan),
      ),
    ]);
  }
}
