import 'package:country_picker/core/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/country.dart';

class SingleChipWidget extends StatelessWidget {
  final Country country;
  final VoidCallback onClipPressed;

  const SingleChipWidget(
      {Key? key, required this.country, required this.onClipPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: chipBgColor, borderRadius: BorderRadius.circular(14.5)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 5),
            child: Row(
              children: [
                Text(
                  country.countryName,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16,
                      ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: onClipPressed,
                  child: SvgPicture.asset('assets/images/close_icon.svg',
                      width: 24,
                      height: 24,
                      semanticsLabel: 'Cancel Selection'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
