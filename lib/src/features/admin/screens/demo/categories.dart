import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/admin/service/admin_service.dart';
import 'package:ecommerce/src/shared/model/brand_model.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';

class DemoCategoryScreen extends StatefulWidget {
  const DemoCategoryScreen({super.key});

  @override
  State<DemoCategoryScreen> createState() => _DemoCategoryScreenState();
}

class _DemoCategoryScreenState extends State<DemoCategoryScreen> {
  List<CategoryModel> categories = [];
  List<BrandModel> brandsCopy = [];
  List<BrandModel> brands = [];

  String selectedCatId = '';

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    try {
      categories = await AdminService.instance.fetchDemoCategoiesData();

      brands = await AdminService.instance.fetchDemoBrandsData();
      brandsCopy = brands;

      updateSelectedCat(0);
      setState(() {});
    } catch (e) {
      if (mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }

  void updateSelectedCat(int index) {
    print("index: $index");
    selectedCatId = categories[index].id;
    brands = brandsCopy
        .where((brand) => brand.categoryIds.contains(selectedCatId))
        .toList();

    print("brands: ${brands.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final category = categories[index];

                return ListTile(
                  onTap: () => updateSelectedCat(index),
                  leading:
                      Image.network(category.imageUrl, width: 50, height: 50),
                  title: Text(category.name),
                );
              },
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2.5,
              ),
              itemBuilder: (context, index) {
                final category = brands[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(category.imageUrl, width: 80, height: 80),
                    Flexible(
                      child:
                          Text(category.name, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
