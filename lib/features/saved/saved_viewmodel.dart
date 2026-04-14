// lib/features/saved/saved_recipes_viewmodel.dart
import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../navigation/routes.dart';
import '../../repositories/recipe_repository.dart';
import '../home/step3_result/step3_result_viewmodel.dart';

class SavedRecipesViewModel extends ChangeNotifier {
  SavedRecipesViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSavedRecipes();
    });
  }
  final List<String> _categories = [
    'All',
    'Quick',
    'Healthy',
    'Vegetarian',
    'Desserts',
  ];

  String _selectedCategory = 'All';
  bool _isLoading = false;
  String? _errorMessage;

  // Store API data
  List<FavouriteItem> _favouriteItems = [];
  List<Map<String, dynamic>> _savedRecipes = [];

  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Map<String, dynamic>> get filteredRecipes {
    if (_selectedCategory == 'All') {
      return _savedRecipes;
    }
    return _savedRecipes.where((item) {
      final tag = item['typeTag'] as String;
      return tag == _selectedCategory;
    }).toList();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> removeSavedRecipe(String recipeId) async {
    try {
      // Call API to remove from favorites
      // await RecipeRepository.removeFavourite(recipeId);

      // Remove locally
      _savedRecipes.removeWhere(
        (item) => (item['recipe'] as Recipe).id == recipeId,
      );
      _favouriteItems.removeWhere((item) => item.recipeId == recipeId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error removing recipe: $e');
    }
  }

  Future<void> loadSavedRecipes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await RecipeRepository.getFavouritedRecipe();

      if (response.error == true) {
        _errorMessage = 'Failed to load saved recipes';
        _savedRecipes = [];
      } else {
        _favouriteItems = response.data?.items ?? [];
        _convertFavouritesToRecipes();
      }
    } catch (e) {
      debugPrint('Error loading saved recipes: $e');
      _errorMessage = 'Error loading recipes: $e';
      _savedRecipes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _convertFavouritesToRecipes() {
    _savedRecipes = _favouriteItems.map((item) {
      return {
        'recipe': Recipe(
          id: item.recipeId ?? '',
          title: item.recipeName ?? '',
          imageUrl: item.recipeImageUrl ?? '',
          duration: _formatDuration(item.cookTimeMinutes),
          difficulty: item.difficulty ?? 'Medium',
          rating: 4.5, // Default rating
        ),
        'typeTag': item.cuisineType?.toUpperCase() ?? 'RECIPE',
      };
    }).toList();
  }

  String _formatDuration(int? minutes) {
    if (minutes == null) return '30 mins';
    if (minutes < 60) return '$minutes mins';
    final hours = minutes ~/ 60;
    final remainingMins = minutes % 60;
    if (remainingMins == 0) return '$hours hr';
    return '$hours hr $remainingMins mins';
  }

  String getRecipeId(Recipe recipe) {
    // Try to find matching favourite item for more details
    final favouriteItem = _favouriteItems.firstWhere(
      (item) => item.recipeName == recipe.title,
      orElse: () => FavouriteItem(),
    );

    return favouriteItem.id!;
  }

  void navigateToDetail(BuildContext context, Recipe recipe) {
    final recipeId = getRecipeId(recipe);
    Navigator.pushNamed(context, Routes.detailRecipe, arguments: recipeId);
  }

  // Refresh method
  Future<void> refreshRecipes() async {
    await loadSavedRecipes();
  }
}
