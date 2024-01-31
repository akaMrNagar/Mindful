import 'package:mindful/ui/screens/external_routing_screen.dart';
import 'package:mindful/ui/screens/home/home.dart';

class AppRoutes {
  static const String homeScreen = '/';
  static const String externalScreen = '/external';

  static final mindfulRoutes = {
    homeScreen: (context) => const Home(),
    externalScreen: (context) => const ExternalRoutingScreen(),
  };
}
