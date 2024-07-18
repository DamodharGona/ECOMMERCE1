import 'package:ecommerce/src/core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class PasswordValidationWidget extends StatelessWidget {
  final String password;
  const PasswordValidationWidget({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              password.containsUpperCase
                  ? Icons.check_circle_outline
                  : Icons.close,
              color: password.containsUpperCase ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10),
            const Text('Contains Capital Letter'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              password.containsDigit ? Icons.check_circle_outline : Icons.close,
              color: password.containsDigit ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10),
            const Text('Contains Numeric'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              password.containsSpecialChar
                  ? Icons.check_circle_outline
                  : Icons.close,
              color: password.containsSpecialChar ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10),
            const Text('Contains Special Charecter'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              password.hasMinLengthOf8
                  ? Icons.check_circle_outline
                  : Icons.close,
              color: password.hasMinLengthOf8 ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10),
            const Text('Contains 8 Charecter Length'),
          ],
        ),
      ],
    );
  }
}
