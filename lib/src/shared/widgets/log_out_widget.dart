import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/shared/providers/auth_provider.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        context.read<AuthProvider>().logOutCurrentUser();
        await AppSharedPrefs.instance.clearAllSharedPrefs();
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteConstants.userLoginScreenRoute,
            (route) => false,
          );
        }
      },
      icon: const Icon(
        Icons.power_settings_new_rounded,
        size: 30,
      ),
    );
  }
}
