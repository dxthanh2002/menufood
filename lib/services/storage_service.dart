import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import '../utils/constants.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();
  static const _uuid = Uuid();

  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  Future<String> getDeviceId() async {
    String? deviceId = await _storage.read(key: DEVICE_ID_KEY);

    // If deviceId already exists → reuse it
    if (deviceId != null && deviceId.isNotEmpty) {
      return deviceId;
    }

    // Generate new UUID
    deviceId = _uuid.v4();
    await _storage.write(key: ONBOARDED_KEY, value: deviceId);

    return deviceId;
  }

  Future<String?> getToken() async {
    return await _storage.read(key: TOKEN_KEY);
  }

  Future<void> saveTokens({required String token}) async {
    await _storage.write(key: TOKEN_KEY, value: token);
  }

  // --- Onboarding Status ---
  /// Check if user has completed onboarding
  Future<bool> isOnboarded() async {
    try {
      final String? value = await _storage.read(key: ONBOARDED_KEY);
      return value == 'true';
    } catch (e) {
      return false;
    }
  }

  /// Save onboarding completion status
  Future<void> setOnboarded(bool value) async {
    await _storage.write(key: ONBOARDED_KEY, value: value.toString());
  }
}
