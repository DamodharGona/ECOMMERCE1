import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/admin/service/admin_service.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/widgets/pickimage_preview_widget.dart';
import 'package:ecommerce/src/shared/widgets/select_category_bottomsheet.dart';

class AddEditCategoryOrBrandScreen extends StatefulWidget {
  final bool isBrand;
  const AddEditCategoryOrBrandScreen({super.key, this.isBrand = false});

  @override
  State<AddEditCategoryOrBrandScreen> createState() =>
      _AddEditCategoryOrBrandScreenState();
}

class _AddEditCategoryOrBrandScreenState
    extends State<AddEditCategoryOrBrandScreen> {
  TextEditingController nameController = TextEditingController();
  File? file;
  bool isLoading = false;
  CategoryModel selectedCategory = const CategoryModel();

  void uploadFile() async {
    file = await pickImageFromGallery(context);
    setState(() {});
  }

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

  void uploadImageToCloud() async {
    if (nameController.text.trim().isEmpty || file == null) {
      showSnackBar(context: context, content: 'Please Select Image & Name');
    } else {
      try {
        setState(() => isLoading = true);
        await AdminService.instance.saveToCollection(
          collectionName: widget.isBrand ? 'brands' : 'categories',
          categoryName: nameController.text,
          categoryId: selectedCategory.id,
          file: file!,
          ref:
              '${widget.isBrand ? 'brands/' : 'categories'}/${nameController.text.trim().toLowerCase()}',
        );
        setState(() => isLoading = false);

        if (mounted) {
          showSnackBar(
            context: context,
            content:
                '${widget.isBrand ? 'brand' : 'category'} Created Successfully',
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          showSnackBar(context: context, content: e.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: isLoading ? null : uploadImageToCloud,
            icon: isLoading
                ? const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  )
                : const Icon(Icons.check, size: 30),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name'),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter ${widget.isBrand ? 'Brand' : 'Category'} Name',
                hintStyle: const TextStyle(fontSize: 32),
                contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 32),
              autocorrect: false,
              enableSuggestions: false,
            ),
            Visibility(
              visible: widget.isBrand,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text('Upload Image'),
                  const SizedBox(height: 20),
                  PickimagePreviewWidget(
                    imageUrl: selectedCategory.imageUrl,
                    name: selectedCategory.name,
                    placeholderText: 'Select Category',
                    bottomSheet: openBottomSheet,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: uploadFile,
              child: DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: const [5, 10],
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: file != null
                        ? Image.file(
                            file!,
                            fit: BoxFit.scaleDown,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Click here to Upload Image',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
