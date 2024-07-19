import 'package:ecommerce/src/shared/widgets/log_out_widget.dart';
import 'package:flutter/material.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          LogOutWidget(),
        ],
      ),
    );
  }
}
