import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:ecommerce/src/features/merchants/service/merchant_service.dart';
import 'package:ecommerce/src/shared/model/product_model.dart';

class MerchantProductScreen extends StatefulWidget {
  const MerchantProductScreen({super.key});

  @override
  State<MerchantProductScreen> createState() => _MerchantProductScreenState();
}

class _MerchantProductScreenState extends State<MerchantProductScreen> {
  List<ProductModel> productsList = [];
  List<ProductModel> productsListCopy = [];
  String _selectedFilter = 'Active';

  @override
  void initState() {
    fetchMerchantProducts();
    super.initState();
  }

  Future<void> fetchMerchantProducts() async {
    try {
      productsList =
          await MerchantService.instance.fetchCurrentMerchantProducts();
      productsListCopy =
          productsList.where((item) => !item.isOutOfStock).toList();
      setState(() {});
    } catch (e) {
      if (mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }

  void toggleFilter(String selectedItem) {
    productsListCopy = productsList
        .where((item) =>
            selectedItem == 'Active' ? !item.isOutOfStock : item.isOutOfStock)
        .toList();
    _selectedFilter = selectedItem;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        centerTitle: false,
        titleSpacing: 25,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: ['Active', 'Out Of Stock']
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: FilterChip(
                            label: Text(item),
                            selected: _selectedFilter == item,
                            backgroundColor: Colors.white,
                            selectedColor: Colors.indigoAccent,
                            checkmarkColor: _selectedFilter == item
                                ? Colors.white
                                : Colors.black,
                            labelStyle: TextStyle(
                              color: _selectedFilter == item
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onSelected: (_) => toggleFilter(item),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: productsListCopy.length,
                itemBuilder: (context, index) {
                  final product = productsListCopy[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.network(
                      product.imageUrls.first,
                      width: 60,
                    ),
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: Text(
                      product.price.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        onPressed: () => Navigator.pushNamed(
          context,
          RouteConstants.addEditProductScreenRoute,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
