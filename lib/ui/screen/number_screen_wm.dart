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
      _quizState.content(
          remainingEmailsMessage(int howMany, String userName) =>
          Intl.plural(
          howMany,
          zero: 'There are no emails left for $userName.',
          one: 'There is $howMany email left for $userName.',
          other: 'There are $howMany emails left for $userName.',
          name: 'remainingEmailsMessage',
          args: [howMany, userName],
          desc: 'How many emails remain after archiving.',
          examples: const {'howMany': 42, 'userName': 'Fred'});
      );
      _fishState.content(
          notOnlineMessage(String userName, String userGender) =>
          Intl.gender(
          userGender,
          male: '$userName is unavailable because he is not online.',
          female: '$userName is unavailable because she is not online.',
          other: '$userName is unavailable because they are not online',
          name: 'notOnlineMessage',
          args: [userName, userGender],
          desc: 'The user is not available to hangout.',
          examples: const {{'userGender': 'male', 'userName': 'Fred'},
            {'userGender': 'female', 'userName' : 'Alice'}});
      );
      _launchState.content(AppLocalizations.of(context).language,);
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
