import 'package:flutter/material.dart';
import 'package:zithara/date_screen.dart';
import 'package:zithara/date_validator/date_validator_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Input Formatter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Input Formatter'),
      ),
      body: DateScreen(
        dateValidator: DateValidatorImpl(),
      ),
    );
  }
}