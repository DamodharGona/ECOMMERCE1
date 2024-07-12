import 'dart:async';

import 'package:ecommerce/src/core/enum/enums.dart';
import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/utils/extensions/enum_extension.dart';
import 'package:ecommerce/src/shared/providers/auth_provider.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';

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
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.checkUserAuthStatus();

      Timer(const Duration(seconds: 1), () async {
        Enum loggedInUser = await getLoggedInUser();

        if (loggedInUser == CurrentUser.ADMIN) {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              RouteConstants.adminDashboardScreenRoute,
            );
          }
        } else if (authProvider.isUserLoggedIn) {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              RouteConstants.userDashboardScreenRoute,
            );
          }
        } else {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              RouteConstants.userLoginScreenRoute,
            );
          }
        }
      });
    });
  }

  Future<Enum> getLoggedInUser() async {
    try {
      String currentUser = await AppSharedPrefs.instance.getCurrentUser();
      return currentUser.stringToEnum(CurrentUser.values);
    } catch (e) {
      return CurrentUser.USER;
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
