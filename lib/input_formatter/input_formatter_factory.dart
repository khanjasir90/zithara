import 'package:flutter/services.dart';
import 'package:zithara/input_formatter/input_formatter.dart';

class InputFormatterFactory {
  static TextInputFormatter getInputFormatter(String formatt) {
    switch(formatt) {
      case 'mm-dd-yyyy':
        return Mmddyyyy(seperator: '-');
      case 'dd-mm-yyyy':
        return Ddmmyyyy(seprator: '-');
      case 'yyyy-mm-dd':
        return Yyyymmdd(seperator: '-');
      case 'yyyy-dd-mm':
        return Yyyyddmm(seperator: '-');
      case 'mm/dd/yyyy':
        return Mmddyyyy(seperator: '/');
      case 'dd/mm/yyyy':
        return Ddmmyyyy(seprator: '/');
      case 'yyyy/mm/dd':
        return Yyyymmdd(seperator: '/');
      case 'yyyy/dd/mm':
        return Yyyyddmm(seperator: '/');
      default:
        return Mmddyyyy(seperator: '-');
    }

  }
}