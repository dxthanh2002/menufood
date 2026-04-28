import 'package:flutter/material.dart';

import '../../services/ad_service.dart';

class NavigationViewModel extends ChangeNotifier {
  NavigationViewModel({int initialIndex = 0}) : _currentIndex = initialIndex;

  int _currentIndex;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex != index) {
      AdTimerService().showAd(AdType.interstitial);
      _currentIndex = index;
      notifyListeners();
    }
  }
}
