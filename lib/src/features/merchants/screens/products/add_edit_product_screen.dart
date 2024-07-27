// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:ecommerce/src/core/utils/extensions/my_button_extension.dart';
import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/merchants/screens/products/select_category_bottomsheet.dart';
import 'package:ecommerce/src/features/merchants/service/merchant_service.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({super.key});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  CategoryModel selectedCategory = const CategoryModel();
  List<File> productPhotosList = [];

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
    productPhotosList.add(file!);
    setState(() {});
  }

  void uploadProduct() async {
    if (isButtonEnabled) {
      try {
        setState(() => isLoading = true);
        await MerchantService.instance.uploadProduct(
          ref:
              'products/${productDescriptionController.text.trim().toLowerCase()}',
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
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Select Category', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              _ChooseCategoryWidget(
                category: selectedCategory,
                bottomSheet: openBottomSheet,
              ),
              const SizedBox(height: 20),
              const Text('Product Image', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              UploadPhotos(
                chooseProductImage: chooseProductImage,
                uploadedImages: productPhotosList,
              ),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Name',
                controller: productNameController,
              ),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Price',
                isDecimal: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                controller: productPriceController,
              ),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Description',
                isAddress: true,
                controller: productDescriptionController,
              ),
              const SizedBox(height: 20),
              _SpecificationsInputWidget(
                  specificationController: specificationController,
                  specificationsList: specificationsList,
                  onPressed: () {
                    if (specificationController.text.isNotEmpty) {
                      specificationsList.add(specificationController.text);
                      (context as Element).markNeedsBuild();
                    }
                  },
                  onDismissed: (String specification) {
                    specificationsList.remove(specification);
                    (context as Element).markNeedsBuild();
                  }),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Discount Percent',
                isDecimal: true,
                maxLength: 4,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                controller: discountPercentController,
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Is Out Of Stock',
                  style: TextStyle(fontSize: 20),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: CupertinoSwitch(
                  value: isOutOfStock,
                  activeColor: Colors.indigoAccent,
                  onChanged: (value) =>
                      setState(() => isOutOfStock = !isOutOfStock),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadPhotos extends StatelessWidget {
  final Function()? chooseProductImage;
  final List<File> uploadedImages;

  const UploadPhotos({
    super.key,
    this.chooseProductImage,
    this.uploadedImages = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: uploadedImages.isNotEmpty,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: uploadedImages
                .map((e) => Image.file(
                      e,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: chooseProductImage,
          child: SizedBox(
            height: 40,
            child: DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [5, 10],
              padding: EdgeInsets.zero,
              radius: const Radius.circular(12),
              child: const Center(
                child: Text(
                  'Upload Photo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChooseCategoryWidget extends StatelessWidget {
  final Function()? bottomSheet;
  final CategoryModel category;

  const _ChooseCategoryWidget({
    this.bottomSheet,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: bottomSheet,
      child: SizedBox(
        height: 100,
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [5, 10],
          radius: const Radius.circular(12),
          child: category.id.isNotEmpty
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: category.imageUrl,
                          fit: BoxFit.cover,
                          height: 90,
                          width: 90,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        category.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                    'Choose Category',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
        ),
      ),
    );
  }
}

class _SpecificationsInputWidget extends StatelessWidget {
  final TextEditingController specificationController;
  final List<String> specificationsList;
  final Function()? onPressed;
  final Function(String specification)? onDismissed;

  const _SpecificationsInputWidget({
    required this.specificationController,
    required this.specificationsList,
    this.onPressed,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  controller: specificationController,
                  decoration: InputDecoration(
                    hintText: 'Enter Specifications',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(40, 40),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.add, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...specificationsList.map(
            (item) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    IconButton(
                      onPressed: () => onDismissed?.call(item),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
