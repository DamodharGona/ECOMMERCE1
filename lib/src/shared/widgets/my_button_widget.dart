import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const MyButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, padding: const EdgeInsets.all(15)),
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
