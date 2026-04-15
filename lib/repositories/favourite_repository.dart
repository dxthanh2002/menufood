import '../models/favourite.dart';
import '../services/api_service.dart';
import '../utils/console.dart';

class FavouriteRepository {
  static Future<FavouriteRecipeResponse> getFavouritedRecipe() async {
    final response = await api.get('app-menu-ai/favorites');

    return FavouriteRecipeResponse.fromJson(response.data);
  }

  static Future<FavouriteItem> addFavouritedRecipe({
    required String recipeId,
  }) async {
    final response = await api.post(
      'app-menu-ai/favorites',
      data: {"recipeId": recipeId},
    );

    if (response.data['error'] == true) {
      Console.error("ADD FAVOURITE");
    }

    return FavouriteItem.fromJson(response.data['data']);
  }

  static Future<bool> removeFavouritedRecipe({required String recipeId}) async {
    final response = await api.delete('app-menu-ai/favorites/$recipeId');

    if (response.data['data']['deleted'] == true) {
      return true;
    }

    return false;
  }
}
