import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/onboard_screen/onboard_screen.dart';
import '../features/user_setting/user_setting_screen.dart';
import '../features/bottom_navigation/main_screen.dart';
import '../features/home/step1_scaner/scanner_screen.dart';
import '../features/home/step2_confirm/confirm_ingredients_screen.dart';
import '../features/home/step3_result/step3_result_screen.dart';
import '../features/home/step3_result/step3_result_viewmodel.dart';
import '../features/detail_recipes/detail_recipe_screen.dart';
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
      case Routes.scanner:
        return MaterialPageRoute(builder: (_) => const ScannerScreen());
      case Routes.confirmIngredients:
        final imagePath = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => ConfirmIngredientsScreen(imagePath: imagePath),
        );
      case Routes.step3Result:
        return MaterialPageRoute(builder: (_) => const Step3ResultScreen());
      case Routes.detailRecipe:
        final recipe = settings.arguments as Step3ResultRecipe;
        return MaterialPageRoute(
          builder: (_) => DetailRecipeScreen(recipe: recipe),
        );
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
