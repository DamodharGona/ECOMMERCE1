import 'dart:convert';

import 'package:ecommerce/src/shared/model/merchant_model.dart';
import 'package:ecommerce/src/core/utils/constants/local_data_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static late SharedPreferences _preferences;

  // Singleton instance
  AppSharedPrefs._privateConstructor();
  static final AppSharedPrefs instance = AppSharedPrefs._privateConstructor();

  // Enable or disable encryption
  bool enableEncryption = true;

  // Initialize the shared preferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> clearAllSharedPrefs() async {
    await _preferences.clear();
  }

  // Get current user
  Future<String> getCurrentUser() async {
    try {
      String? response = await _preferences.getString(
        LocalDataConstants.currentUser,
      );
      return response ?? '';
    } catch (e) {
      return '';
    }
  }

  // Set current user
  void setCurrentUser(String user) {
    _preferences.setString(
      LocalDataConstants.currentUser,
      user,
    );
  }

  // Get merchant approval status
  Future<bool?> getMerchantApprovalStatus() async {
    try {
      bool? response = await _preferences.getBool(
        LocalDataConstants.shopApprovalStatus,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  // Set merchant approval status
  void setMerchantApprovalStatus({required bool status}) {
    _preferences.setBool(
      LocalDataConstants.shopApprovalStatus,
      status,
    );
  }

  // Get Merchant Data
  Future<MerchantModel> getMerchantData() async {
    try {
      String? response =  _preferences.getString(
        LocalDataConstants.merchantData,
      );

      return MerchantModel.fromJson(json.decode(response!));
    } catch (e) {
      return const MerchantModel();
    }
  }

  // Set merchant approval status
  void setMerchantData({required MerchantModel merchantModel}) {
    _preferences.setString(
      LocalDataConstants.merchantData,
      merchantModel.toSharedPrefJson().toString(),
    );
  }
}
