import 'package:flutter/material.dart';

class ConfirmIngredientsViewModel extends ChangeNotifier {
  List<String> detectedIngredients = ['Tomato', 'Egg', 'Onion', 'Beef'];
  String selectedMealType = 'Breakfast';
  String selectedCuisine = 'Korean';
  List<String> selectedPreferences = ['Under 30 mins'];

  final List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert'
  ];
  final List<String> cuisines = [
    'Vietnamese',
    'Korean',
    'Japanese',
    'Western',
    'Chinese',
    'Thai'
  ];
  final List<Map<String, dynamic>> preferenceOptions = [
    {'name': 'Easy to cook', 'icon': Icons.local_fire_department_rounded},
    {'name': 'Under 30 mins', 'icon': Icons.schedule_rounded},
    {'name': 'Healthy', 'icon': Icons.favorite_rounded},
    {'name': 'Vegetarian', 'icon': Icons.eco_rounded},
  ];

  void removeIngredient(String ingredient) {
    detectedIngredients.remove(ingredient);
    notifyListeners();
  }

  void addIngredient(String ingredient) {
    if (ingredient.isNotEmpty && !detectedIngredients.contains(ingredient)) {
      detectedIngredients.add(ingredient);
      notifyListeners();
    }
  }

  void selectMealType(String mealType) {
    selectedMealType = mealType;
    notifyListeners();
  }

  void selectCuisine(String cuisine) {
    selectedCuisine = cuisine;
    notifyListeners();
  }

  void togglePreference(String preference) {
    if (selectedPreferences.contains(preference)) {
      selectedPreferences.remove(preference);
    } else {
      selectedPreferences.add(preference);
    }
    notifyListeners();
  }
  
  IconData getIngredientIcon(String name) {
    switch (name.toLowerCase()) {
      case 'tomato':
        return Icons.restaurant_rounded;
      case 'egg':
        return Icons.egg_rounded;
      case 'onion':
        return Icons.eco_rounded;
      case 'beef':
        return Icons.restaurant_menu_rounded;
      default:
        return Icons.restaurant_rounded;
    }
  }
}
