import 'package:flutter/material.dart';
import '../../../../../core/utils/color_constants.dart';


class PickNewCountryWidget extends StatelessWidget {
  final VoidCallback onClipPressed;

  const PickNewCountryWidget({Key? key, required this.onClipPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onClipPressed,
          child: Container(
            decoration: BoxDecoration(
                color: chipBgColor, borderRadius: BorderRadius.circular(14.5)),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 10),
              child: Row(
                children: [
                  Text(
                    "Add new",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.add,
                    size: 24,
                    color: mainFontColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
