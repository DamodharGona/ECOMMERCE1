/// Extension on [String] to provide various validation methods.
extension StringValidation on String {
  /// Validates if the current string is a valid email address.
  ///
  /// The email address must follow the pattern:
  /// - Only alphanumeric characters and dots before the '@' symbol.
  /// - A valid domain name after the '@' symbol.
  bool get isValidEmail {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
    return emailRegExp.hasMatch(this);
  }

  /// Validates if the current string is a valid phone number.
  ///
  /// The phone number must follow the pattern:
  /// - An optional country code (+ or 0) followed by 9.
  /// - Exactly 10 digits.
  bool get isValidPhone {
    final RegExp phoneRegExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }

  /// Validates if the current string is a valid password.
  ///
  /// A valid password must:
  /// - Contain at least one uppercase letter.
  /// - Contain at least one lowercase letter.
  /// - Contain at least one digit.
  /// - Contain at least one special character.
  /// - Be at least 8 characters long.
  bool get isValidPassword {
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegExp.hasMatch(this);
  }

  /// Checks if the current string contains at least one uppercase letter.
  bool get containsUpperCase {
    final RegExp upperCaseRegExp = RegExp(r'(?=.*[A-Z])');
    return upperCaseRegExp.hasMatch(this);
  }

  /// Checks if the current string contains at least one lowercase letter.
  bool get containsLowerCase {
    final RegExp lowerCaseRegExp = RegExp(r'(?=.*[a-z])');
    return lowerCaseRegExp.hasMatch(this);
  }

  /// Checks if the current string contains at least one digit.
  bool get containsDigit {
    final RegExp digitRegExp = RegExp(r'(?=.*\d)');
    return digitRegExp.hasMatch(this);
  }

  /// Checks if the current string contains at least one special character.
  bool get containsSpecialChar {
    final RegExp specialCharRegExp = RegExp(r'(?=.*[@$!%*?&])');
    return specialCharRegExp.hasMatch(this);
  }

  /// Checks if the current string has a minimum length of 8 characters.
  bool get hasMinLengthOf8 {
    final RegExp minLengthRegExp = RegExp(r'.{8,}');
    return minLengthRegExp.hasMatch(this);
  }

  /// Checks if the current string is equal to the provided input.
  ///
  /// This method is case-sensitive.
  bool isEqualTo(String input) {
    return this == input;
  }
}
