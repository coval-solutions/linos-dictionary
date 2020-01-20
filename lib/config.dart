import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static const String TEST_DEVICE = ''; 

  static String getEnvVar(String string) {
    return DotEnv().env[string];
  }

  static bool isReleaseMode() {
    return kReleaseMode;
  }

  static getAppAdId() {
    return Platform.isAndroid
      ? getEnvVar('GOOGLE_APP_AD_ID_ANDROID')
      : getEnvVar('GOOGLE_APP_AD_ID_IOS');
  }

  static getAdUnitId() {
    return Platform.isAndroid
      ? getEnvVar('GOOGLE_BANNER_AD_UNIT_ID_ANDROID')
      : getEnvVar('GOOGLE_BANNER_AD_UNIT_ID_IOS');
  }
}
