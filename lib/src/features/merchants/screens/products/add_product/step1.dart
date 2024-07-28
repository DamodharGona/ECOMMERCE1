import 'package:flutter/material.dart';

import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/widgets/pickimage_preview_widget.dart';

class Step1 extends StatelessWidget {
  final CategoryModel selectedCategory;
  final CategoryModel selectedBrand;
  final Function(bool isBrand)? openBottomSheet;

  const Step1({
    super.key,
    required this.selectedCategory,
    required this.selectedBrand,
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
          bottomSheet: () => openBottomSheet?.call(false),
          placeholderText: 'Choose Category',
        ),
        const SizedBox(height: 20),
        const Text('Select Brand', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        PickimagePreviewWidget(
          name: selectedBrand.name,
          imageUrl: selectedBrand.imageUrl,
          bottomSheet: () => openBottomSheet?.call(true),
          placeholderText: 'Choose Brand',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
