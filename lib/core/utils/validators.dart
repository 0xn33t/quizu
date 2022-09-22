class Validators {
  static final RegExp _number = RegExp(r'[0-9]');

  static bool isEmpty(String? value) => value == null || value.isEmpty;

  static bool isNumeric(String? value) =>
      value != null && _number.hasMatch(value.toLowerCase());
}
