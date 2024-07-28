import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce/src/core/model/firebase_response_model.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/shared/model/merchant_model.dart';
import 'package:ecommerce/src/shared/model/user_model.dart';

class AdminService {
  AdminService._privateConstructor();
  static final AdminService instance = AdminService._privateConstructor();

  Future<void> saveToCollection({
    required String ref,
    required String collectionName,
    required String categoryName,
    String categoryId = '',
    required File file,
  }) async {
    try {
      String imageUrl = await FirebaseService.instance.storeFileToFirebase(
        file: file,
        ref: ref,
      );

      await FirebaseService.instance.addDocument(
        collection: collectionName,
        data: {
          "name": categoryName,
          "imageUrl": imageUrl,
          if (categoryId.isNotEmpty) "categoryId": categoryId,
          "createdAt": Timestamp.now(),
          "updatedAt": Timestamp.now(),
        },
      );
    } catch (e) {
      throw Exception('Error saving to collection: $e');
    }
  }

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      ApiResponse<List<UserModel>> users = await FirebaseService.instance
          .getAllDocuments<List<UserModel>, UserModel>(
        collection: 'users',
        tFromJson: UserModel.fromJson,
        isList: true,
      );

      return users.data;
    } catch (e) {
      return <UserModel>[];
    }
  }

  Future<List<MerchantModel>> fetchAllMerchants() async {
    try {
      ApiResponse<List<MerchantModel>> users = await FirebaseService.instance
          .getAllDocuments<List<MerchantModel>, MerchantModel>(
        collection: 'merchants',
        tFromJson: MerchantModel.fromJson,
        isList: true,
      );

      return users.data;
    } catch (e) {
      return <MerchantModel>[];
    }
  }

  Future<List<MerchantModel>> fetchAllShops({required bool isApproved}) async {
    try {
      // Step 1: Fetch all merchants
      List<MerchantModel> merchantsList = await fetchAllMerchants();

      // Step 2: Fetch all stores
      ApiResponse<List<Store>> storesResponse =
          await FirebaseService.instance.getAllDocuments<List<Store>, Store>(
        collection: 'stores',
        tFromJson: Store.fromJson,
        isList: true,
      );

      // Step 3: Map the stores to their corresponding merchants
      List<MerchantModel> merchantsWithStores = merchantsList.map((merchant) {
        Store? store = storesResponse.data.firstWhere(
          (store) => store.ownerId == merchant.id,
          orElse: () => const Store(),
        );

        return merchant.copyWith(store: store);
      }).toList();

      // Step 4: Filter the results based on the isPending status
      List<MerchantModel> filteredMerchants =
          merchantsWithStores.where((merchant) {
        return merchant.store.isStoreVerified == isApproved;
      }).toList();

      return filteredMerchants;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching shops: $e');
      }
      return <MerchantModel>[];
    }
  }

  Future<Map<String, dynamic>> fetchShopsStatus() async {
    try {
      ApiResponse<List<Store>> storesResponse =
          await FirebaseService.instance.getAllDocuments<List<Store>, Store>(
        collection: 'stores',
        tFromJson: Store.fromJson,
        isList: true,
      );

      int approvedList = 0;
      int pendingList = 0;

      for (var store in storesResponse.data) {
        if (store.isStoreVerified == true) {
          approvedList++;
        } else {
          pendingList++;
        }
      }

      return {
        'approved': approvedList,
        'pending': pendingList,
      };
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching shops: $e');
      }
      return {};
    }
  }

  Future<void> approveOrRejectShop({
    required bool approve,
    required String id,
  }) async {
    try {
      await FirebaseService.instance.updateDocument(
        collection: 'stores',
        documentId: id,
        data: {"isStoreVerified": approve},
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error approveOrReject shops: $e');
      }
    }
  }
}
