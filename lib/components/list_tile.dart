import 'package:flutter/material.dart';

class MListTile extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Function()? onPressed;
  const MListTile({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.grey.shade300,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(title),
        subtitle: Text(price.toString()),
        leading: Image(image: AssetImage(image)),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
