import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/admin/service/admin_service.dart';
import 'package:flutter/material.dart';

class AddEditCategoryScreen extends StatefulWidget {
  const AddEditCategoryScreen({super.key});

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  File? file;
  bool isLoading = false;

  void uploadFile() async {
    file = await pickImageFromGallery(context);
    setState(() {});
  }

  void uploadImageToCloud() async {
    if (nameController.text.trim().isEmpty || file == null) {
      showSnackBar(context: context, content: 'Please Select Image & Name');
    } else {
      try {
        setState(() => isLoading = true);
        await AdminService.instance.saveToCollection(
          collectionName: 'categories',
          categoryName: nameController.text,
          file: file!,
          ref: 'categories/${nameController.text.trim().toLowerCase()}',
        );
        setState(() => isLoading = false);

        if (mounted) {
          showSnackBar(
            context: context,
            content: 'Category Created Successfully',
          );
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
              decoration: const InputDecoration(
                hintText: 'Enter Category Name',
                hintStyle: TextStyle(fontSize: 32),
                contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 32),
              autocorrect: false,
              enableSuggestions: false,
            ),
            const Text('Upload Image'),
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
