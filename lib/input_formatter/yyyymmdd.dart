import 'package:flutter/services.dart';

class Yyyymmdd extends TextInputFormatter {
  Yyyymmdd({required this.seperator});

  final String seperator;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove existing separators
    final String rawText = newValue.text.replaceAll(seperator, '');
    final StringBuffer formattedText = StringBuffer();

    // Restrict input to max 8 numeric characters (YYYYDDMM)
    if (rawText.length > 8) {
      return oldValue;
    }

    // Add separator after 4th and 6th characters
    for (int i = 0; i < rawText.length; i++) {
      if (i == 4 || i == 6) {
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
