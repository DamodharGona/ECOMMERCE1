import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:ecommerce/src/core/utils/constants/local_data_constants.dart';

class AppSharedPrefs {
  static late SecureSharedPref _preferences;

  // Singleton instance
  AppSharedPrefs._privateConstructor();
  static final AppSharedPrefs instance = AppSharedPrefs._privateConstructor();

  // Enable or disable encryption
  bool enableEncryption = true;

  // Initialize the shared preferences
  static Future<void> init() async {
    _preferences = await SecureSharedPref.getInstance();
  }

  Future<void> clearAllSharedPrefs() async {
    await _preferences.clearAll();
  }

  // Get current user
  Future<String> getCurrentUser() async {
    try {
      String? response = await _preferences.getString(
        LocalDataConstants.currentUser,
        isEncrypted: enableEncryption,
      );
      return response ?? '';
    } catch (e) {
      print('Error getting current user: $e');
      return '';
    }
  }

  // Set current user
  void setCurrentUser(String user) {
    _preferences.putString(
      LocalDataConstants.currentUser,
      user,
      isEncrypted: enableEncryption,
    );
  }

  // Get merchant approval status
  Future<bool?> getMerchantApprovalStatus() async {
    try {
      bool? response = await _preferences.getBool(
        LocalDataConstants.shopApprovalStatus,
        isEncrypted: enableEncryption,
      );
      print('Merchant approval status retrieved: $response');
      return response;
    } catch (e) {
      print('Error getting merchant approval status: $e');
      return null;
    }
  }

  // Set merchant approval status
  void setMerchantApprovalStatus({required bool status}) {
    _preferences.putBool(
      LocalDataConstants.shopApprovalStatus,
      status,
      isEncrypted: enableEncryption,
    );
    print('Merchant approval status set to: $status');
  }
}
