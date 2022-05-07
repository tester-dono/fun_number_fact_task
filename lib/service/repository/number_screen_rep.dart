import 'dart:async';
import 'dart:convert';

import 'package:fun_number_fact_task/domain/fish.dart';
import 'package:fun_number_fact_task/domain/launch.dart';
import 'package:fun_number_fact_task/domain/quiz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Repository interface for working with NumberScreen.
abstract class INumberRepository {
  /// method of getting fun fact of a int number
  Future<String> getNumberFact(int number);

  /// method of getting random quiz
  Future<List<Quiz>> getQuiz();

  /// method of getting fish from https
  Future<Fish> getHttpsFish();

  /// method of getting launch from graphQl
  Future<Launch> getGraphQLLaunch();

  /// method of getting counter from [SharedPreferences]
  Future<int> getCounter();

  /// method of saving counter in [SharedPreferences]
  void saveCounter(int newCounter);
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
  Future<Fish> getHttpsFish() async {
    http.Response responseValue = await http.get(
      Uri.parse('https://www.fishwatch.gov/api/species'),
    );

    final parsed = jsonDecode(responseValue.body).cast<Map<String, Object?>>();

    if (responseValue.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Fish> banchOfFish =
          parsed.map<Fish>((json) => Fish.fromJson(json)).toList();

      return banchOfFish.first;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load fact');
    }
  }

  @override
  Future<Launch> getGraphQLLaunch() async {
    const String stringRequest = """
query Launches{
  launches {
    mission_name
  }
}

    """;
    final HttpLink link = HttpLink('https://api.spacex.land/graphql/');

    var client = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );

    QueryResult result =
        await client.query(QueryOptions(document: gql(stringRequest)));
    final List<dynamic> repositories = result.data!["launches"];

    List<Launch> launches =
        repositories.map<Launch>((json) => Launch.fromJson(json)).toList();

    return launches.first;
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

  @override
  Future<int> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final int? counter = prefs.getInt('counter');
    if (counter != null) {
      return counter;
    } else {
      return 0;
    }
  }

  @override
  void saveCounter(int newCounter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', newCounter);
  }
}
