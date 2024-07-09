import 'package:ecommerce/src/core/utils/utils.dart';
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
        if (context.mounted) {
          showSnackBar(
            context: context,
            content: 'No user found for that email.',
          );
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          showSnackBar(
            context: context,
            content: 'Wrong password provided for that user.',
          );
        }
      } else {
        if (context.mounted) {
          showSnackBar(
            context: context,
            content: 'Sign in failed: ${e.message}',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(
          context: context,
          content: 'An error occurred while signing in: $e',
        );
      }
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
    bool isAdmin = false,
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
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'isAdmin': true,
          'createdAt': Timestamp.now(),
        });
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      if (e.code == 'weak-password') {
        if (context.mounted) {
          showSnackBar(
            context: context,
            content: 'The password provided is too weak.',
          );
        }
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          showSnackBar(
            context: context,
            content: 'The account already exists for that email.',
          );
        }
      } else {
        if (context.mounted) {
          showSnackBar(
            context: context,
            content: 'Account creation failed: ${e.message}',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(
          context: context,
          content: 'An error occurred while creating the account: $e',
        );
      }
    }
  }

  // Future<bool> isAdmin() async {
  //   User? user = currentUser;
  //   if (user != null) {
  //     DocumentSnapshot userDoc =
  //         await _firestore.collection('users').doc(user.uid).get();
  //     if (userDoc.exists && userDoc.data() != null) {
  //       Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
  //       return data['isAdmin'] ?? false;
  //     }
  //   }
  //   return false;
  // }

  Future<void> signOut({required BuildContext context}) async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      if (context.mounted) {
        showSnackBar(
          context: context,
          content: 'An error occurred while signing out: $e',
        );
      }
    }
  }
}
