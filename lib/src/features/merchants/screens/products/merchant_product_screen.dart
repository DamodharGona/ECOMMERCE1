import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:flutter/material.dart';

class MerchantProductScreen extends StatefulWidget {
  const MerchantProductScreen({super.key});

  @override
  State<MerchantProductScreen> createState() => _MerchantProductScreenState();
}

class _MerchantProductScreenState extends State<MerchantProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [],
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
