import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  NavigationViewModel({int initialIndex = 0}) : _currentIndex = initialIndex;

  int _currentIndex;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}
