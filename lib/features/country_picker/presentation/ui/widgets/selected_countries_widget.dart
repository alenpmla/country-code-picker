import 'package:country_picker/core/utils/color_constants.dart';
import 'package:country_picker/features/country_picker/presentation/ui/widgets/single_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/country.dart';
import '../../changenotifiers/country_code_picker_change_notifier.dart';
import 'pick_new_country_widget.dart';

class SelectedCountriesWidget extends StatelessWidget {
  final VoidCallback openCountryPicker;

  const SelectedCountriesWidget({
    Key? key,
    required this.openCountryPicker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryCodePickerChangeNotifier>(
        builder: (context, provider, child) {
      List<Widget> widgets = [];
      for (Country country in provider.pickedCountryList) {
        widgets.add(SingleChipWidget(
          onClipPressed: () {
            provider.removeCountry(country);
          },
          country: country,
        ));
      }
      widgets.add(PickNewCountryWidget(
        onClipPressed: () {
          openCountryPicker();
        },
      ));
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 350,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: chipContainerColor,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widgets,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
