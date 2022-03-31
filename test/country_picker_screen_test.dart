// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:country_picker/core/utils/color_constants.dart';
import 'package:country_picker/features/country_picker/presentation/changenotifiers/country_code_picker_change_notifier.dart';
import 'package:country_picker/features/country_picker/presentation/ui/screens/country_picker_screen.dart';
import 'package:country_picker/injector_container.dart';
import 'package:country_picker/injector_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  setUp(() async {
    await di.init();
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountryCodePickerChangeNotifier>(
            create: (_) => sl<CountryCodePickerChangeNotifier>()),
      ],
      child:  MaterialApp(
        title: 'Country Picker',
        theme: ThemeData(
            fontFamily: 'Avenir',
            primarySwatch: Colors.blue,
            backgroundColor: mainBgColor,
            cardColor: mainPanelColor,
            primaryColor: primaryColor,
            errorColor: errorColor,
            textTheme: const TextTheme(
                headline1: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 21,
                    color: mainFontColor,
                    fontWeight: FontWeight.w900),
                headline2: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 21,
                    color: mainFontColor,
                    fontWeight: FontWeight.w500),
                bodyText1: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    color: mainFontColor),
                bodyText2: TextStyle(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w400,
                    color: mainFontColor),
                subtitle1: TextStyle(color: subFontColor))),
        home: const CountryPickerScreen(),
      ),
    );
  }

  testWidgets('Country code main screen test', (WidgetTester tester) async {
    //open main screen
    await tester.pumpWidget(createWidgetUnderTest());

    //verity main screen components
    expect(find.text('Country picker case study for LifeTap'), findsOneWidget);
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
}
