// ad_timer_service.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/console.dart';
import 'ads/interstitial_sdk.dart';
import 'ads/rewarder_sdk.dart';
import 'ads/native_sdk.dart';

// simple_ad_timer_service.dart
// import 'package:neonai/services/ads/banner_sdk.dart';
// import 'package:neonai/services/ads/splash_sdk.dart';

// import 'google_analytic_service.dart';

enum AdType { rewarded, interstitial, banner, native, splash }

class AdTimerService extends ChangeNotifier {
  static final AdTimerService _instance = AdTimerService._internal();
  factory AdTimerService() => _instance;
  AdTimerService._internal();

  // Config
  static const int adIntervalSeconds = 60; // 1 minute 20 seconds

  // State
  DateTime? _lastAdShowTime;
  bool _isShowingAd = false;
  AdType? _currentAdType;

  // Statistics
  int _totalAdsShown = 0;

  // Getters
  Duration get timeUntilNextAd {
    if (_lastAdShowTime == null) return Duration.zero;
    final elapsed = DateTime.now().difference(_lastAdShowTime!);
    final remaining = const Duration(seconds: adIntervalSeconds) - elapsed;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  bool get canShowAd => !_isShowingAd && timeUntilNextAd == Duration.zero;

  int get remainingSeconds => timeUntilNextAd.inSeconds;
  int get totalAdsShown => _totalAdsShown;

  // Check if can show ad
  bool canShowAdType(AdType type) {
    return canShowAd;
  }

  // Main method to show ad with time check

  void onAdEnded() {
    _lastAdShowTime = DateTime.now();
    _isShowingAd = false;
    notifyListeners();
    Console.log('✅ Ad ended - Timer started! Next ad in $remainingSeconds');
  }

  Future<bool> showAd(AdType type) async {
    // Check time limit
    if (!canShowAd) {
      print('⏰ Cannot show ad. Please wait ${remainingSeconds} seconds');
      return false;
    }

    // Check if already showing
    if (_isShowingAd) {
      print('⚠️ Already showing an ad');
      return false;
    }

    _isShowingAd = true;
    _currentAdType = type;
    notifyListeners();

    bool success = false;

    // Call your existing methods
    try {
      switch (type) {
        case AdType.rewarded:
          print('📱 Showing Rewarded Ad');
          await RewarderManager.startShowAutoLoadRewardedVideoAd();
          success = true;
          break;

        case AdType.interstitial:
          print('📱 Showing Interstitial Ad');

          await InterstitialManager.startShowAutoLoadInterstitialAd();
          // AnalyticsService.logEvent(name: "ad_interstitial");
          success = true;
          break;

        case AdType.banner:
          print('📱 Showing Banner Ad');
          // await BannerManager.startShowBannerAd();
          success = true;
          break;

        case AdType.native:
          print('📱 Showing Native Ad');
          await NativeManager.startShowNativeAd();
          success = true;
          break;

        case AdType.splash:
          print('📱 Showing Splash Ad');
          // await SplashManager.startShowSplashAd();
          success = true;
          break;
      }

      if (success) {
        // _lastAdShowTime = DateTime.now();
        _totalAdsShown++;
        print('✅ Ad shown! Next ad available in 60 seconds');
      }
    } catch (e) {
      print('❌ Error showing ad: $e');
      success = false;
    }

    _isShowingAd = false;
    notifyListeners();

    return success;
  }

  // Reset timer (useful for testing)
  void resetTimer() {
    _lastAdShowTime = null;
    notifyListeners();
    print('🔄 Ad timer reset');
  }

  // Get time remaining text
  String getTimeRemainingText() {
    if (remainingSeconds <= 0) return 'Ready';
    return '${remainingSeconds}s';
  }
}
