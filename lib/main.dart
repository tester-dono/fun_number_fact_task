import 'package:fun_number_fact_task/ui/screen/number_screen.dart';
import 'package:flutter/material.dart';
import 'package:fun_number_fact_task/utils/inherit_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateWithInheritWidget(
      child: MaterialApp(
        title: 'Flutter little app1',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NumberScreen(),
      ),
    );
  }
}
