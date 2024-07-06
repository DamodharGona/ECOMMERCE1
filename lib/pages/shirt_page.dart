import 'package:ecommerce/components/category_container.dart';
import 'package:ecommerce/pages/detail_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class ShirtPage extends StatelessWidget {
  const ShirtPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> _images = [
      'assets/images/shirt.png',
      'assets/images/sht1.png',
      'assets/images/sht2.png',
      'assets/images/sht3.png',
    ];
    List<String> shirtNames = [
      'Classic Oxford Shirt',
      'Striped Button-Up',
      'Slim Fit Polo',
      'Denim Shirt',
    ];
    List<String> shirtPrices = [
      '\$39.99',
      '\$49.99',
      '\$29.99',
      '\$34.99',
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
        title: const Text('shirts'),
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
                      names: shirtNames[index],
                      prices: shirtPrices[index],
                      image: _images[index],
                    ),
                  ),
                );
              },
              child: CategoryPage(
                name: shirtNames[index],
                price: shirtPrices[index],
                image: _images[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
