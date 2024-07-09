import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/core/model/firebase_response_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addDocument<T>({
    required String collection,
    required ApiResponse<T> apiResponse,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    try {
      await _db.collection(collection).add(toJson(apiResponse.data));
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
        return ApiResponse.fromJson<T, P>(
          snapshot.data() as Map<dynamic, dynamic>,
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
        return ApiResponse.fromJson<T, P>(
          doc.data() as Map<dynamic, dynamic>,
          tFromJson,
          isList: isList,
        );
      }).toList();
    } catch (e) {
      print('Error getting documents: $e');
      rethrow; // Throw error for handling in UI or upper layers
    }
  }
}
