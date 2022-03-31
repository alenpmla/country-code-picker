// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:country_picker/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('Country code main screen test', (WidgetTester tester) async {
      //open main screen
      app.main();
      await tester.pumpAndSettle();

      //verity main screen components
      expect(
          find.text('Country picker case study for LifeTap'), findsOneWidget);
      expect(find.text('Selected countries'), findsOneWidget);
      expect(find.text('Add new'), findsOneWidget);

      //open country picker
      await tester.tap(find.text('Add new'));
      await tester.pumpAndSettle();

      //test country picker functionality
      var textField = find.text('Search');
      expect(textField, findsOneWidget);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), "india");
      await tester.pumpAndSettle();
      expect(find.text('Select'), findsOneWidget);
      await tester.tap(find.text('Select'));

      await tester.pumpAndSettle();

      //verity the search result on screen
      expect(find.text('British Indian Ocean Territory'), findsOneWidget);
    });
  });
}
