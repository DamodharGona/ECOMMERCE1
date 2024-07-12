import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/core/model/firebase_response_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  FirestoreService._privateConstructor();
  static final FirestoreService instance =
      FirestoreService._privateConstructor();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> addDocument<T>({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _db.collection(collection).add(data);
    } catch (e) {
      print('Error adding document: $e');
      rethrow; // Throw error for handling in UI or upper layers
    }
  }

  Future<ApiResponse<T>> getDocumentBasedOnId<T, P>({
    required String collection,
    required String documentId,
    required Function(Map<String, dynamic>) tFromJson,
    required bool isList,
  }) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection(collection).doc(documentId).get();
      if (snapshot.exists) {
        // Adding document ID to the data map
        final data = snapshot.data() as Map<String, dynamic>;
        data['id'] = snapshot.id;

        return ApiResponse.fromJson<T, P>(
          data,
          tFromJson,
          isList: isList,
        );
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      print('Error getting document: $e');
      rethrow; // Throw error for handling in UI or upper layers
    }
  }

  Future<List<ApiResponse<T>>> getAllDocuments<T, P>({
    required String collection,
    required Function(Map<String, dynamic>) tFromJson,
    required bool isList,
  }) async {
    try {
      QuerySnapshot snapshot = await _db.collection(collection).get();
      return snapshot.docs.map((doc) {
        // Adding document ID to the data map
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;

        return ApiResponse.fromJson<T, P>(
          data,
          tFromJson,
          isList: isList,
        );
      }).toList();
    } catch (e) {
      print('Error getting documents: $e');
      rethrow; // Throw error for handling in UI or upper layers
    }
  }

  Future<String> storeFileToFirebase({
    required String ref,
    required File file,
  }) async {
    try {
      UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      rethrow;
    }
  }

  Future<int> getDocumentCount(String collection) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.size;
  }
}
