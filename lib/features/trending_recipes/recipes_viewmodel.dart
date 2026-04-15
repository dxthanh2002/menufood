import 'dart:async';

import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../navigation/routes.dart';
import '../../repositories/recipe_repository.dart';
import '../../utils/console.dart';

class TrendingRecipesViewModel extends ChangeNotifier {
  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  final List<String> categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Desserts',
    'Vegan',
    'Quick',
  ];

  List<TrendingItem> _trendingRecipes = [];
  List<TrendingItem> get trendingRecipes => _trendingRecipes;

  bool _isLoadingTrending = false;
  bool get isLoadingTrending => _isLoadingTrending;
  bool _hasLoadedTrending = false;

  Future<void> loadTrendingRecipes() async {
    if (_isLoadingTrending || _hasLoadedTrending) return;

    _isLoadingTrending = true;
    notifyListeners();

    try {
      final response = await RecipeRepository.getRecipeTrendings();

      if (response.error == false && response.data?.items != null) {
        _trendingRecipes = response.data!.items!;
        _hasLoadedTrending = true;
      }
    } catch (e) {
      Console.log('Error loading trending recipes: $e');
    } finally {
      _isLoadingTrending = false;
      notifyListeners();
    }
  }

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  List<TrendingItem> _searchResults = [];
  List<TrendingItem> get searchResults => _searchResults;

  String _searchQuery = '';
  Timer? _debounceTimer;

  Future<void> searchRecipes(String query) async {
    if (_debounceTimer?.isActive == true) {
      _debounceTimer?.cancel();
    }

    _searchQuery = query;

    if (query.isEmpty) {
      _searchResults = [];
      _searchQuery = '';
      notifyListeners();
      return;
    }

    _isSearching = true;
    _searchQuery = query;
    notifyListeners();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final results = await RecipeRepository.searchRecipeTrendings(
          name: query,
        );
        _searchResults = results
            .map(
              (item) => TrendingItem(
                id: item.id,
                name: item.name,
                imageUrl: item.imageUrl,
                totalTimeMinutes: item.cookTimeMinutes,
                difficulty: item.difficulty,
                score: 0.0,
                isFavorite: item.isFavorite,
              ),
            )
            .toList();
      } catch (e) {
        Console.log('Error searching recipes: $e');
        _searchResults = [];
      } finally {
        _isSearching = false;
        notifyListeners();
      }
    });
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _searchResults = [];
    _searchQuery = '';
    _isSearching = false;
    notifyListeners();
  }

  void setSelectedCategory(int index) {
    _selectedCategoryIndex = index;
    clearSearch();
    notifyListeners();
  }

  void navigateToDetail(BuildContext context, String recipeId) {
    Navigator.pushNamed(context, Routes.detailRecipe, arguments: recipeId);
  }

  // Add these methods to your existing ViewModel

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
