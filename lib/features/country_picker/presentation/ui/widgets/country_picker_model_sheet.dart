import 'package:country_picker/features/country_picker/presentation/ui/widgets/single_picker_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/country.dart';
import '../../changenotifiers/country_code_picker_change_notifier.dart';
import '../../../../../core/utils/color_constants.dart';


class CountryPickerModelSheet extends StatefulWidget {
  const CountryPickerModelSheet({Key? key}) : super(key: key);

  @override
  _CountryPickerModelSheetState createState() =>
      _CountryPickerModelSheetState();
}

class _CountryPickerModelSheetState extends State<CountryPickerModelSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CountryCodePickerChangeNotifier>(context, listen: false)
          .fetchAllCountryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainPanelColor,
      child: Consumer<CountryCodePickerChangeNotifier>(
          builder: (context, provider, child) {
        List<Country> countryList = provider.allCountriesList;
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            color: mainBgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: _buildTextFormField(provider),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: countryList.isNotEmpty
                      ? CupertinoPicker.builder(
                          backgroundColor: mainBgColor,
                          key: Key("${countryList.length}"),
                          onSelectedItemChanged: (int index) {
                            if (countryList.length > index) {
                              provider.selectCurrentCountry(
                                  countryList.elementAt(index));
                            }
                          },
                          itemExtent: 25,
                          diameterRatio: 1,
                          childCount: countryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SinglePickerItem(
                                country: countryList.elementAt(index));
                          },
                        )
                      : _noResultFound(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _cancelButton(context),
                    const SizedBox(
                      width: 8,
                    ),
                    _selectButton(countryList, provider, context),
                  ],
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  TextFormField _buildTextFormField(CountryCodePickerChangeNotifier provider) {
    return TextFormField(
      maxLines: 1,
      onChanged: (val) {
        if (val.isNotEmpty) {
          provider.searchCountry(val);
        } else {
          provider.fetchAllCountryList();
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 8, right: 8),
        fillColor: textFieldBgColor,
        filled: true,
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SvgPicture.asset('assets/images/search_icon.svg',
                  width: 16, height: 16, semanticsLabel: 'Cancel Selection'),
            ),
          ],
        ),
        hintText: "Search",
        hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontSize: 17,
              color: subFontColor,
            ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent)),
      ),
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontSize: 17,
            color: mainFontColor,
          ),
    );
  }

  Center _noResultFound() {
    return Center(
        child: Text(
      "No results",
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontSize: 16,
            color: mainFontColor,
          ),
    ));
  }

  CupertinoButton _selectButton(List<Country> countryList,
      CountryCodePickerChangeNotifier provider, BuildContext context) {
    return CupertinoButton(
      disabledColor: subFontColor,
      onPressed: countryList.isNotEmpty
          ? () {
              bool result = provider.pickCountry(provider.getSelectedCountry);
              if (result) {
                Navigator.pop(context, true);
              } else {
                FocusScope.of(context).unfocus();
                showSnackBar(context,
                    text: "Country already selected",
                    color: Theme.of(context).errorColor);
              }
            }
          : null,
      child: Text(
        'Select',
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontSize: 16,
            color: countryList.isNotEmpty
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.5)),
      ),
    );
  }

  CupertinoButton _cancelButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Cancel',
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontSize: 16,
              color: Colors.red,
            ),
      ),
    );
  }

  void showSnackBar(BuildContext context,
      {required String text, required Color color}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20),
    ));
  }
}
