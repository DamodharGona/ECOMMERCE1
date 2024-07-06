import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function()? onTap;
  const MyListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title:Text(title),
        leading: icon,
      ),
    );
  }
}
