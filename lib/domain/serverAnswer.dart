import 'package:fun_number_fact_task/domain/quiz.dart';

class ServerAnswer {
  Quiz quiz;
  String fact;

  ServerAnswer({
    required this.quiz,
    required this.fact,
  });
}
