import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/models/scaffold_tab_item.dart';
import 'package:mindful/ui/screens/home/bedtime/tab_bedtime.dart';
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
      const ScaffoldTabItem(
        title: "Bedtime",
        icon: FluentIcons.cloud_beaker_20_filled,
        body: TabBedtime(),
      ),
      ScaffoldTabItem(
        title: "Block sites",
        icon: FluentIcons.globe_20_filled,
        body: Container(color: Colors.cyan),
      ),
    ]);
  }
}
