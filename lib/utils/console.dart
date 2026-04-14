import 'package:flutter/foundation.dart';

class Console {
  static void log(dynamic message) {
    if (kDebugMode) {
      debugPrint(' 🔍 DEBUG: $message');
    }
  }

  static void warn(dynamic message) {
    if (kDebugMode) {
      debugPrint(' ⚠️ WARNING: $message');
    }
  }

  static void error(dynamic message) {
    if (kDebugMode) {
      debugPrint(' ❌ ERROR : $message');
    }
  }
}
