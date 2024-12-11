import 'package:flutter/services.dart';

class Mmddyyyy extends TextInputFormatter {

  Mmddyyyy({required this.seperator});

  final String seperator;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove existing separators
    final String rawText = newValue.text.replaceAll(seperator, '');
    final StringBuffer formattedText = StringBuffer();

    // Restrict input to max 8 numeric characters (MMDDYYYY)
    if (rawText.length > 8) {
      return oldValue;
    }

    // Add separator after 2nd and 4th characters
    for (int i = 0; i < rawText.length; i++) {
      if (i == 2 || i == 4) {
        formattedText.write(seperator);
      }
      formattedText.write(rawText[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

}