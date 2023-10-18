import 'package:mindful/screens/device_network_stats_screen.dart';
import 'package:mindful/screens/device_time_stats_screen.dart';
import 'package:mindful/screens/external_routing_screen.dart';
import 'package:mindful/screens/focus_profiles_screen.dart';
import 'package:mindful/screens/home_screen.dart';

class AppRoutes {
  static const String homeScreen = '/';
  static const String externalScreen = '/external';
  static const String deviceTimeScreen = '/deviceTime';
  static const String deviceDataScreen = '/deviceData';
  static const String appStatsScreen = '/appStats';
  static const String focusProfilesScreen = '/focusProfiles';

  static final mindfulRoutes = {
    homeScreen: (context) => const HomeScreen(),
    externalScreen: (context) => const ExternalRoutingScreen(),
    deviceTimeScreen: (context) => const DeviceTimeStatsScreen(),
    deviceDataScreen: (context) => const DeviceNetworkStatsScreen(),
    focusProfilesScreen: (context) => const FocusProfilesScreen(),
  };
}
