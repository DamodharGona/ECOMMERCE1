import 'package:ecommerce/src/core/enum/enums.dart';
import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/utils/extensions/enum_extension.dart';
import 'package:ecommerce/src/core/utils/extensions/my_button_extension.dart';
import 'package:ecommerce/src/core/utils/extensions/string_extensions.dart';
import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/merchants/service/merchant_auth_service.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final storeNameController = TextEditingController();
  final storeAddressController = TextEditingController();

  bool isLoading = false;

  void registerMerchant() async {
    if (nameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        storeAddressController.text.trim().isNotEmpty &&
        storeAddressController.text.trim().isNotEmpty) {
      if (!passwordController.text.isValidPassword) {
        showSnackBar(context: context, content: 'Enter Valid Password');
        return;
      }

      if (!confirmPasswordController.text.isValidPassword) {
        showSnackBar(context: context, content: 'Enter Valid Confirm Password');
        return;
      }

      if (passwordController.text.isEqual(confirmPasswordController.text)) {
        try {
          setState(() => isLoading = true);
          await MerchantAuthService.instance.registerMerchant(
            context: context,
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            storeName: storeNameController.text,
            storeAddress: storeAddressController.text,
          );

          AppSharedPrefs.instance.setCurrentUser(
            CurrentUser.MERCHANT.enumToString(),
          );

          if (mounted) {
            showSnackBar(
              context: context,
              content: 'Merchant Created Successfully',
            );
          }

          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteConstants.merchantDashboardScreenRoute,
              (route) => false,
            );
          }
        } catch (e) {
          if (mounted) {
            showSnackBar(context: context, content: e.toString());
          }
        } finally {
          setState(() => isLoading = false);
        }
      } else {
        showSnackBar(context: context, content: 'Password Do Not Match');
        return;
      }
    } else {
      showSnackBar(context: context, content: 'All Fields Are Required');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: registerMerchant,
                ).withLoading(isLoading),
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
