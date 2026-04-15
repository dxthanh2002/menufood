import 'package:ai_menu_flutter/models/recipe.dart';
import 'package:ai_menu_flutter/utils/format.dart';
import 'package:flutter/material.dart';

import '../../repositories/favourite_repository.dart';
import '../../repositories/recipe_repository.dart';
import '../../utils/console.dart';
import '../saved/saved_viewmodel.dart';

class RecipeDetail {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String duration;
  final String difficulty;
  final String cuisine;
  final String calories;
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

  late final _recipeId;

  DetailRecipeViewModel(this._recipeId) {}

  RecipeDetail? _recipe;
  RecipeDetail? get recipe => _recipe;

  Future<void> loadRecipeDetails() async {
    if (_loadingRecipeDetail) return;

    _loadingRecipeDetail = true;
    notifyListeners();

    try {
      final response = await RecipeRepository.getRecipeDetails(
        recipeId: _recipeId,
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
          difficulty: capitalize(detail?.difficulty) ?? 'Unknown',
          cuisine: detail?.cuisineType ?? '',
          calories: "${detail?.kcal ?? 0} kcal",
          servings: detail?.servings ?? 2,
          ingredients: _mapIngredients(detail?.ingredients),
          instructions: _mapInstructions(detail?.steps),
        );
        _isFavorite = detail?.isFavorite ?? false;
        Console.log("FAVOURITE ${detail?.isFavorite}");
      }
      Future.delayed(const Duration(milliseconds: 300));
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

  List<RecipeIngredient> _mapIngredients(List<IngredientDetail>? ingredients) {
    if (ingredients == null) return [];

    return ingredients.map((ing) {
      return RecipeIngredient(
        name: ing.name ?? ing.toString(),
        note: ing.unit ?? 'Unknown',
      );
    }).toList();
  }

  bool _isFavorite = false;
  bool _isLoadingFavorite = false;
  bool get isLoadingFavorite => _isLoadingFavorite;
  bool get isFavorite => _isFavorite;
  set setFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
  }

  Future<void> toggleFavorite() async {
    if (_isLoadingFavorite) return;

    _isLoadingFavorite = true;
    notifyListeners();

    try {
      if (_isFavorite) {
        // Remove from favorites
        final success = await FavouriteRepository.removeFavouritedRecipe(
          recipeId: _recipeId,
        );
        if (success) {
          _isFavorite = false;
          Console.log('Removed from favorites');
        }
      } else {
        // Add to favorites
        await FavouriteRepository.addFavouritedRecipe(recipeId: _recipeId);
        _isFavorite = true;
        Console.log('Added to favorites');
      }
      SavedRecipesViewModel.refreshSavedRecipes();
      // TODO: need to refresh the save everytime
    } catch (e) {
      Console.error('Error toggling favorite: $e');
    } finally {
      _isLoadingFavorite = false;
      notifyListeners();
    }
  }

  List<RecipeInstruction> _mapInstructions(List<StepDetail>? instructions) {
    if (instructions == null) return [];

    return instructions.asMap().entries.map((entry) {
      final inst = entry.value;
      return RecipeInstruction(
        step: inst.title ?? "Unknown Title",
        description: inst.content ?? "Unknown Step",
      );
    }).toList();
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
