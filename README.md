# Zithara

## Features

1. Display a dropdown menu populated dynamically from JSON data.
2. Automatically select the item where enabled is set to true in the JSON.
3. Provide a text box where users can input dates adhering to the date format selected from the dropdown.
4. Enforce date format and validation rules dynamically based on the selected dropdown item.

### Demo

[Click Here to Watch the Demo of the App](https://drive.google.com/file/d/1bWj39OHcQ6MNaxuBR28lt4P2ZptAylih/view?usp=sharing)

## Approach

1. Created different Date Formatters by extending the TextInputFormatter class that would auto insert '-' OR '/'
    depending upon the format selected.

    - dd-mm-yyyy
    - mm-dd-yyyy
    - yyyy-dd-mm
    - yyyy-mm-dd
    - dd/mm/yyyy
    - mm/dd/yyyy
    - yyyy/dd/mm
    - yyyy/mm/dd

```bash
class Ddmmyyyy extends TextInputFormatter{

  Ddmmyyyy({required this.seprator});

  final String seprator;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove existing separators
    final String rawText = newValue.text.replaceAll(seprator, '');
    final StringBuffer formattedText = StringBuffer();

    // Restrict input to max 8 numeric characters (MMDDYYYY)
    if (rawText.length > 8) {
      return oldValue;
    }

    // Add separator after 2nd and 4th characters
    for (int i = 0; i < rawText.length; i++) {
      if (i == 2 || i == 4) {
        formattedText.write(seprator);
      }
      formattedText.write(rawText[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

```

2. Created an extensible class that would validate the entered date on the following criteria.
 - Validation Rules:
    - Date Validations:
        - Dates cannot be 0 or less.
        - Dates cannot exceed the maximum number of days in the selected month.
        - January: Maximum 31 days.
        - February:
        - Leap Year: Maximum 29 days.
        - Non-Leap Year: Maximum 28 days.
        - April, June, September, November: Maximum 30 days.

    - Month Validations:
        - Months cannot be 0 or less.
        - Months cannot exceed 12.
    - Year Validations:
        - Years cannot exceed the current year.
        - Input Restrictions:
        - Users can only enter numeric values.
        - Non-numeric characters should not be allowed.

```bash
abstract class DateValidator {
  String? validateDate(String date, String format);
}
```

```bash
class DateValidatorImpl extends DateValidator {
  @override
  String? validateDate(String date, String format) {
    try {
      final separator = format.contains('-') ? '-' : '/';
      final parts = date.split(separator);

      int year, month, day;

      switch (format) {
        case 'mm-dd-yyyy':
          month = int.parse(parts[0]);
          day = int.parse(parts[1]);
          year = int.parse(parts[2]);
          break;
        case 'dd-mm-yyyy':
          day = int.parse(parts[0]);
          month = int.parse(parts[1]);
          year = int.parse(parts[2]);
          break;
        case 'yyyy-mm-dd':
          year = int.parse(parts[0]);
          month = int.parse(parts[1]);
          day = int.parse(parts[2]);
          break;
        case 'yyyy-dd-mm':
          year = int.parse(parts[0]);
          day = int.parse(parts[1]);
          month = int.parse(parts[2]);
          break;
        case 'mm/dd/yyyy':
          month = int.parse(parts[0]);
          day = int.parse(parts[1]);
          year = int.parse(parts[2]);
          break;
        case 'dd/mm/yyyy':
          day = int.parse(parts[0]);
          month = int.parse(parts[1]);
          year = int.parse(parts[2]);
          break;
        case 'yyyy/mm/dd':
          year = int.parse(parts[0]);
          month = int.parse(parts[1]);
          day = int.parse(parts[2]);
          break;
        case 'yyyy/dd/mm':
          year = int.parse(parts[0]);
          day = int.parse(parts[1]);
          month = int.parse(parts[2]);
          break;
        default:
          return 'Invalid date format';
      }

      // Validate year
      final currentYear = DateTime.now().year;
      if (year > currentYear) return 'Invalid year';

      // Validate month
      if (month < 1 || month > 12) return 'Invalid Month';

      // Validate day based on month and year
      final daysInMonth = DateTime(year, month + 1, 0).day;
      if (day < 1 || day > daysInMonth) return 'Invalid Day';

      return null;
    } catch (e) {
      // Return false if parsing fails
      return 'Invalid date format';
    }
  }
}

```

    