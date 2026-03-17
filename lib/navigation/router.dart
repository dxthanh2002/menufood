import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/onboard_screen/onboard_screen.dart';
import '../features/user_setting/user_setting_screen.dart';
import '../features/bottom_navigation/main_screen.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboard:
        return MaterialPageRoute(builder: (_) => const OnboardScreen());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const UserSettingScreen());
      // case Routes.profile:
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
