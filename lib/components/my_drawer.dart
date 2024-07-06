import 'package:ecommerce/components/my_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/cart_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage('assets/images/shop.png'),
            ),
            MyListTile(
              title: 'HOME',
              icon: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            MyListTile(
              title: 'CART',
              icon: const Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
            ),
            MyListTile(
              title: 'LOGOUT',
              icon: const Icon(Icons.logout),
              onTap: signOut,
            ),
          ],
        ),
      ),
    );
  }
}
