import 'package:ecommerce/components/list_tile.dart';
import 'package:ecommerce/model/cart_provider_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: const Text('Cart page'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.cartItems.length,
            itemBuilder: (context, index) {
              return MListTile(
                title: 'Name',
                price: 20,
                image: value.cartItems[index],
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .removeCartItem(value.cartItems[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
