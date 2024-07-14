import 'dart:async';

import 'package:ecommerce/src/core/enum/enums.dart';
import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/utils/extensions/enum_extension.dart';
import 'package:ecommerce/src/shared/providers/auth_provider.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleStartupLogic();
    });
  }

  Future<void> _handleStartupLogic() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.checkUserAuthStatus();

      Enum loggedInUser = await _getLoggedInUser();
      String routeName =
          _getNextRoute(loggedInUser, authProvider.isUserLoggedIn);

      // Delay for a moment to show splash screen
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.pushReplacementNamed(context, routeName);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error handling startup logic: $e');
      }
      // Handle error gracefully, e.g., show error message or fallback screen
    } finally {
      if (mounted) {}
    }
  }

  Future<Enum> _getLoggedInUser() async {
    try {
      String currentUser = await AppSharedPrefs.instance.getCurrentUser();
      return currentUser.stringToEnum(CurrentUser.values);
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving logged in user: $e');
      }
      return CurrentUser.USER;
    }
  }

  String _getNextRoute(Enum loggedInUser, bool isUserLoggedIn) {
    if (loggedInUser == CurrentUser.ADMIN) {
      return RouteConstants.adminDashboardScreenRoute;
    } else if (isUserLoggedIn) {
      if (loggedInUser == CurrentUser.MERCHANT) {
        return RouteConstants.merchantDashboardScreenRoute;
      } else {
        return RouteConstants.userDashboardScreenRoute;
      }
    } else {
      return RouteConstants.userLoginScreenRoute;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[700],
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E-Commerce',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
