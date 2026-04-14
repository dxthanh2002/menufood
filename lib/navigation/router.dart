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
import '../models/recipe.dart';
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
        return MaterialPageRoute(
          builder: (_) => const UserSettingScreen(showBackButton: true),
        );
      case Routes.scanner:
        return MaterialPageRoute(builder: (_) => const ScannerScreen());
      case Routes.confirmIngredients:
        final imagePath = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ConfirmIngredientsScreen(imagePath: imagePath),
        );
      case Routes.step3Result:
        final recipes = settings.arguments as List<SearchRecipeItem>;
        return MaterialPageRoute(
          builder: (_) => Step3ResultScreen(recipes: recipes),
        );
      case Routes.detailRecipe:
        final recipeId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DetailRecipeScreen(recipeId: recipeId),
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
