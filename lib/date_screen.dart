import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zithara/date_validator/date_validator.dart';
import 'package:zithara/input_formatter/input_formatter.dart';
import 'package:zithara/model/date_model.dart';
import 'package:zithara/widgets/widgets.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({
    super.key,
    required this.dateValidator,
  });


  final DateValidator dateValidator;

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {

  late TextInputFormatter inputFormatter;
  late String formatt = 'dd-mm-yyyy';
  late List<DateModel> dateModelList;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    _getEnabledDateFormat();
    inputFormatter = InputFormatterFactory.getInputFormatter('dd-mm-yyyy');
    super.initState();
  }

  void _getEnabledDateFormat() {
   dateModelList = DateModel.getDateModelList();  
   formatt = dateModelList.where((element) => element.enabled).first.dateType;
  }

  void _onDateTypeChanged(String value) {
    setState(() {
      formatt = value;
      _date = '';
      inputFormatter = InputFormatterFactory.getInputFormatter(value);
    });
  }

  set _date(String date) => controller.text = date;

  String get _date => controller.text;


  void _onValidate() {
    final String? result = widget.dateValidator.validateDate(_date, formatt);

    if(result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Date is valid'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DateDropDownMenu(
          onDateTypeChanged: _onDateTypeChanged,
          dateModelList: dateModelList,
          formatt: formatt,
        ),
        const SizedBox(height: 20,),
        DateTextField(inputFormatter: inputFormatter, controller: controller),
        const SizedBox(height: 20,),
        SubmitButton(onValidate: _onValidate),
      ],
    );
  }
}