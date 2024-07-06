import 'package:ecommerce/components/category_container.dart';
import 'package:ecommerce/pages/detail_page.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:flutter/material.dart';

class ShoePage extends StatelessWidget {
  const ShoePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> _images = [
      'assets/images/shoe.png',
      'assets/images/shoe2.png',
      'assets/images/shoe3.png',
      'assets/images/shoe4.png',
    ];
    List<String> shoeNames = [
      'Leather Loafers',
      'Sneakers',
      'Chelsea Boots',
      'Running Shoes',
    ];
    List<String> shoePrices = [
      '\$89.99',
      '\$79.99',
      '\$99.99',
      '\$69.99',
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Shoe Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      names: shoeNames[index],
                      prices: shoePrices[index],
                      image: _images[index],
                    ),
                  ),
                );
              },
              child: CategoryPage(
                name: shoeNames[index],
                price: shoePrices[index],
                image: _images[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
