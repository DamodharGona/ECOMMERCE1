import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/shared/service/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class MerchantAuthService {
  MerchantAuthService._privateConstructor();
  static final MerchantAuthService instance =
      MerchantAuthService._privateConstructor();

  Future<void> registerMerchant({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String storeName,
    required String storeAddress,
  }) async {
    try {
      await FirebaseAuthService.instance.createUserWithEmailAndPassword(
        context: context,
        name: name,
        email: email,
        password: password,
        isMerchant: true,
      );

      await FirebaseService.instance.addDocument(
        collection: 'stores',
        data: {
          "ownerId": FirebaseAuthService.instance.currentUser!.uid,
          "name": storeName,
          "address": storeAddress,
          "isVerified": false,
          "createdAt": Timestamp.now(),
          "verifiedAt": "NA",
          "verifiedBy": "NA",
        },
      );
    } catch (e) {
      throw Exception("Failed To Register Merchant");
    }
  }
}
