import 'package:fun_number_fact_task/ui/screen/number_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.prefs, Key? key}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter little app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider(
          create: (_) => prefs,
          child: const NumberScreen()),
    );
  }
}
