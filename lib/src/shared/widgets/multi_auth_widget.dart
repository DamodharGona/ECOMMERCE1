import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:flutter/material.dart';

class MultiAuthWidget extends StatelessWidget {
  const MultiAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login -'),
            TextButton(
              onPressed: () => navigateTo(
                context,
                RouteConstants.adminLoginScreenRoute,
              ),
              child: const Text('Admin'),
            ),
            const Text('|'),
            TextButton(
              onPressed: () => navigateTo(
                context,
                RouteConstants.userLoginScreenRoute,
              ),
              child: const Text('User'),
            ),
            const Text('|'),
            TextButton(
              onPressed: () => navigateTo(
                context,
                RouteConstants.merchantLoginScreenRoute,
              ),
              child: const Text('Merchant'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Register -'),
            TextButton(
              onPressed: () {},
              child: const Text('Admin'),
            ),
            const Text('|'),
            TextButton(
              onPressed: () {},
              child: const Text('User'),
            ),
            const Text('|'),
            TextButton(
              onPressed: () {},
              child: const Text('Merchant'),
            ),
          ],
        ),
      ],
    );
  }

  void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }
}
