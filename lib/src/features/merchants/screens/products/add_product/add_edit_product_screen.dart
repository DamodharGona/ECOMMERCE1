import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/utils/extensions/my_button_extension.dart';
import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/merchants/screens/products/add_product/product_stage_stepper.dart';
import 'package:ecommerce/src/features/merchants/screens/products/add_product/step1.dart';
import 'package:ecommerce/src/features/merchants/screens/products/add_product/step2.dart';
import 'package:ecommerce/src/features/merchants/screens/products/add_product/step3.dart';
import 'package:ecommerce/src/features/merchants/service/merchant_service.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/service/firebase_auth_service.dart';
import 'package:ecommerce/src/shared/widgets/select_category_bottomsheet.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({super.key});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  CategoryModel selectedCategory = const CategoryModel();
  List<File> productPhotosList = [];
  File? thumbnailFile;

  int activeStep = 1;

  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final specificationController = TextEditingController();
  final discountPercentController = TextEditingController();

  bool isOutOfStock = false;
  bool isLoading = false;

  List<String> specificationsList = [];

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers
    productNameController.addListener(_updateState);
    productPriceController.addListener(_updateState);
    productDescriptionController.addListener(_updateState);
    discountPercentController.addListener(_updateState);
  }

  @override
  void dispose() {
    // Remove the listeners when the widget is disposed
    productNameController.removeListener(_updateState);
    productPriceController.removeListener(_updateState);
    productDescriptionController.removeListener(_updateState);
    discountPercentController.removeListener(_updateState);

    // Dispose of the controllers
    productNameController.dispose();
    productPriceController.dispose();
    productDescriptionController.dispose();
    specificationController.dispose();
    discountPercentController.dispose();

    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  bool get isButtonEnabled =>
      productNameController.text.trim().isNotEmpty &&
      productPriceController.text.trim().isNotEmpty &&
      productDescriptionController.text.trim().isNotEmpty &&
      specificationsList.isNotEmpty &&
      discountPercentController.text.trim().isNotEmpty &&
      productPhotosList.isNotEmpty &&
      selectedCategory.id.isNotEmpty;

  bool get isCancelButtonEnabled =>
      productNameController.text.trim().isNotEmpty ||
      productPriceController.text.trim().isNotEmpty ||
      productDescriptionController.text.trim().isNotEmpty ||
      specificationsList.isNotEmpty ||
      discountPercentController.text.trim().isNotEmpty ||
      productPhotosList.isNotEmpty ||
      selectedCategory.id.isNotEmpty;

  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1,
      useRootNavigator: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.94,
          child: SelectCategoryBottomsheet(
            onSelect: (category) => setState(() => selectedCategory = category),
          ),
        );
      },
    );
  }

  Future<void> chooseProductImage() async {
    File? file = await pickImageFromGallery(context);
    if (file != null) {
      productPhotosList.add(file);
      setState(() {});
    }
  }

  Future<void> chooseThumbnailImage() async {
    thumbnailFile = await pickImageFromGallery(context);
    setState(() {});
  }

  void uploadProduct() async {
    if (isButtonEnabled) {
      try {
        setState(() => isLoading = true);
        await MerchantService.instance.uploadProduct(
          ref:
              'products/${FirebaseAuthService.instance.currentUser!.uid}/${productNameController.text.trim().toLowerCase()}',
          productImages: productPhotosList,
          name: productNameController.text,
          price: double.parse(productPriceController.text),
          description: productDescriptionController.text,
          specifications: specificationsList,
          discountPercent: double.parse(discountPercentController.text),
          isOutOfStock: isOutOfStock,
          categoryId: selectedCategory.id,
        );

        if (mounted) {
          showSnackBar(
            context: context,
            content: 'Product Uploaded Successfully',
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          showSnackBar(context: context, content: 'Error: ${e.toString()}');
        }
      } finally {
        setState(() => isLoading = false);
      }
    } else {
      showSnackBar(context: context, content: 'All Fields Are Required');
    }
  }

  void clearAll() {
    productNameController.clear();
    productPriceController.clear();
    productDescriptionController.clear();
    specificationsList.clear();
    specificationController.clear();
    discountPercentController.clear();
    productPhotosList = [];
    selectedCategory = const CategoryModel();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: ProductStageStepper(activeStep: activeStep),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: activeStep == 0,
                child: Step1(
                  selectedCategory: selectedCategory,
                  openBottomSheet: openBottomSheet,
                ),
              ),
              Visibility(
                visible: activeStep == 1,
                child: Step2(
                  productPhotosList: productPhotosList,
                  thumbnailFile: thumbnailFile,
                  chooseProductImage: chooseProductImage,
                  chooseThumbnailImage: chooseThumbnailImage,
                ),
              ),
              Visibility(
                visible: activeStep == 2,
                child: Step3(
                  productNameController: productNameController,
                  productPriceController: productPriceController,
                  productDescriptionController: productDescriptionController,
                  specificationController: specificationController,
                  discountPercentController: discountPercentController,
                  specificationsList: specificationsList,
                  isOutOfStock: isOutOfStock,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      actions: [
        Visibility(
          visible: isCancelButtonEnabled,
          child: ElevatedButton(
            onPressed: clearAll,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(60, 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Clear',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: !isButtonEnabled ? null : uploadProduct,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(60, 35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.indigoAccent,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 18),
          ),
        ).withLoading(isLoading),
        const SizedBox(width: 20),
      ],
    );
  }
}
