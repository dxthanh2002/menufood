// lib/features/saved/saved_recipes_viewmodel.dart
import 'dart:async';

import 'package:ai_menu_flutter/repositories/favourite_repository.dart';
import 'package:flutter/material.dart';
import '../../models/favourite.dart';
import '../../models/recipe.dart';
import '../../navigation/routes.dart';
import '../../services/ad_service.dart';
import '../../utils/console.dart';
import '../../utils/format.dart';

class SavedRecipesViewModel extends ChangeNotifier {
  static SavedRecipesViewModel? _instance;
  SavedRecipesViewModel() {
    _instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSavedRecipes();
    });
  }

  static void refreshSavedRecipes() {
    _instance?.loadSavedRecipes();
  }

  final List<String> _categories = [
    'All',
    'Quick',
    'Healthy',
    'Vegetarian',
    'Desserts',
  ];

  String _selectedCategory = 'All';
  bool _isLoadingSaved = false;
  String? _errorMessage;

  // Store API data
  List<FavouriteItem> _favouriteItems = [];
  List<Map<String, dynamic>> _savedRecipes = [];

  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoadingSaved => _isLoadingSaved;
  String? get errorMessage => _errorMessage;

  // In SavedRecipesViewModel
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  List<Map<String, dynamic>> _searchResults = [];

  List<Map<String, dynamic>> get filteredRecipes {
    if (_searchQuery.isNotEmpty) {
      return _searchResults;
    }
    if (_selectedCategory == 'All') {
      return _savedRecipes;
    }
    return _savedRecipes.where((item) {
      final tag = item['typeTag'] as String;
      return tag == _selectedCategory;
    }).toList();
  }

  void searchRecipes(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _searchResults = _savedRecipes.where((item) {
      final recipe = item['recipe'] as Recipe;
      return recipe.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> removeSavedRecipe(String recipeId) async {
    try {
      // Call API to remove from favorites
      final success = await FavouriteRepository.removeFavouritedRecipe(
        recipeId: recipeId,
      );
      if (success) {
        _savedRecipes.removeWhere(
          (item) => (item['recipe'] as Recipe).id == recipeId,
        );
        _favouriteItems.removeWhere((item) => item.recipeId == recipeId);
        notifyListeners();
      } else {
        Console.error("REMOVE SAVED");
        Console.error("REMOVE SAVED");
        Console.error("REMOVE SAVED");
      }

      // Remove locally
    } catch (e) {
      debugPrint('Error removing recipe: $e');
    }
  }

  Future<void> loadSavedRecipes() async {
    _isLoadingSaved = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await FavouriteRepository.getFavouritedRecipe();

      if (response.error == true) {
        _errorMessage = 'Failed to load saved recipes';
        _savedRecipes = [];
      } else {
        _favouriteItems = response.data?.items ?? [];
        _savedRecipes = _favouriteItems.map((item) {
          return {
            'recipe': Recipe(
              id: item.recipeId ?? '',
              title: item.recipeName ?? '',
              imageUrl: item.recipeImageUrl ?? '',
              duration: formatDuration(item.cookTimeMinutes),
              difficulty: item.difficulty ?? 'Medium',
              rating: 4.5, // Default rating
            ),
            'typeTag': item.shortDescription?.toUpperCase() ?? 'RECIPE',
          };
        }).toList();
      }
    } catch (e) {
      debugPrint('Error loading saved recipes: $e');
      _errorMessage = 'Error loading recipes: $e';
      _savedRecipes = [];
    } finally {
      _isLoadingSaved = false;
      notifyListeners();
    }
  }

  void navigateToDetail(BuildContext context, Recipe recipe) async {
    final isReady = AdTimerService().canShowAd;
    if (isReady) {
      AdTimerService().showAd(AdType.interstitial);
      await Future.delayed(Duration(milliseconds: 400));
    }

    Navigator.pushNamed(context, Routes.detailRecipe, arguments: recipe.id);
  }

  // Refresh method
  Future<void> refreshRecipes() async {
    await loadSavedRecipes();
  }
}
