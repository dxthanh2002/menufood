import 'package:ai_menu_flutter/utils/constants.dart';
import 'package:flutter/foundation.dart';

import '../repositories/auth_repository.dart';
import '../utils/console.dart';
import 'api_service.dart';

class AppService extends ChangeNotifier {
  bool _initialized = false;
  bool get initialized => _initialized;

  bool _onboarded = false;
  bool get onboarded => _onboarded;
  set onboarded(bool value) {
    _onboarded = value;
    // StorageService().setOnboarded(true);
    notifyListeners();
  }

  AppService() {
    init();
  }

  // Add app-wide business logic here
  Future<void> init() async {
    if (_initialized) return;

    try {
      // _onboarded = await StorageService().isOnboarded();
      // for testing purpose
      _onboarded = true;

      if (!_onboarded) {
        // New user, show onboarding
        await Future.delayed(const Duration(milliseconds: 400));
        _initialized = true;
        notifyListeners();
        return;
      }

      Console.log("AppService logging in...");
      // final deviceId = await StorageService().getDeviceId();
      final response = await AuthRepository.login(
        // deviceId: deviceId,
        // for testing purpose
        deviceId: "12323",
        platform: "ios",
        firebaseToken: '', // Add if use Firebase
        appCode: APP_CODE,
      );

      // set headers
      api.options.headers['Authorization'] =
          'Bearer ${response.data!.accessToken}';

      _initialized = true;
      notifyListeners();
    } catch (e) {
      Console.error("AppService.init failed: $e");
      rethrow; // Or handle gracefully
    }
  }
}
