import 'package:ecommerce/src/shared/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuthService._privateConstructor();
  static final FirebaseAuthService instance =
      FirebaseAuthService._privateConstructor();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception('Sign in failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('An error occurred while signing in: $e');
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    bool isMerchant = false,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user details to Firestore
      User? user = userCredential.user;

      if (user != null) {
        UserModel userData = UserModel(
          id: user.uid,
          emailId: email,
          name: name,
          isMerchant: isMerchant,
        );

        await _firestore
            .collection(isMerchant ? 'merchant' : 'users')
            .doc(user.uid)
            .set(
          {
            ...userData.toUserRegisterJson(),
            'createdAt': Timestamp.now(),
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception('Account creation failed: ${e.message}');
      }
    } catch (e) {
      // Handle general exceptions
      throw Exception('An error occurred while creating the account: $e');
    }
  }

  Future<void> signOut() async => await _firebaseAuth.signOut();
}
