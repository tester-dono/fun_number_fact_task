import 'package:flutter_test/flutter_test.dart';
import 'package:fun_number_fact_task/domain/fish.dart';
import 'package:fun_number_fact_task/domain/launch.dart';
import 'package:fun_number_fact_task/domain/quiz.dart';
import 'package:fun_number_fact_task/domain/server_answer.dart';
import 'package:fun_number_fact_task/service/repository/number_screen_rep.dart';
import 'package:fun_number_fact_task/ui/screen/number_screen_model.dart';
import 'package:mocktail/mocktail.dart';

class MockRep extends Mock implements NumberRepository {}

void main() {
  /// prepare mock answers of mockRep
  Quiz testQuiz = Quiz(
    id: 1,
    question: '',
    category2: const QuizCategory(id: 1, title: ''),
    answer: '1 is a number',
  );
  Fish testFish = const Fish(text: 'testFish');
  Launch testLaunch = const Launch(missionName: 'testLaunch');

  /// prepare mocktail rep with func
  final mockRep = MockRep();
  when(() => mockRep.getNumberFact(1))
      .thenAnswer((_) => Future.value("1 is a number"));
  when(() => mockRep.getQuiz()).thenAnswer((_) => Future.value([testQuiz]));
  when(() => mockRep.getHttpsFish()).thenAnswer((_) => Future.value(testFish));
  when(() => mockRep.getGraphQLLaunch())
      .thenAnswer((_) => Future.value(testLaunch));

  /// create model for testing with mockTail rep
  NumberModel modelForTest = NumberModel(mockRep);

  group('3 units', () {
    test('model should get NumberInfo with number fact', () async {
      NumberInfo testNumberInfo = await modelForTest.getNumberInfo(1);
      expect(testNumberInfo.fact, "1 is a number");
    });

    test('model should get NumberInfo with quiz', () async {
      NumberInfo testNumberInfo = await modelForTest.getNumberInfo(1);
      expect(testNumberInfo.quiz, testQuiz);
    });

    test('model should get NumberInfo with fish', () async {
      NumberInfo testNumberInfo = await modelForTest.getNumberInfo(1);
      expect(testNumberInfo.fish, testFish);
    });
  });
}
