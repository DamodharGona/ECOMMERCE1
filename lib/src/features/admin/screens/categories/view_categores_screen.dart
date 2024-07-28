import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:ecommerce/src/shared/service/common_service.dart';

class ViewCategoresScreen extends StatefulWidget {
  final bool isBrand;
  final Function()? callBack;

  const ViewCategoresScreen({
    super.key,
    this.callBack,
    this.isBrand = false,
  });

  @override
  State<ViewCategoresScreen> createState() => _ViewCategoresScreenState();
}

class _ViewCategoresScreenState extends State<ViewCategoresScreen> {
  List<CategoryModel> categoriesList = [];
  bool isLoading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    categoriesList = await CommonService.instance.fetchAllCategoriesOrBrands(
      widget.isBrand,
    );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isBrand ? 'Brands' : 'Categories'),
        actions: [
          const SizedBox(width: 20),
          IconButton(
            onPressed: () async => fetchData(),
            icon: const Icon(Icons.refresh, size: 30),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 2,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 16,
                          width: 80,
                          color: Colors.grey[300],
                        ),
                      ],
                    );
                  },
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoriesList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2 / 2,
                ),
                itemBuilder: (context, index) {
                  final category = categoriesList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: category.imageUrl,
                          height: 75,
                          width: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
