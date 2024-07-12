import 'package:ecommerce/src/core/enum/enums.dart';
import 'package:ecommerce/src/core/utils/extensions/enum_extension.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/utils/extensions/string_extensions.dart';
import 'package:ecommerce/src/shared/widgets/multi_auth_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_button_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void userLogin() {
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      if (emailController.text.isEqual('admin@gmail.com') &&
          passwordController.text.isEqual('Pass@123')) {
        AppSharedPrefs.instance.setCurrentUser(
          CurrentUser.ADMIN.enumToString(),
        );

        print("step 1: ${CurrentUser.ADMIN.enumToString()}");

        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteConstants.adminDashboardScreenRoute,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ADMIN LOGIN PAGE',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 50),
            MyTextFieldWidget(
              controller: emailController,
              text: 'enter your email',
              prefixIcon: null,
            ),
            const SizedBox(height: 25),
            MyTextFieldWidget(
              controller: passwordController,
              text: 'enter your password',
              prefixIcon: null,
            ),
            const SizedBox(height: 50),
            MyButtonWidget(
              text: 'Login',
              onPressed: userLogin,
            ),
            const SizedBox(height: 15),
            const MultiAuthWidget(),
          ],
        ),
      ),
    );
  }
}
