import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  static void info(String data) {
    log('🛈\x1B[33m INFO: $data\x1B[0m');
  }

  static void success(dynamic data) {
    log('✅\x1B[32m SUCCESS: $data\x1B[0m');
  }

  static void error(dynamic data) {
    log('❌\x1B[31m ERROR: $data\x1B[0m');
  }

  static void devPrint(dynamic data) {
    debugPrint(data);
  }
}

// Color codes:
// -----------------
// Reset:   \x1B[0m
// Black:   \x1B[30m
// White:   \x1B[37m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Cyan:    \x1B[36m
