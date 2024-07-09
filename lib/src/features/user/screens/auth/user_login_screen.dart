import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/utils/extensions/my_button_extension.dart';
import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/shared/service/firebase_auth_service.dart';
import 'package:ecommerce/src/shared/widgets/multi_auth_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_button_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void userLogin() async {
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      try {
        setState(() => isLoading = true);

        await FirebaseAuthService.instance.signInWithEmailAndPassword(
          context: context,
          email: emailController.text,
          password: passwordController.text,
        );

        setState(() => isLoading = false);

        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteConstants.userDashboardScreenRoute,
            (route) => false,
          );
        }
      } catch (e) {
        setState(() => isLoading = false);
        if (mounted) {
          showSnackBar(context: context, content: e.toString());
        }
      }
    } else {
      showSnackBar(context: context, content: 'Required All Fields');
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
              'USER LOGIN PAGE',
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
            ).withLoading(isLoading),
            const SizedBox(height: 15),
            const MultiAuthWidget(),
          ],
        ),
      ),
    );
  }
}
