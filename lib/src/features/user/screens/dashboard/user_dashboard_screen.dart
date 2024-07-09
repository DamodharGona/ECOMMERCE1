import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/shared/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

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
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
