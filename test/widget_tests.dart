import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fun_number_fact_task/res/strings/strings.dart';
import 'package:fun_number_fact_task/ui/screen/number_screen.dart';
import 'package:mocktail/mocktail.dart';

/// это MaterialApp + scaffold для виджетов, которые используют ... MaterialApp
class MaterialAppProvider extends StatelessWidget {
  const MaterialAppProvider({
    Key? key,
    required this.widgetForTest,
  }) : super(key: key);

  final Widget widgetForTest;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: widgetForTest,
        ),
      ),
    );
  }
}

/// part of numberWm
class KindaTestWm {
  late final EntityStateNotifier<String> _factState;

  late final EntityStateNotifier<String> _quizState;

  late final EntityStateNotifier<String> _fishState;

  EntityStateNotifier<String> giveFactState() {
    return _factState;
  }

  ListenableState<EntityState<String>> get factState => _factState;

  ListenableState<EntityState<String>> get quizState => _quizState;

  ListenableState<EntityState<String>> get fishState => _fishState;
}

class MockWm extends Mock implements KindaTestWm {}

void main() {
  testWidgets('factWidget on init should contain [Strings.initFact]',
      (WidgetTester tester) async {
    /// create mock
    final mockWm = MockWm();
    when(() => mockWm._factState)
        .thenReturn(EntityStateNotifier<String>.value(Strings.initFact));

    /// create widget that should be tested
    StateLoader widgetForTest = StateLoader(
      state: mockWm._factState,
    );

    /// create stl to provide materialApp
    MaterialAppProvider materialPlusWidget = MaterialAppProvider(
      widgetForTest: widgetForTest,
    );

    /// and usual widget testing staff
    await tester.pumpWidget(materialPlusWidget);

    final stringFinder = find.text(Strings.initFact);

    expect(stringFinder, findsOneWidget);
  });

  testWidgets('factWidget on fail should contain [Strings.failRequest]',
      (WidgetTester tester) async {
    /// create mock
    final mockWm = MockWm();
    when(() => mockWm._factState)
        .thenReturn(EntityStateNotifier<String>.value(Strings.failRequest));

    /// create widget that should be tested
    StateLoader widgetForTest = StateLoader(
      state: mockWm._factState,
    );

    /// create stl to provide materialApp
    MaterialAppProvider materialPlusWidget = MaterialAppProvider(
      widgetForTest: widgetForTest,
    );

    /// and usual widget testing staff
    await tester.pumpWidget(materialPlusWidget);

    final stringFinder = find.text(Strings.failRequest);

    expect(stringFinder, findsOneWidget);
  });
}
