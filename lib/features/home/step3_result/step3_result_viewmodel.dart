import 'package:ai_menu_flutter/utils/format.dart';
import 'package:flutter/material.dart';

import '../../../models/recipe.dart';

class Step3ResultRecipe {
  const Step3ResultRecipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.difficulty,
    required this.shortDescription,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String duration;
  final String difficulty;
  final String shortDescription;
}

class Step3ResultViewModel extends ChangeNotifier {
  List<Step3ResultRecipe> _recipes = [];
  List<Step3ResultRecipe> get recipes => _recipes;

  Step3ResultViewModel(List<SearchRecipeItem> recommendedRecipe) {
    loadRecipes(recommendedRecipe);
  }

  bool _loadingRecipe = false;
  Future<void> loadRecipes(List<SearchRecipeItem> recommendedRecipes) async {
    if (_loadingRecipe) return;
    _loadingRecipe = true;
    notifyListeners();

    // Map SearchRecipeItem to Step3ResultRecipe
    _recipes = recommendedRecipes.map((item) {
      return Step3ResultRecipe(
        id: item.id!,
        title: item.name ?? 'Unknown',
        imageUrl: item.imageUrl ?? '',
        duration: formatDuration(item.cookTimeMinutes),
        difficulty: item.difficulty ?? 'Medium',
        shortDescription: item.shortDescription ?? 'Delicious',
      );
    }).toList();

    _loadingRecipe = false;
    notifyListeners();
  }
}
