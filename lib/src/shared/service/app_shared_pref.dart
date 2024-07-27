import 'package:ecommerce/src/shared/model/merchant_model.dart';
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
      return response;
    } catch (e) {
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
  }

  // Get Merchant Data
  Future<MerchantModel> getMerchantData() async {
    try {
      Map<dynamic, dynamic>? response = await _preferences.getMap(
        LocalDataConstants.merchantData,
        isEncrypted: enableEncryption,
      );

      return MerchantModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      return const MerchantModel();
    }
  }

  // Set merchant approval status
  void setMerchantData({required MerchantModel merchantModel}) {
    _preferences.putMap(
      LocalDataConstants.merchantData,
      merchantModel.toSharedPrefJson(),
      isEncrypted: enableEncryption,
    );
  }
}
