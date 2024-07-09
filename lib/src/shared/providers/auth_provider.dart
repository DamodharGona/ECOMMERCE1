import 'package:ecommerce/src/shared/service/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  /* When user opening app after logged in, we call this function
     to check whether the user has loggedin or not
   */
  void checkUserAuthStatus() {
    _isUserLoggedIn = FirebaseAuthService.instance.currentUser != null;
    notifyListeners();
  }

  /* When user logges out manually, this fns helps to update the user
     loggedin status. since we are not listining to live changes */
  void logOutCurrentUser() async {
    await FirebaseAuthService.instance.signOut();
    checkUserAuthStatus();
    notifyListeners();
  }
}
