import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:fun_number_fact_task/domain/quiz.dart';
import 'package:fun_number_fact_task/domain/server_answer.dart';
import 'package:fun_number_fact_task/service/repository/number_screen_rep.dart';

/// Model of [NumberWidgetModel]
class NumberModel extends ElementaryModel {
  NumberModel({required this.rep});
  final NumberRepository rep;

  /// method of getting counter from SharedPrefs
  Future<int> getCounter() async {
    return rep.getCounter();
  }

  /// method of saving counter in SharedPrefs
  void setCounter(int newCounter) {
    rep.saveCounter(newCounter);
  }

  /// method of getting random quiz
  Future<Quiz> getFirstQuiz() async {
    List<Quiz> _quiz = await rep.getQuiz();

    return _quiz.first;
  }

  /// method of prepare the whole answer
  Future<NumberInfo> getNumberInfo(int number) async {
    NumberInfo _answer = NumberInfo(
      fact: await rep.getNumberFact(number),
      quiz: await getFirstQuiz(),
      fish: await rep.getHttpsFish(),
      launch: await rep.getGraphQLLaunch(),
    );

    return _answer;
  }
}
