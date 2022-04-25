import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:fun_number_fact_task/domain/serverAnswer.dart';
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

  final TextEditingController _controller = TextEditingController();

  NumberWidgetModel(NumberModel model) : super(model);

  @override
  Future<void> sendRequest() async {
    String maybeNumber = controller.text.trim();
    if (maybeNumber != '') {
      _factState.loading();
      _quizState.loading();
      NumberInfo serverAnswer = await model.getNumberInfo(
        int.parse(controller.text),
      );
      _factState.content(serverAnswer.fact);
      _quizState.content(
        serverAnswer.quiz.showQuiz(),
      );
      controller.clear();
    } else {
      _factState.content(Strings.failRequest);
      _quizState.content("");
    }
  }

  @override
  TextEditingController get controller => _controller;

  @override
  ListenableState<EntityState<String>> get factState => _factState;

  @override
  ListenableState<EntityState<String>> get quizState => _quizState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _factState = EntityStateNotifier<String>.value(Strings.initFact);
    _quizState = EntityStateNotifier<String>.value(Strings.initQuiz);
  }

  @override
  void dispose() {
    _controller.dispose();
    _factState.dispose();
    _quizState.dispose();
    super.dispose();
  }
}

/// Interface of [NumberWidgetModel].
abstract class INumberWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get factState;

  ListenableState<EntityState<String>> get quizState;

  /// Text editing controller Main Screen.
  TextEditingController get controller;

  /// action for [floatingActionButton]
  Future<void> sendRequest();
}
