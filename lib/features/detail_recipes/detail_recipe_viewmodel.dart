import 'package:flutter/material.dart';

class DetailRecipeViewModel extends ChangeNotifier {
  final Set<int> _checkedIngredientIndexes = <int>{};

  Set<int> get checkedIngredientIndexes => _checkedIngredientIndexes;

  bool isIngredientChecked(int index) {
    return _checkedIngredientIndexes.contains(index);
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
