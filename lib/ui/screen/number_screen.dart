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
              children: [
                StateNotifierBuilder<String>(
                  listenableState: wm.titleState,
                  builder: (ctx, value) {
                    return Text(value ?? Strings.errorCheck);
                  },
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: wm.controller,
                      ),
                      EntityStateNotifierBuilder<String>(
                          listenableEntityState: wm.factState,
                          loadingBuilder: (_, data) {
                            return const CircularProgressIndicator();
                          },
                          builder: (context, text) {
                            return Text(text ?? Strings.errorCheck);
                          }),
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
                          loadingBuilder: (_, data) {
                            return const CircularProgressIndicator();
                          },
                          builder: (context, text) {
                            return Text(text ?? Strings.errorCheck);
                          }),
                      EntityStateNotifierBuilder<String>(
                          listenableEntityState: wm.fishState,
                          loadingBuilder: (_, data) {
                            return const CircularProgressIndicator();
                          },
                          builder: (context, text) {
                            return Text(text ?? Strings.errorCheck);
                          }),
                      const Divider(
                        color: Colors.black,
                      ),
                      EntityStateNotifierBuilder<String>(
                          listenableEntityState: wm.launchState,
                          loadingBuilder: (_, data) {
                            return const CircularProgressIndicator();
                          },
                          builder: (context, text) {
                            return Text(text ?? Strings.errorCheck);
                          }),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StateNotifierBuilder<String>(
                listenableState: wm.genderState,
                builder: (ctx, value) {
                  return _FloatingNumberScreenButton(
                    onPressed: wm.changeSex,
                    iconData: value! == "female" ? Icons.woman : Icons.man,
                  );
                },
              ),
              StateNotifierBuilder<String>(
                listenableState: wm.pluralState,
                builder: (ctx, value) {
                  return _FloatingNumberScreenButton(
                    onPressed: wm.changeAmount,
                    iconData: value! == "two" ? Icons.person : Icons.people,
                  );
                },
              ),
              EntityStateNotifierBuilder<String>(
                listenableEntityState: wm.factState,
                loadingBuilder: (_, data) {
                  return const _FloatingNumberScreenButton(
                    iconData: Icons.sync_problem,
                  );
                },
                builder: (_, data) {
                  return _FloatingNumberScreenButton(
                    onPressed: wm.sendRequest,
                    iconData: Icons.add,
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class _FloatingNumberScreenButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const _FloatingNumberScreenButton({
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
