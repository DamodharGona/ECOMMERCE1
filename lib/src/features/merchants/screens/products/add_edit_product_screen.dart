import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/merchants/screens/products/select_category_bottomsheet.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/widgets/my_text_field_widget.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({super.key});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  CategoryModel selectedCategory = const CategoryModel();
  File? productPhotoFile;

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
    productPhotoFile = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: selectedCategory.id.isNotEmpty,
            child: ElevatedButton(
              onPressed: () {
                selectedCategory = const CategoryModel();
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(80, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.indigoAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Clear',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
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
              GestureDetector(
                onTap: chooseProductImage,
                child: SizedBox(
                  height: 300,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: const [5, 10],
                    radius: const Radius.circular(12),
                    child: productPhotoFile != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              productPhotoFile!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Text(
                              'Upload Photo',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Name',
                controller: TextEditingController(),
              ),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Price',
                controller: TextEditingController(),
              ),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Description',
                isAddress: true,
                controller: TextEditingController(),
              ),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Specification',
                isAddress: true,
                controller: TextEditingController(),
              ),
              const SizedBox(height: 20),
              MyTextFieldWidget(
                text: 'Discount Percent',
                controller: TextEditingController(),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Is Out Of Stock'),
                contentPadding: EdgeInsets.zero,
                trailing: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
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
              : const SizedBox(
                  height: 120,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose Category',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
