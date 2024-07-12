import 'package:ecommerce/src/features/admin/service/admin_service.dart';
import 'package:ecommerce/src/shared/model/category_model.dart';
import 'package:flutter/material.dart';

class ViewCategoresScreen extends StatefulWidget {
  const ViewCategoresScreen({super.key});

  @override
  State<ViewCategoresScreen> createState() => _ViewCategoresScreenState();
}

class _ViewCategoresScreenState extends State<ViewCategoresScreen> {
  List<CategoryModel> categoriesList = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    categoriesList = await AdminService.instance.fetchAllCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
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
        child: GridView.builder(
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
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(category.imageUrl),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
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
