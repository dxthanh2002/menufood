import 'package:flutter/material.dart';

class ConfirmIngredientsViewModel extends ChangeNotifier {
  List<String> detectedIngredients = ['Tomato', 'Egg', 'Onion', 'Beef'];
  String selectedMealType = 'Breakfast';
  String selectedCuisine = 'Korean';
  final Set<String> selectedPreferences = {'Under 30 mins'};
  final List<String> quickAddIngredients = [
    'Salt',
    'Pepper',
    'Garlic',
    'Olive Oil',
    'Lemon',
  ];

  final List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert',
  ];
  final List<String> cuisines = [
    'Vietnamese',
    'Korean',
    'Japanese',
    'Western',
    'Chinese',
    'Thai',
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

  bool addIngredient(String ingredient) {
    final normalizedIngredient = ingredient.trim();
    if (normalizedIngredient.isNotEmpty &&
        !detectedIngredients.any(
          (existingIngredient) =>
              existingIngredient.toLowerCase() ==
              normalizedIngredient.toLowerCase(),
        )) {
      detectedIngredients.add(normalizedIngredient);
      notifyListeners();
      return true;
    }

    return false;
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
    final wasAdded = selectedPreferences.add(preference);
    if (!wasAdded) {
      selectedPreferences.remove(preference);
    }
    notifyListeners();
  }

}
