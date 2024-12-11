import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zithara/input_formatter/input_formatter.dart';

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