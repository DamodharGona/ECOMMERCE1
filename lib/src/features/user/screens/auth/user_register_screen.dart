import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/utils/extensions/string_extensions.dart';
import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/shared/service/firebase_auth_service.dart';
import 'package:ecommerce/src/shared/widgets/multi_auth_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_button_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
            'USER REGISTER PAGE',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 50),
          MyTextFieldWidget(
            controller: nameController,
            text: 'Enter Name',
            prefixIcon: null,
          ),
          const SizedBox(height: 25),
          MyTextFieldWidget(
            controller: emailController,
            text: 'Enter Email Address',
            prefixIcon: null,
          ),
          const SizedBox(height: 25),
          MyTextFieldWidget(
            controller: passwordController,
            text: 'Enter Password',
            prefixIcon: null,
          ),
          const SizedBox(height: 25),
          MyTextFieldWidget(
            controller: confirmPasswordController,
            text: 'Enter Confirm Password',
            prefixIcon: null,
          ),
          const SizedBox(height: 50),
          MyButtonWidget(
            text: 'Register',
            onPressed: registerUserScreen,
          ),
          const SizedBox(
            height: 15,
          ),
          const MultiAuthWidget(),
        ],
      ),
    ));
  }

  void registerUserScreen() async {
    if (passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty) {
      if (!passwordController.text.isEqualTo(confirmPasswordController.text)) {
        showSnackBar(
          context: context,
          content: 'Password & Confirm Password do not match',
        );

        return;
      }

      try {
        await FirebaseAuthService.instance.createUserWithEmailAndPassword(
          context: context,
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        if (mounted) {
          showSnackBar(context: context, content: 'User Created Successfully');
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteConstants.userDashboardScreenRoute,
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          showSnackBar(context: context, content: e.toString());
        }
      }
    } else {
      showSnackBar(
        context: context,
        content: 'Required All Fields',
      );
    }
  }
}
