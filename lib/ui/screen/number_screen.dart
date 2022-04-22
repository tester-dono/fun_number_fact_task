import 'package:elementary/elementary.dart';
import 'package:fun_number_fact_task/res/strings/strings.dart';
import 'package:fun_number_fact_task/ui/screen/number_screen_wm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Main Screen
class NumberScreen extends ElementaryWidget<INumberWidgetModel> {
  const NumberScreen({
    Key? key,
    WidgetModelFactory wmFactory = numberWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(INumberWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // возможно стоило разделить это в виджеты или приватные виджеты
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: wm.controller,
              ),
              DoubleSourceBuilder<String, bool>(
                  firstSource: wm.factState,
                  secondSource: wm.loadingState,
                  builder: (context, text, isLoad) {
                    return isLoad ?? false
                        ? const CircularProgressIndicator()
                        : Text(text ?? Strings.errorCheck);
                  }),
              const Divider(
                color: Colors.black,
              ),
              const Text(
                Strings.secondTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DoubleSourceBuilder<String, bool>(
                  firstSource: wm.quizState,
                  secondSource: wm.loadingState,
                  builder: (context, text, isLoad) {
                    return isLoad ?? false
                        ? const CircularProgressIndicator()
                        : Text(text ?? Strings.errorCheck);
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.sendRequest,
        tooltip: "Send",
        child: const Icon(Icons.search),
      ),
    );
  }
}
