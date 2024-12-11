import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Define the allowed characters: digits, '-' and '/'
    final RegExp allowedCharacters = RegExp(r'^[0-9-/]*$');
    
    // If the new value contains only valid characters, allow the update
    if (allowedCharacters.hasMatch(newValue.text)) {
      return newValue;
    }
    
    // Otherwise, return the old value
    return oldValue;
  }
}