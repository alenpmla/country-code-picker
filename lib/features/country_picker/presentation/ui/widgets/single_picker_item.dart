import 'package:flutter/material.dart';

import '../../../../../core/utils/color_constants.dart';
import '../../../domain/entities/country.dart';

class SinglePickerItem extends StatelessWidget {
  final Country country;

  const SinglePickerItem({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _child(
      context,
    );
  }

  Widget _child(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                country.countryCode,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: mainFontColor, fontSize: 23),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          flex: 7,
          fit: FlexFit.tight,
          child: Text(
            country.countryName,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: mainFontColor, fontSize: 23),
          ),
        ),
      ],
    );
  }
}
