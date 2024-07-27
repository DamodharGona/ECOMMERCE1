import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFieldWidget extends StatelessWidget {
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool isAddress;
  final bool isNumeric;
  final bool isDecimal;
  final Function(String)? onChanged;
  final int maxLength;
  final TextInputType keyboardType;

  const MyTextFieldWidget({
    super.key,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.isAddress = false,
    this.isNumeric = false,
    this.isDecimal = false,
    this.onChanged,
    this.maxLength = 200,
    this.keyboardType = TextInputType.text,
  });

  List<TextInputFormatter> _getInputFormatters() {
    List<TextInputFormatter> formatters = [];

    if (isNumeric) {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    if (isDecimal) {
      formatters.add(FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')));
    }

    return formatters;
  }

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
          counterText: '',
        ),
        inputFormatters: _getInputFormatters(),
        maxLines: isAddress ? 3 : null,
        maxLength: maxLength,
        onChanged: onChanged,
        keyboardType: keyboardType,
      ),
    );
  }
}
