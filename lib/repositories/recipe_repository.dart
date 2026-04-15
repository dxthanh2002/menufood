import 'package:ai_menu_flutter/models/recipe.dart';
import 'package:dio/dio.dart';

import '../services/api_service.dart';

class RecipeRepository {
  static Future<AnalyzeResponse> analyzeImage({
    required String imagePath,
  }) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last, // Extract filename from path
      ),
    });

    final response = await api.post(
      'app-menu-ai/ingredients/analyze',
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );

    return AnalyzeResponse.fromJson(response.data);
  }

  static Future<RecipeDetailReponse> getRecipeDetails({
    required String recipeId,
  }) async {
    final response = await api.get('app-menu-ai/recipes/$recipeId');

    return RecipeDetailReponse.fromJson(response.data);
  }

  static Future<SearchRecipeResponse> searchRecipe({
    required List<String> ingredients,
    required String mealTime,
    required String cuisine,
    required List<String> cookingPreferences,
    int limit = 10,
    int page = 1,
  }) async {
    final response = await api.post(
      'app-menu-ai/recipes/recommend',
      data: {
        'ingredients': ingredients,
        'mealTime': mealTime,
        'cuisine': cuisine,
        'cookingPreferences': cookingPreferences,
        'limit': limit,
        'page': page,
      },
    );

    return SearchRecipeResponse.fromJson(response.data);
  }

  static Future<RecipeSuggestionResponse> getRecipeSuggestions() async {
    final response = await api.get('app-menu-ai/recipes/suggestions/random');
    return RecipeSuggestionResponse.fromJson(response.data);
  }

  static Future<RecipeTrendingResponse> getRecipeTrendings({
    int limit = 20,
    int page = 1,
  }) async {
    final response = await api.get(
      'app-menu-ai/recipes/trending?limit=$limit&page=$page',
    );

    return RecipeTrendingResponse.fromJson(response.data);
  }

  static Future<List<SearchRecipeItem>> searchRecipeTrendings({
    required String name,
  }) async {
    final response = await api.get('app-menu-ai/recipes/search?q=$name');

    // Parse the response correctly
    final data = response.data['data']['items'] as List;
    return data.map((item) => SearchRecipeItem.fromJson(item)).toList();
  }
}
