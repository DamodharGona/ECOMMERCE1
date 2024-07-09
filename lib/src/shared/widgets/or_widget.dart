import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  final String dividerText;

  const OrWidget({
    super.key,
    required this.dividerText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDividerUI(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            dividerText,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
        _buildDividerUI(),
      ],
    );
  }

  Expanded _buildDividerUI() {
    return const Expanded(
      child: Divider(
        color: Colors.grey,
        height: 2,
      ),
    );
  }
}
