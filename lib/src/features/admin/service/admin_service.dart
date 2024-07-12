import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';

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
      String imageUrl = await FirestoreService.instance.storeFileToFirebase(
        file: file,
        ref: ref,
      );

      await FirestoreService.instance.addDocument(
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
}
