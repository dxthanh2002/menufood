import '../models/auth.dart';
import '../services/api_service.dart';

class AuthRepository {
  static Future<LoginResponse> login({
    required String deviceId,
    required String firebaseToken,
    required String platform,
    required String appCode,
  }) async {
    final response = await api.post(
      'auth/device',
      data: {
        'deviceId': deviceId,
        // 'firebase_token': firebaseToken,
        'platform': platform,
        'appCode': appCode,
      },
    );

    return LoginResponse.fromJson(response.data);
  }
}
