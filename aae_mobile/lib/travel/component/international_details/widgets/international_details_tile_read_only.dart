import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class InternationalDetailsTileReadOnly extends StatelessWidget {
  static final _log = Logger("InternationalDetailsTileReadOnly");

  static final DateFormat _inputFormat = DateFormat("yyyy-MM-dd");
  static final DateFormat _displayFormat = DateFormat("MM-dd-yyyy");

  final String label;
  final String value;
  final bool isDate;

  InternationalDetailsTileReadOnly({this.label, value, this.isDate = false}):
    this.value = isDate ? _formatDate(value) : value;

  /// Converts a date string from the [_inputFormat] to the [_displayFormat].
  static String _formatDate(String input) {
    DateTime date;
    try {
      date = _inputFormat.parse(input);
    } catch (e) {
      _log.severe("date format not as expected: $input");
      return input;
    }

    return _displayFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AaeDimens.baseUnit),
      child: DefaultTextStyle(
        style: AaeTextStyles.body14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label ?? ""),
            Text(value ?? ""),
          ],
        ),
      ),
    );
  }
}
