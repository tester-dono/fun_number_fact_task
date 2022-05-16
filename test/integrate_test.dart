import 'package:flutter_test/flutter_test.dart';
import 'package:fun_number_fact_task/res/strings/strings.dart';
import 'package:integration_test/integration_test.dart';

import 'package:fun_number_fact_task/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify failure',
        (WidgetTester tester) async {
      // если честно, я вообще не знаю, как тут передать нормально mock rep
      app.main();
      await tester.pumpAndSettle();

      // Verify the numberScreen  starts with title
      expect(find.text(Strings.title), findsOneWidget);

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('send');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify that request fail normally
      expect(find.text(Strings.failRequest), findsOneWidget);
    });
  });
}
