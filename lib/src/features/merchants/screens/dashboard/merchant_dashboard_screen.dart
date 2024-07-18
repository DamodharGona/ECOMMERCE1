import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/shared/providers/auth_provider.dart';

class MerchantDashboardScreen extends StatelessWidget {
  const MerchantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthProvider>().logOutCurrentUser();
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteConstants.userLoginScreenRoute,
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.power_settings_new_rounded,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
