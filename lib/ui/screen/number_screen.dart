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
              EntityStateNotifierBuilder<String>(
                  listenableEntityState: wm.factState,
                  loadingBuilder: (_, data) =>
                      const CircularProgressIndicator(),
                  builder: (context, text) => Text(text ?? Strings.errorCheck)),
              const Divider(
                color: Colors.black,
              ),
              const Text(
                Strings.secondTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              EntityStateNotifierBuilder<String>(
                  listenableEntityState: wm.quizState,
                  loadingBuilder: (_, data) =>
                      const CircularProgressIndicator(),
                  builder: (context, text) => Text(text ?? Strings.errorCheck)),
              EntityStateNotifierBuilder<String>(
                listenableEntityState: wm.fishState,
                loadingBuilder: (_, data) => const CircularProgressIndicator(),
                builder: (context, text) => Text(text ?? Strings.errorCheck),
              ),
              const Divider(
                color: Colors.black,
              ),
              EntityStateNotifierBuilder<String>(
                listenableEntityState: wm.launchState,
                loadingBuilder: (_, data) => const CircularProgressIndicator(),
                builder: (context, text) => Text(text ?? Strings.errorCheck),
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: EntityStateNotifierBuilder<String>(
        listenableEntityState: wm.factState,
        loadingBuilder: (_, data) => const _SendRequestButton(
          iconData: Icons.sync_problem,
        ),
        builder: (_, data) => _SendRequestButton(
          onPressed: wm.sendRequest,
          iconData: Icons.add,
        ),
      ),
    );
  }
}

class _SendRequestButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const _SendRequestButton({
    Key? key,
    required this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'send',
      child: Icon(iconData),
    );
  }
}
