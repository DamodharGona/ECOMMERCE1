import 'dart:async';

import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/shared/providers/auth_provider.dart';

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

      Timer(
        const Duration(seconds: 1),
        () {
          if (authProvider.isUserLoggedIn) {
            Navigator.pushReplacementNamed(
              context,
              RouteConstants.userDashboardScreenRoute,
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              RouteConstants.userLoginScreenRoute,
            );
          }
        },
      );
    });
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
