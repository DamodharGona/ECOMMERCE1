import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:ecommerce/src/shared/model/product_model.dart';

class ViewProductScreen extends StatelessWidget {
  final ProductModel product;
  const ViewProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Carousel */
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 2,
                aspectRatio: 2.0,
                scrollDirection: Axis.horizontal,
              ),
              items: product.imageUrls.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: CachedNetworkImage(
                        imageUrl: i,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            /* Product Name */
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(fontSize: 20),
            ),
            /* Product Brand */
            /* Product Price & Description */
            /* Product Specifications */
          ],
        ),
      ),
    );
  }
}
