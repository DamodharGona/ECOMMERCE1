import 'package:ecommerce/src/shared/widgets/multi_auth_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_button_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';
import 'package:ecommerce/src/shared/widgets/or_widget.dart';
import 'package:flutter/material.dart';

class MerchantRegisterScreen extends StatefulWidget {
  const MerchantRegisterScreen({super.key});

  @override
  State<MerchantRegisterScreen> createState() => _MerchantRegisterScreenState();
}

class _MerchantRegisterScreenState extends State<MerchantRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    final storeNameController = TextEditingController();
    final storeAddressController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'MERCHANT REGISTER PAGE',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                const OrWidget(dividerText: 'PERSONAL DETAILS'),
                const SizedBox(height: 30),
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
                const SizedBox(height: 30),
                const OrWidget(dividerText: 'STORE'),
                const SizedBox(height: 30),
                MyTextFieldWidget(
                  controller: storeNameController,
                  text: 'Enter Store Name',
                  prefixIcon: null,
                ),
                const SizedBox(height: 25),
                MyTextFieldWidget(
                  controller: storeAddressController,
                  text: 'Enter Store Address',
                  prefixIcon: null,
                  isAddress: true,
                ),
                const SizedBox(height: 50),
                MyButtonWidget(
                  text: 'Register',
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                const MultiAuthWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
