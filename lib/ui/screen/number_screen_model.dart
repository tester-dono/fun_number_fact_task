import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:fun_number_fact_task/domain/quiz.dart';
import 'package:fun_number_fact_task/domain/serverAnswer.dart';
import 'package:fun_number_fact_task/service/repository/number_screen_rep.dart';

/// Model of [NumberWidgetModel]
class NumberModel extends ElementaryModel {
  final NumberRepository _rep = NumberRepository();

  /// method of getting fun fact of a int number
  Future<String> getFact(int number) async {
    Future<String> _fact = _rep.getNumberFact(number);

    return _fact;
  }

  /// method of getting random quiz
  Future<Quiz> getFirstQuiz() async {
    List<Quiz> _quiz = await _rep.getQuiz();

    return _quiz.first;
  }

  /// method of prepare the whole answer
  /// на самом деле я подумал о том, что можно сделать что то вроде
  /// вызова всех методов из списка методов, которые бы положили в параметры
  /// метода, а потом из этого сформировать ответ но камон слишком оверхед
  Future<ServerAnswer> getServerAnswer(int number) async {
    ServerAnswer _answer = ServerAnswer(
      fact: await getFact(number),
      quiz: await getFirstQuiz(),
    );

    return _answer;
  }
}
