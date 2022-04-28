import 'package:fun_number_fact_task/ui/screen/number_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter little app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NumberScreen(),
    );
  }
}

/// commti message