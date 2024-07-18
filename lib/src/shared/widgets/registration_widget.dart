import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/utils/extensions/string_extensions.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';
import 'package:ecommerce/src/shared/widgets/password_validation_widget.dart';

class RegistrationWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegistrationWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        ValueListenableBuilder(
          valueListenable: passwordController,
          builder: (context, TextEditingValue value, child) {
            return Column(
              children: [
                MyTextFieldWidget(
                  controller: passwordController,
                  text: 'Enter Password',
                  prefixIcon: null,
                  suffixIcon: Visibility(
                    visible: value.text.trim().isNotEmpty,
                    child: const Icon(
                      Icons.check_circle_sharp,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: value.text.trim().isNotEmpty,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: PasswordValidationWidget(
                      password: value.text,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 25),
        ValueListenableBuilder(
          valueListenable: confirmPasswordController,
          builder: (context, TextEditingValue value, child) {
            final passwordMatch = confirmPasswordController.text
                .isEqualTo(passwordController.text);
            return Column(
              children: [
                MyTextFieldWidget(
                  controller: confirmPasswordController,
                  text: 'Enter Confirm Password',
                  prefixIcon: null,
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: value.text.trim().isNotEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        passwordMatch
                            ? Icons.check_circle_outline
                            : Icons.close,
                        color: passwordMatch ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 10),
                      const Text('Password Matched'),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
