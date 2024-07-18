import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/shared/model/merchant_model.dart';
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
    required Store storeData,
  }) async {
    try {
      await FirebaseAuthService.instance.createUserWithEmailAndPassword(
        context: context,
        name: name,
        email: email,
        password: password,
        isMerchant: true,
      );

      final store = storeData.copyWith(
        ownerId: FirebaseAuthService.instance.currentUser!.uid,
        createdAt: Timestamp.now().toString(),
        verifiedAt: 'NA',
        verifiedBy: 'NA',
      );

      await FirebaseService.instance.addDocument(
        collection: 'stores',
        data: store.toJson(),
      );
    } catch (e) {
      throw Exception("Failed To Register Merchant");
    }
  }
}
