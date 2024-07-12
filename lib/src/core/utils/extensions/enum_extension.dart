// enum_extensions.dart
extension EnumExtensions<T> on T {
  // Converts an enum value to a string
  String enumToString() {
    return toString().split('.').last;
  }
}

extension StringToEnumExtension on String {
  // Converts a string to an enum value
  T stringToEnum<T>(List<T> enumValues) {
    return enumValues.firstWhere(
      (enumValue) => enumValue.toString().split('.').last == this,
      orElse: () => throw Exception('Invalid enum value: $this'),
    );
  }
}
