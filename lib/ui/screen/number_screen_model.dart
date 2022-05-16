import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:fun_number_fact_task/domain/quiz.dart';
import 'package:fun_number_fact_task/domain/server_answer.dart';
import 'package:fun_number_fact_task/service/repository/number_screen_rep.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Model of [NumberWidgetModel]
class NumberModel extends ElementaryModel {
  final NumberRepository _rep = NumberRepository();

  /// method of getting counter from SharedPrefs
  Future<int> getCounter(SharedPreferences prefs) async {
    return _rep.getCounter(prefs);
  }

  /// method of saving counter in SharedPrefs
  void setCounter(int newCounter, SharedPreferences prefs) {
    _rep.saveCounter(newCounter, prefs);
  }

  /// method of getting random quiz
  Future<Quiz> getFirstQuiz() async {
    List<Quiz> _quiz = await _rep.getQuiz();

    return _quiz.first;
  }

  /// method of prepare the whole answer
  Future<NumberInfo> getNumberInfo(int number) async {
    NumberInfo _answer = NumberInfo(
      fact: await _rep.getNumberFact(number),
      quiz: await getFirstQuiz(),
      fish: await _rep.getHttpsFish(),
      launch: await _rep.getGraphQLLaunch(),
    );

    return _answer;
  }
}
