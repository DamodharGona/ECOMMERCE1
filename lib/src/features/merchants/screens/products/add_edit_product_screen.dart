import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/src/features/merchants/screens/products/select_category_bottomsheet.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:flutter/material.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({super.key});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  CategoryModel selectedCategory = const CategoryModel();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: openBottomSheet,
              child: SizedBox(
                height: 100,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: const [5, 10],
                  radius: const Radius.circular(12),
                  child: selectedCategory.id.isNotEmpty
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                  imageUrl: selectedCategory.imageUrl,
                                  fit: BoxFit.cover,
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                selectedCategory.name,
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
            ),
          ],
        ),
      ),
    );
  }
}
