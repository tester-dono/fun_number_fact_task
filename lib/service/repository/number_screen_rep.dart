import 'dart:async';
import 'dart:convert';

import 'package:fun_number_fact_task/domain/quiz.dart';
import 'package:http/http.dart' as http;

/// Repository interface for working with NumberScreen.
abstract class INumberRepository {
  /// method of getting fun fact of a int number
  Future<String> getNumberFact(int number);

  /// method of getting random quiz
  Future<List<Quiz>> getQuiz();
}

/// Repository for working with a NumberScreen
class NumberRepository implements INumberRepository {
  @override
  Future<String> getNumberFact(int number) async {
    http.Response responseValue = await http.get(
      Uri.parse('http://numbersapi.com/$number/trivia'),
    );

    if (responseValue.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      String futureNumberFact = responseValue.body;

      return futureNumberFact;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load fact');
    }
  }

  @override
  Future<List<Quiz>> getQuiz() async {
    http.Response responseValue = await http.get(
      Uri.parse('http://jservice.io/api/random?'),
    );

    if (responseValue.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsed =
          jsonDecode(responseValue.body).cast<Map<String, Object?>>();

      return parsed.map<Quiz>((json) => Quiz.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load quiz');
    }
  }
}
