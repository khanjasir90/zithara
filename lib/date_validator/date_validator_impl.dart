import 'package:zithara/date_validator/date_validator_interface.dart';

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
