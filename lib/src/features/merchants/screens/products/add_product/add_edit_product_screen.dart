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
  /* Common */
  int activeStep = 0;
  bool isLoading = false;

  /* Step 1 */
  CategoryModel selectedCategory = const CategoryModel();
  CategoryModel selectedBrand = const CategoryModel();

  /* Step 2 */
  List<File> productPhotosList = [];
  File? thumbnailFile;

  /* Step 3 */
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final specificationController = TextEditingController();
  final discountPercentController = TextEditingController(text: '0.0');
  bool isOutOfStock = false;
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

  bool get isStep1NextButtonEnabled =>
      selectedBrand.id.isNotEmpty && selectedCategory.id.isNotEmpty;

  bool get isStep1CancelButtonEnabled =>
      selectedBrand.id.isNotEmpty || selectedCategory.id.isNotEmpty;

  bool get isStep2NextButtonEnabled =>
      productPhotosList.isNotEmpty && thumbnailFile != null;

  bool get isStep2CancelButtonEnabled =>
      productPhotosList.isNotEmpty || thumbnailFile != null;

  bool get isStep3NextButtonEnabled =>
      productNameController.text.trim().isNotEmpty &&
      productPriceController.text.trim().isNotEmpty &&
      productDescriptionController.text.trim().isNotEmpty &&
      specificationsList.isNotEmpty &&
      discountPercentController.text.trim().isNotEmpty;

  bool get isStep3CancelButtonEnabled =>
      productNameController.text.trim().isNotEmpty ||
      productPriceController.text.trim().isNotEmpty ||
      productDescriptionController.text.trim().isNotEmpty ||
      specificationsList.isNotEmpty ||
      discountPercentController.text.trim().isNotEmpty;

  void openBottomSheet({bool isBrand = false}) {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1,
      useRootNavigator: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.94,
          child: SelectCategoryBottomsheet(
            onSelect: (category) {
              if (isBrand) {
                selectedBrand = category;
              } else {
                selectedCategory = category;
              }
              setState(() {});
            },
            isBrands: isBrand,
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
    if (isStep3NextButtonEnabled) {
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
          brandId: selectedBrand.id,
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
    if (activeStep == 0) {
      selectedCategory = const CategoryModel();
      selectedBrand = const CategoryModel();
    } else if (activeStep == 1) {
      productPhotosList = [];
      thumbnailFile = null;
    } else {
      productNameController.clear();
      productPriceController.clear();
      productDescriptionController.clear();
      specificationsList.clear();
      specificationController.clear();
      discountPercentController.clear();
      isOutOfStock = false;
    }
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
                  selectedBrand: selectedBrand,
                  openBottomSheet: (isBrand) => openBottomSheet(
                    isBrand: isBrand,
                  ),
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
                  onChanged: (_) =>
                      setState(() => isOutOfStock = !isOutOfStock),
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
          visible: activeStep > 0,
          child: ElevatedButton(
            onPressed: () => setState(() => activeStep--),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(60, 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Prev',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Visibility(
          visible: activeStep == 0
              ? isStep1CancelButtonEnabled
              : activeStep == 1
                  ? isStep2CancelButtonEnabled
                  : activeStep == 2
                      ? isStep3CancelButtonEnabled
                      : false,
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
          onPressed: activeStep == 0 && isStep1NextButtonEnabled
              ? () {
                  if (isStep1NextButtonEnabled && activeStep < 2) {
                    setState(() => activeStep++);
                  }
                }
              : activeStep == 1 && isStep1NextButtonEnabled
                  ? () {
                      if (isStep1NextButtonEnabled && activeStep < 2) {
                        setState(() => activeStep++);
                      }
                    }
                  : activeStep == 2 && isStep1NextButtonEnabled
                      ? uploadProduct
                      : null,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(60, 35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.indigoAccent,
            foregroundColor: Colors.white,
          ),
          child: Text(
            activeStep == 2 ? 'Save' : 'Next',
            style: const TextStyle(fontSize: 18),
          ),
        ).withLoading(true),
        const SizedBox(width: 20),
      ],
    );
  }
}
