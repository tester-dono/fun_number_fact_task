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
  final _factState = StateNotifier<String>();

  final _quizState = StateNotifier<String>();

  final _loadingState = StateNotifier<bool>();

  final TextEditingController _controller = TextEditingController();

  NumberWidgetModel(NumberModel model) : super(model);

  @override
  Future<void> sendRequest() async {
    String maybeNumber = controller.text.trim();
    if (maybeNumber != '') {
      _loadingState.accept(true);
      NumberInfo serverAnswer = await model.getNumberInfo(
        int.parse(controller.text),
      );
      _factState.accept(serverAnswer.fact);
      _quizState.accept(serverAnswer.quiz.showQuiz());
      _loadingState.accept(false);
      controller.clear();
    } else {
      _factState.accept(Strings.failRequest);
      _quizState.accept("");
    }
  }

  @override
  TextEditingController get controller => _controller;

  @override
  ListenableState<String> get factState => _factState;

  @override
  ListenableState<String> get quizState => _quizState;

  @override
  ListenableState<bool> get loadingState => _loadingState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _factState.accept(Strings.initFact);
    _quizState.accept(Strings.initQuiz);
    _loadingState.accept(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    _factState.dispose();
    _quizState.dispose();
    _loadingState.dispose();
    super.dispose();
  }
}

/// Interface of [NumberWidgetModel].
abstract class INumberWidgetModel extends IWidgetModel {
  /// Text of the FunFacts TextField.
  ListenableState<String> get factState;

  /// Text of the quiz TextField.
  ListenableState<String> get quizState;

  /// State of loading (maybe better to create state of widget)
  ListenableState<bool> get loadingState;

  /// Text editing controller Main Screen.
  TextEditingController get controller;

  /// action for [floatingActionButton]
  Future<void> sendRequest();
}
