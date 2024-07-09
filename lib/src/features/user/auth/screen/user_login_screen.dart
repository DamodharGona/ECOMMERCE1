import 'package:ecommerce/src/shared/widgets/multi_auth_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_button_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';
import 'package:flutter/material.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void userLogin() {}

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
            ),
            const SizedBox(height: 15),
            const MultiAuthWidget(),
          ],
        ),
      ),
    );
  }
}
