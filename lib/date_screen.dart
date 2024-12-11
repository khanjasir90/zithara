import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zithara/date_validator/date_validator.dart';
import 'package:zithara/input_formatter/input_formatter.dart';
import 'package:zithara/model/date_model.dart';

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

class DateTextField extends StatelessWidget {
  const DateTextField({
    super.key,
    required this.inputFormatter,
    required this.controller,
  });

  final TextInputFormatter inputFormatter;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        enableInteractiveSelection: false,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(
          labelText: 'Date',
          border: OutlineInputBorder(),
        ),
        inputFormatters: [inputFormatter, LengthLimitingTextInputFormatter(10), DateInputFormatter()],
      ),
    );
  }
}


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


class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onValidate,
  });

  final Function onValidate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onValidate(),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: const Text(
          'Validate Date',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
