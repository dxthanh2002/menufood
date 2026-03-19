import 'package:flutter/material.dart';
import '../../models/recipe.dart';

class RecipesViewModel extends ChangeNotifier {
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

  final List<Recipe> recipes = [
    Recipe(
      id: '1',
      title: 'Honey Glazed Salmon Salad',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD3ENfM-tdb1YCYAdjt2HSKp-WThy86YnpY19LeGPCXpecqFBnMkx51ndnSCssW-o9DBsxeaMCgiJCvt1JtLdIg3naQCh4AaEuFewqTI58GsMJAVwfa5_zCxXyrEhm5B3HnXaRK_NmlbJ2eL_TextIwlQqk-egTExHp5nYHZY9ml9z11xqvSHJMpSToRd_WgHi3CHcyNGzPB6-t56LxlzZZvOQ4m4MClr6rzQemKaDXTPDdOs34_H_u5Pt5gJptdK3qcmSGlbSWXaM',
      duration: '25 min',
      difficulty: 'Medium',
      rating: 4.8,
      isPopular: true,
    ),
    Recipe(
      id: '2',
      title: 'Creamy Wild Mushroom Pasta',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAaVP3udJMw6d9EYw9JLFCvYGkKgZWAb1mcfgIqOxzs2rljvOlSxQeIuuzAvreHlwEfriu-SKHz912C9IYqJmwiTfXyyQpO-qO7Of-PWGB52l_DWDaPlNQpsoGTlHJpgKIfQ8fws16psnKNFc13JK25E3Y6oBVGlVEokvGws1F2uGmoqIvWj3vAPsdOUALN6hTa0eM_lHRHkARn1rV9cBC4WpEmh8nfBJ063_rpsrpNxx-YeMKHas9ZP1dtNQkjpVInrbX7z5Okdgk',
      duration: '15 min',
      difficulty: 'Easy',
      rating: 4.5,
    ),
    Recipe(
      id: '3',
      title: 'Avocado & Poached Egg Toast',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAWA-_NvjYVrbLKUqUFjIGCoyh23wRMTRRXPdaGUE4LAygevdEUXruT3ESNXxrE534qb9SA7HxoE5tsYyK3kSnfz6dGeCX6Jp_3iEfGyoypDt5e4OfA9s3KfO9FUnG7TIC6LNUERvQzCHQ9WtolAaRNYDGGrsah9cIMum3P5YIJEcY9VqblwL1jMhHoakwUomgq1RriDJC1vx3JZK_HgmqRLOJMA8-mG3usl-FKTenKrDAVrOyZX1_ws5SItfVLo6_LfyeirVyEdgI',
      duration: '10 min',
      difficulty: 'Easy',
      rating: 4.9,
    ),
  ];

  void setSelectedCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }
}
