import 'package:flutter/services.dart';

class PhoneLengthLimitingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // If the input starts with '0', limit the length to 10 characters
    if (newText.startsWith('0') && newText.length > 10) {
      return oldValue;
    }

    // If the input starts with '+213', limit the length to 13 characters
    if (newText.startsWith('+213') && newText.length > 13) {
      return oldValue;
    }

    return newValue;
  }
}
