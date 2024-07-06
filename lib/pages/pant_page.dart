import 'package:ecommerce/components/category_container.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'home_page.dart';

class PantPage extends StatelessWidget {
  const PantPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> _images = [
      'assets/images/jeans1.png',
      'assets/images/pant1.png',
      'assets/images/pant2.png',
      'assets/images/pant3.png',
    ];
    List<String> pantNames = [
      'Chino Pants',
      'Slim Fit Jeans',
      'Cargo Trousers',
      'Tailored Dress Pants',
    ];
    List<String> pantPrices = [
      '\$59.99',
      '\$69.99',
      '\$49.99',
      '\$79.99',
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text('Pants'),
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
                      names: pantNames[index],
                      prices: pantPrices[index],
                      image: _images[index],
                    ),
                  ),
                );
              },
              child: CategoryPage(
                name: pantNames[index],
                price: pantPrices[index],
                image: _images[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
