import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool isAddress;
  final Function(String)? onChanged;

  const MyTextFieldWidget({
    super.key,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.isAddress = false,
    this.onChanged,
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
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 12, 8),
          prefixIcon: prefixIcon,
          hintText: text,
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          suffixIcon: suffixIcon,
        ),
        maxLines: isAddress ? 3 : null,
        onChanged: onChanged,
      ),
    );
  }
}
