import 'package:secure_shared_preferences/secure_shared_pref.dart';

import 'package:ecommerce/src/core/utils/constants/local_data_constants.dart';

class AppSharedPrefs {
  static late SecureSharedPref _preferences;

  // creating singleton instance
  static Future<SecureSharedPref> init() async {
    _preferences = await SecureSharedPref.getInstance();
    return _preferences;
  }

  AppSharedPrefs._privateConstructor();
  static final AppSharedPrefs instance = AppSharedPrefs._privateConstructor();

  // based on need on/off encryption
  bool enableEncryption = true;

  // Get Current User
  Future<String> getCurrentUser() async {
    try {
      String? response = await _preferences.getString(
        LocalDataConstants.currentUser,
        isEncrypted: enableEncryption,
      );

      return response ?? '';
    } catch (e) {
      return '';
    }
  }

  void setCurrentUser(String user) {
    _preferences.putString(
      LocalDataConstants.currentUser,
      user,
      isEncrypted: enableEncryption,
    );
  }
}
