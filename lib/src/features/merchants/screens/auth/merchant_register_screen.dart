import 'package:ecommerce/src/shared/model/merchant_model.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/enum/enums.dart';
import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/utils/extensions/enum_extension.dart';
import 'package:ecommerce/src/core/utils/extensions/my_button_extension.dart';
import 'package:ecommerce/src/core/utils/extensions/string_extensions.dart';
import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/merchants/service/merchant_auth_service.dart';
import 'package:ecommerce/src/shared/model/dropdown_model.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:ecommerce/src/shared/service/common_service.dart';
import 'package:ecommerce/src/shared/widgets/dropdown_button_widget.dart';
import 'package:ecommerce/src/shared/widgets/multi_auth_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_button_widget.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';
import 'package:ecommerce/src/shared/widgets/or_widget.dart';
import 'package:ecommerce/src/shared/widgets/registration_widget.dart';

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
  final storeAddress1Controller = TextEditingController();
  final storeAddress2Controller = TextEditingController();
  final storeAddress3Controller = TextEditingController();
  final storePinCodeController = TextEditingController();
  final storeCityOrTownController = TextEditingController();
  final storeStateController = TextEditingController();

  bool isLoading = false;
  bool isValidPassword = false;

  DropdownModel? _selectedState;

  List<DropdownModel> states = [];

  @override
  void initState() {
    fetchStatesData();
    super.initState();
  }

  Future<void> fetchStatesData() async {
    states = await CommonService.instance.fetchAllStates();
    setState(() {});
  }

  void registerMerchant() async {
    if (nameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        storeNameController.text.trim().isNotEmpty &&
        storeAddress1Controller.text.trim().isNotEmpty &&
        storePinCodeController.text.trim().isNotEmpty &&
        storeCityOrTownController.text.trim().isNotEmpty &&
        _selectedState != null) {
      if (!passwordController.text.isValidPassword) {
        showSnackBar(context: context, content: 'Enter Valid Password');
        return;
      }

      if (!confirmPasswordController.text.isValidPassword) {
        showSnackBar(context: context, content: 'Enter Valid Confirm Password');
        return;
      }

      if (passwordController.text.isEqualTo(confirmPasswordController.text)) {
        try {
          setState(() => isLoading = true);
          Store store = Store(
            name: storeNameController.text,
            address1: storeAddress1Controller.text,
            address2: storeAddress2Controller.text,
            address3: storeAddress3Controller.text,
            pinCode: int.parse(storePinCodeController.text),
            stateId: _selectedState!.id,
            townOrCity: storeCityOrTownController.text,
          );

          await MerchantAuthService.instance.registerMerchant(
            context: context,
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            storeName: storeNameController.text,
            storeAddress: storeAddress1Controller.text,
            storeData: store,
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
              RouteConstants.merchantBottomNavBarScreenRoute,
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
                RegistrationWidget(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
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
                  controller: storeAddress1Controller,
                  text: 'Flat, House no.., Building, Company, Appartment',
                  prefixIcon: null,
                ),
                const SizedBox(height: 25),
                MyTextFieldWidget(
                  controller: storeAddress2Controller,
                  text: 'Area, Street, Sector, Village (Optional)',
                  prefixIcon: null,
                ),
                const SizedBox(height: 25),
                MyTextFieldWidget(
                  controller: storeAddress3Controller,
                  text: 'Landmark (Optional)',
                  prefixIcon: null,
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFieldWidget(
                        controller: storePinCodeController,
                        text: 'PinCode',
                        prefixIcon: null,
                      ),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: MyTextFieldWidget(
                        controller: storeCityOrTownController,
                        text: 'Town/City',
                        prefixIcon: null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                DropdownButtonWidget(
                  hintText: 'State',
                  selectedState: _selectedState,
                  dropdownList: states,
                  onChanged: (DropdownModel? value) {
                    _selectedState = value;
                    setState(() {});
                  },
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
