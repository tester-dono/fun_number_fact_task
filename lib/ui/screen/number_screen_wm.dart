import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:fun_number_fact_task/domain/server_answer.dart';
import 'package:fun_number_fact_task/res/strings/strings.dart';
import 'package:fun_number_fact_task/ui/screen/number_screen.dart';
import 'package:fun_number_fact_task/ui/screen/number_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/// Builder for [NumberWidgetModel]
NumberWidgetModel numberWidgetModelFactory(BuildContext context) {
  return NumberWidgetModel(NumberModel());
}

/// WidgetModel for [NumberScreen]
class NumberWidgetModel extends WidgetModel<NumberScreen, NumberModel>
    implements INumberWidgetModel {
  final StateNotifier<String> _titleState = StateNotifier<String>();

  final StateNotifier<String> _genderState = StateNotifier<String>();

  String _gender = "male";

  final StateNotifier<String> _amountState = StateNotifier<String>();

  int _amount = 1;

  late final EntityStateNotifier<String> _factState;

  late final EntityStateNotifier<String> _quizState;

  late final EntityStateNotifier<String> _fishState;

  late final EntityStateNotifier<String> _launchState;

  final TextEditingController _controller = TextEditingController();

  NumberWidgetModel(NumberModel model) : super(model);

  // я пытался
  String prepareMessage(int howMany) {
      return Intl.plural(howMany,
          one: '${AppLocalizations.of(context)!.greetings},${giveIntlGender(_gender)}${AppLocalizations.of(context)!.notS}?',
          other: '${AppLocalizations.of(context)!.greetings},${giveIntlGender(_gender)}${AppLocalizations.of(context)!.s}?',
          name: 'prepareMessage',
          args: [howMany],
          desc: 'prepares Messages.',
          examples: const {'howMany': 1, 'userName': 'boy'});
  }

  String giveIntlGender(String userGender) {
    return Intl.gender(
      userGender,
      male: AppLocalizations.of(context)!.boy(1),
      female: AppLocalizations.of(context)!.girl(1),
      other: userGender,
      args: [userGender],
      desc: 'The user is not available to hangout.',
    );
  }


  @override
  Future<void> changeSex() async {
    if (_gender == "male") {
      _gender = "female";
      _genderState.accept("female");
    } else {
      _gender = "male";
      _genderState.accept("male");
    }

    _titleState.accept(
      prepareMessage(
        _amount,
      ),
    );
  }

  @override
  Future<void> changeAmount() async {
    if (_amount == 1) {
      _amount = 2;
      _amountState.accept("one");
    } else {
      _amount = 1;
      _amountState.accept("two");
    }
    _titleState.accept(
      prepareMessage(
        _amount,
      ),
    );
  }

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
    }
  }

  @override
  TextEditingController get controller => _controller;

  @override
  StateNotifier<String> get titleState => _titleState;

  @override
  StateNotifier<String> get genderState => _genderState;

  @override
  StateNotifier<String> get pluralState => _amountState;

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
    _titleState.accept(
      prepareMessage(
        _amount,
      ),
    );
    _genderState.accept(_gender);
    _amountState.accept("one");

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

  @override
  void didChangeDependencies() {
    _titleState.accept(
      prepareMessage(
        _amount,
      ),
    );
    super.didChangeDependencies();
  }
}

/// Interface of [NumberWidgetModel].
abstract class INumberWidgetModel extends IWidgetModel {
  StateNotifier<String> get titleState;

  StateNotifier<String> get genderState;

  StateNotifier<String> get pluralState;

  ListenableState<EntityState<String>> get factState;

  ListenableState<EntityState<String>> get quizState;

  ListenableState<EntityState<String>> get fishState;

  ListenableState<EntityState<String>> get launchState;

  /// Text editing controller Main Screen.
  TextEditingController get controller;

  /// action for [floatingActionButton]
  Future<void> sendRequest();

  /// action for [floatingActionButton]
  Future<void> changeSex();

  /// action for [floatingActionButton]
  Future<void> changeAmount();
}
