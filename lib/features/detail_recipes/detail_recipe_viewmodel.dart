import 'package:flutter/material.dart';

import '../../repositories/recipe_repository.dart';
import '../../utils/console.dart';

class RecipeDetail {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String duration;
  final String difficulty;
  final String cuisine;
  final int calories;
  final int servings;
  final List<RecipeIngredient> ingredients;
  final List<RecipeInstruction> instructions;

  RecipeDetail({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.cuisine,
    required this.calories,
    required this.servings,
    required this.ingredients,
    required this.instructions,
  });
}

class RecipeIngredient {
  final String name;
  final String note;

  RecipeIngredient({required this.name, required this.note});
}

class RecipeInstruction {
  final String step;
  final String description;

  RecipeInstruction({required this.step, required this.description});
}

class DetailRecipeViewModel extends ChangeNotifier {
  final Set<int> _checkedIngredientIndexes = <int>{};

  Set<int> get checkedIngredientIndexes => _checkedIngredientIndexes;

  bool _loadingRecipeDetail = false;
  bool get loadingRecipeDetail => _loadingRecipeDetail;

  RecipeDetail? _recipe;
  RecipeDetail? get recipe => _recipe;

  Future<void> loadRecipeDetails(String recipeId) async {
    if (_loadingRecipeDetail) return;

    _loadingRecipeDetail = true;
    notifyListeners();

    try {
      final response = await RecipeRepository.getRecipeDetails(
        recipeId: recipeId,
      );

      if (response.error == true) {
        Console.error('Failed to load recipe');
      } else {
        final detail = response.data;
        _recipe = RecipeDetail(
          id: detail?.id ?? '',
          title: detail?.name ?? '',
          imageUrl: detail?.imageUrl ?? '',
          description: detail?.description ?? '',
          duration: _formatDuration(detail?.times?.totalTimeMinutes ?? 0),
          difficulty: detail?.difficulty ?? 'Medium',
          cuisine: detail?.cuisineType ?? '',
          calories: detail?.kcal ?? 0,
          servings: detail?.servings ?? 2,
          ingredients: _mapIngredients(detail?.ingredients),
          instructions: _mapInstructions(detail?.steps),
        );
      }
    } catch (e) {
      Console.error('Error loading recipe: $e');
    } finally {
      _loadingRecipeDetail = false;
      notifyListeners();
    }
  }

  bool isIngredientChecked(int index) {
    return _checkedIngredientIndexes.contains(index);
  }

  String _formatDuration(int? minutes) {
    if (minutes == null) return '30 mins';
    if (minutes < 60) return '$minutes mins';
    final hours = minutes ~/ 60;
    final remainingMins = minutes % 60;
    if (remainingMins == 0) return '$hours hr';
    return '$hours hr $remainingMins mins';
  }

  List<RecipeIngredient> _mapIngredients(dynamic ingredients) {
    if (ingredients == null) return [];

    if (ingredients is List) {
      return ingredients.map((ing) {
        return RecipeIngredient(
          name: ing.name ?? ing.toString(),
          note: ing.note ?? '',
        );
      }).toList();
    }

    return [];
  }

  List<RecipeInstruction> _mapInstructions(dynamic instructions) {
    if (instructions == null) return [];

    if (instructions is List) {
      return instructions.asMap().entries.map((entry) {
        final inst = entry.value;
        return RecipeInstruction(
          step: inst.title ?? 'Step ${entry.key + 1}',
          description: inst.description ?? inst.toString(),
        );
      }).toList();
    }

    return [];
  }

  void toggleIngredient(int index) {
    if (_checkedIngredientIndexes.contains(index)) {
      _checkedIngredientIndexes.remove(index);
    } else {
      _checkedIngredientIndexes.add(index);
    }
    notifyListeners();
  }
}
