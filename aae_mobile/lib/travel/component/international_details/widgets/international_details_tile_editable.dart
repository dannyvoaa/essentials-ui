import 'package:aae/model/countries.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

enum InternationalDetailsFieldType {
  text, number, country, pastDate, futureDate,
}

class InternationalDetailsTileEditable extends StatelessWidget {
  final String label;
  final Widget formField;

  InternationalDetailsTileEditable({
    @required this.label,
    @required this.formField
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AaeDimens.baseUnit / 2,
          horizontal: AaeDimens.baseUnit / 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label ?? "",
              style: AaeTextStyles.caption13MediumGray,
            ),
            formField,
          ],
        ),
      ),
    );
  }
}
