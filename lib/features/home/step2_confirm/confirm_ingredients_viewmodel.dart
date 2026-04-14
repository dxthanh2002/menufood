import 'package:ai_menu_flutter/models/recipe.dart';
import 'package:ai_menu_flutter/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';

import '../../../utils/console.dart';

class ConfirmIngredientsViewModel extends ChangeNotifier {
  List<String>? _detectedIngredients;
  List<String>? get detectedIngredients => _detectedIngredients;
  bool _loadingIngredient = false;
  bool get loadingIngredient => _loadingIngredient;

  ConfirmIngredientsViewModel(String imagePath) {
    loadIngredient(imagePath);
  }

  Future<void> loadIngredient(String imagePath) async {
    if (_loadingIngredient) {
      return;
    }
    _loadingIngredient = true;
    notifyListeners();

    final analyzeResult = await RecipeRepository.analyzeImage(
      imagePath: imagePath,
    );

    _detectedIngredients = analyzeResult.data?.rawIngredients ?? [];

    await Future.delayed(Duration(milliseconds: 400));
    _loadingIngredient = false;
    notifyListeners();
  }

  bool _isSearchingLoading = false;
  bool get isSearchingLoading => _isSearchingLoading;
  Future<List<SearchRecipeItem>?> searchRecipeWithIngredients() async {
    if (_isSearchingLoading) return null;
    _isSearchingLoading = true;
    notifyListeners();

    try {
      final searchResponse = await RecipeRepository.searchRecipe(
        cookingPreferences: selectedPreferences.toList(),
        mealTime: selectedMealType,
        cuisine: selectedCuisine,
        ingredients: detectedIngredients ?? [],
      );

      await Future.delayed(Duration(milliseconds: 400));
      _isSearchingLoading = false;
      notifyListeners();

      if (searchResponse.error == true) {
        Console.error("WTF searching");
        return null;
      }

      return searchResponse.data?.items;
    } catch (e) {
      _isSearchingLoading = false;
      notifyListeners();
      Console.error("Search error: $e");
      return null;
    }
  }

  // List<String> detectedIngredients = ['Tomato', 'Egg', 'Onion', 'Beef'];
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
    detectedIngredients?.remove(ingredient);
    notifyListeners();
  }

  bool addIngredient(String ingredient) {
    final normalizedIngredient = ingredient.trim();
    if (normalizedIngredient.isNotEmpty &&
        !detectedIngredients!.any(
          (existingIngredient) =>
              existingIngredient.toLowerCase() ==
              normalizedIngredient.toLowerCase(),
        )) {
      detectedIngredients!.add(normalizedIngredient);
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
