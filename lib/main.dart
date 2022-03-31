import 'package:country_picker/injector_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/utils/color_constants.dart';
import 'features/country_picker/presentation/changenotifiers/country_code_picker_change_notifier.dart';
import 'features/country_picker/presentation/ui/screens/country_picker_screen.dart';
import 'injector_container.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountryCodePickerChangeNotifier>(
            create: (_) => sl<CountryCodePickerChangeNotifier>()),
      ],
      child: MaterialApp(
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
}
