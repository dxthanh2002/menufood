import 'package:ai_menu_flutter/models/recipe.dart';
import 'package:ai_menu_flutter/repositories/recipe_repository.dart';
import 'package:ai_menu_flutter/services/ad_service.dart';
import 'package:ai_menu_flutter/services/ads/rewarder_sdk.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../navigation/routes.dart';
import '../../utils/console.dart';

class HomeViewModel extends ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();

  List<SuggestionItem> _suggestions = [];
  List<SuggestionItem> get suggestions => _suggestions;

  bool _loadingSuggestion = false;
  bool get loadingSuggestion => _loadingSuggestion;

  bool _hasLoadedSuggestion = false;

  Future<void> loadSuggestion() async {
    if (_loadingSuggestion || _hasLoadedSuggestion) return;

    _loadingSuggestion = true;
    notifyListeners();

    try {
      final response = await RecipeRepository.getRecipeSuggestions();

      if (response.error == false && response.data?.items != null) {
        _suggestions = response.data!.items!.toList();
        _hasLoadedSuggestion = true;
      }
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      Console.log('Error loading suggestions: $e');
    } finally {
      _loadingSuggestion = false;
      notifyListeners();
    }
  }

  bool _isPicking = false;
  bool get isPicking => _isPicking;
  Future<void> pickImageToConfirm(BuildContext context) async {
    if (_isPicking) return;
    _isPicking = true;
    notifyListeners();

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (image != null && context.mounted) {
        Navigator.pushNamed(
          context,
          Routes.confirmIngredients,
          arguments: image.path,
        );
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    } finally {
      _isPicking = false;
      notifyListeners();
    }
  }

  void navigateToDetail(BuildContext context, String recipeId) async {
    final isReady = AdTimerService().canShowAd;
    if (isReady) {
      AdTimerService().showAd(AdType.interstitial);
      await Future.delayed(Duration(milliseconds: 400));
    }

    Navigator.pushNamed(context, Routes.detailRecipe, arguments: recipeId);
  }
}
