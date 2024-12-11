import 'package:flutter/material.dart';
import 'package:zithara/model/date_model.dart';

class DateDropDownMenu extends StatelessWidget {
  const DateDropDownMenu({
    super.key,
    required this.onDateTypeChanged,
    required this.dateModelList,
    required this.formatt,
  });

  final Function(String dateType) onDateTypeChanged;
  final List<DateModel> dateModelList;
  final String formatt;


  List<DropdownMenuItem<String>> getItems() {
    return dateModelList.map((e) {
      return DropdownMenuItem<String>(
        value: e.dateType,
        child: Text(e.dateType),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: formatt,
      items: getItems(),
      onChanged: (String? value) {
        onDateTypeChanged(value ?? '');
      },
    );
  }
}