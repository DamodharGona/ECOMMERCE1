import 'package:ecommerce/components/category_container.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'home_page.dart';

class TShirtPage extends StatelessWidget {
  const TShirtPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> _images = [
      'assets/images/tsht1.png',
      'assets/images/Tshirt1.png',
      'assets/images/tshirt2.png',
      'assets/images/tshirt3.png',
    ];
    List<String> tshirtPrices = [
      '\$19.99',
      '\$24.99',
      '\$14.99',
      '\$9.99',
    ];
    List<String> tshirtNames = [
      'Graphic Tee',
      'V-Neck T-Shirt',
      'Long Sleeve Tee',
      'Basic Cotton Tee',
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
        title: const Text('T-shirts'),
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
                      names: tshirtNames[index],
                      prices: tshirtPrices[index],
                      image: _images[index],
                    ),
                  ),
                );
              },
              child: CategoryPage(
                name: tshirtNames[index],
                price: tshirtPrices[index],
                image: _images[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
