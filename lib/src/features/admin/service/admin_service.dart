import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/core/model/firebase_response_model.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/model/user_model.dart';

class AdminService {
  AdminService._privateConstructor();
  static final AdminService instance = AdminService._privateConstructor();

  Future<void> saveToCollection({
    required String ref,
    required String collectionName,
    required String categoryName,
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
          "createdAt": Timestamp.now(),
          "updatedAt": Timestamp.now(),
        },
      );
    } catch (e) {
      throw Exception('Error saving to collection: $e');
    }
  }

  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      ApiResponse<List<CategoryModel>> categories = await FirebaseService
          .instance
          .getAllDocuments<List<CategoryModel>, CategoryModel>(
        collection: 'categories',
        tFromJson: CategoryModel.fromJson,
        isList: true,
      );

      return categories.data;
    } catch (e) {
      return <CategoryModel>[];
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

  Future<List<UserModel>> fetchAllMerchants() async {
    try {
      ApiResponse<List<UserModel>> users = await FirebaseService.instance
          .getAllDocuments<List<UserModel>, UserModel>(
        collection: 'merchants',
        tFromJson: UserModel.fromJson,
        isList: true,
      );

      return users.data;
    } catch (e) {
      return <UserModel>[];
    }
  }
}
