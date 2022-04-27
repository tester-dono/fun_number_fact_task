import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:fun_number_fact_task/domain/server_answer.dart';
import 'package:fun_number_fact_task/res/strings/strings.dart';
import 'package:fun_number_fact_task/ui/screen/number_screen.dart';
import 'package:fun_number_fact_task/ui/screen/number_screen_model.dart';
import 'package:flutter/material.dart';

/// Builder for [NumberWidgetModel]
NumberWidgetModel numberWidgetModelFactory(BuildContext context) {
  return NumberWidgetModel(NumberModel());
}

/// WidgetModel for [NumberScreen]
class NumberWidgetModel extends WidgetModel<NumberScreen, NumberModel>
    implements INumberWidgetModel {
  late final EntityStateNotifier<String> _factState;

  late final EntityStateNotifier<String> _quizState;

  late final EntityStateNotifier<String> _fishState;

  late final EntityStateNotifier<String> _launchState;

  final TextEditingController _controller = TextEditingController();

  NumberWidgetModel(NumberModel model) : super(model);

  @override
  Future<void> sendRequest() async {
    String maybeNumber = controller.text.trim();
    if (maybeNumber != '') {
      _factState.loading();
      _quizState.loading();
      _fishState.loading();
      _launchState.loading();
      NumberInfo serverAnswer = await model.getNumberInfo(
        int.parse(controller.text),
      );
      _factState.content(serverAnswer.fact);
      _quizState.content(
        serverAnswer.quiz.showQuiz(),
      );
      _fishState.content(serverAnswer.fish.text);
      _launchState.content(serverAnswer.launch.missionName);

      controller.clear();
    } else {
      _factState.content(Strings.failRequest);
      _quizState.content("");
      _fishState.content("");
      _launchState.content("");
    }
  }

  @override
  TextEditingController get controller => _controller;

  @override
  ListenableState<EntityState<String>> get factState => _factState;

  @override
  ListenableState<EntityState<String>> get quizState => _quizState;

  @override
  ListenableState<EntityState<String>> get fishState => _fishState;

  @override
  ListenableState<EntityState<String>> get launchState => _launchState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _factState = EntityStateNotifier<String>.value(Strings.initFact);
    _quizState = EntityStateNotifier<String>.value(Strings.initQuiz);
    _fishState = EntityStateNotifier<String>.value(Strings.initFish);
    _launchState = EntityStateNotifier<String>.value(Strings.initLaunch);
  }

  @override
  void dispose() {
    _controller.dispose();
    _factState.dispose();
    _quizState.dispose();
    _fishState.dispose();
    _launchState.dispose();
    super.dispose();
  }
}

/// Interface of [NumberWidgetModel].
abstract class INumberWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get factState;

  ListenableState<EntityState<String>> get quizState;

  ListenableState<EntityState<String>> get fishState;

  ListenableState<EntityState<String>> get launchState;

  /// Text editing controller Main Screen.
  TextEditingController get controller;

  /// action for [floatingActionButton]
  Future<void> sendRequest();
}
