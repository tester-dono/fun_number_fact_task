import 'package:fun_number_fact_task/domain/fish.dart';
import 'package:fun_number_fact_task/domain/launch.dart';
import 'package:fun_number_fact_task/domain/quiz.dart';

class NumberInfo {
  Quiz quiz;
  String fact;
  Fish fish;
  Launch launch;

  NumberInfo({
    required this.quiz,
    required this.fact,
    required this.fish,
    required this.launch,
  });
}
