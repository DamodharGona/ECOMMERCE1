import 'package:flutter/material.dart';

import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/widgets/pickimage_preview_widget.dart';

class Step1 extends StatelessWidget {
  final CategoryModel selectedCategory;
  final Function()? openBottomSheet;

  const Step1({
    super.key,
    required this.selectedCategory,
    this.openBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Category', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        PickimagePreviewWidget(
          name: selectedCategory.name,
          imageUrl: selectedCategory.imageUrl,
          bottomSheet: openBottomSheet,
          placeholderText: 'Choose Category',
        ),
        const SizedBox(height: 20),
        const Text('Select Brand', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        PickimagePreviewWidget(
          name: selectedCategory.name,
          imageUrl: selectedCategory.imageUrl,
          bottomSheet: openBottomSheet,
          placeholderText: 'Choose Brand',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
