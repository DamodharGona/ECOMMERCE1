import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ecommerce/src/features/merchants/screens/dashboard/merchant_dashboard_screen.dart';
import 'package:ecommerce/src/features/merchants/screens/orders/merchant_orders_screen.dart';
import 'package:ecommerce/src/features/merchants/screens/products/merchant_product_screen.dart';

class MerchantBottomNavbar extends StatefulWidget {
  const MerchantBottomNavbar({Key? key}) : super(key: key);

  @override
  State<MerchantBottomNavbar> createState() => _MerchantBottomNavbarState();
}

class _MerchantBottomNavbarState extends State<MerchantBottomNavbar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    MerchantDashboardScreen(),
    MerchantProductScreen(),
    MerchantOrdersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/action_key.svg',
              width: 26,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? Colors.indigoAccent : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: 'Products',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigoAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
