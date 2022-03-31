import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../changenotifiers/country_code_picker_change_notifier.dart';
import '../widgets/country_picker_model_sheet.dart';
import '../widgets/selected_countries_widget.dart';
import '../../../../../core/utils/color_constants.dart';


class CountryPickerScreen extends StatefulWidget {
  const CountryPickerScreen({Key? key}) : super(key: key);

  @override
  _CountryPickerScreenState createState() => _CountryPickerScreenState();
}

class _CountryPickerScreenState extends State<CountryPickerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/main_bg_image.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const SizedBox(
                height: 13 + kToolbarHeight,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 43, right: 43),
                child: Text(
                  "Country picker case study for LifeTap",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 5,
                              width: 34,
                              decoration: BoxDecoration(
                                  color: fadedWhiteColor,
                                  borderRadius: BorderRadius.circular(3.5)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 54,
                        ),
                        Consumer<CountryCodePickerChangeNotifier>(
                            builder: (context, provider, child) {
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "Selected countries",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: SelectedCountriesWidget(
                                    openCountryPicker: () {
                                      showPicker(provider);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  showPicker(CountryCodePickerChangeNotifier provider) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const CountryPickerModelSheet();
        });
  }
}
