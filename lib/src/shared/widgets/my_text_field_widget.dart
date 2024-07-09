import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  final String text;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const MyTextFieldWidget({
    super.key,
    required this.text,
    required this.prefixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(width: 1),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          hintText: text,
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
