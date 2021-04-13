
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'international_details_tile_editable.dart';
import 'international_details_tile_editable_text.dart';

class InternationalDetailsTileEditableDate extends StatefulWidget {
  static final DateFormat _inputDateFormat = DateFormat("yyyy-MM-dd");

  final String label;
  final DateTime initialValue;
  final Function (DateTime newValue) onChanged;
  final bool isFutureDate;

  InternationalDetailsTileEditableDate({
    this.label,
    this.initialValue,
    this.onChanged,
    this.isFutureDate,
  });

  InternationalDetailsTileEditableDate.textMode({
    String label,
    String initialValue,
    Function(String newValue) onChanged,
    bool isFutureDate,
  }): this(
    label: label,
    initialValue: initialValue == null ? null : _inputDateFormat.parse(initialValue),
    isFutureDate: isFutureDate,
    onChanged: (DateTime newValue) {
      if (newValue != null && onChanged != null)
        onChanged(_inputDateFormat.format(newValue));
    },
  );

  @override
  _InternationalDetailsTileEditableDateState createState() => _InternationalDetailsTileEditableDateState();
}

class _InternationalDetailsTileEditableDateState extends State<InternationalDetailsTileEditableDate> {
  final DateFormat displayDateFormat = DateFormat("MM-dd-yyyy");

  TextEditingController textFieldController;
  DateTime value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    textFieldController = TextEditingController(
      text: value == null ? "" : displayDateFormat.format(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InternationalDetailsTileEditable(
      label: widget.label,
      formField: widget.isFutureDate ? _buildFutureDateField(context) : _buildPastDateField(context),
    );
  }

  Widget _buildPastDateField(BuildContext context) {
    return _buildDateField(context,
        earliestDate: DateTime.now().subtract(Duration(days: 365 * 50)),
        latestDate: DateTime.now());
  }

  Widget _buildFutureDateField(BuildContext context) {
    return _buildDateField(context,
        earliestDate: DateTime.now(),
        latestDate: DateTime.now().add(Duration(days: 365 * 50)));
  }

  Widget _buildDateField(BuildContext context, {DateTime earliestDate, DateTime latestDate}) {
    // if our current value is not within the specified range, adjust it
    if (value?.isBefore(earliestDate) ?? false)
      value = earliestDate;
    else if (value?.isAfter(latestDate) ?? false)
      value = latestDate;

    return InkWell(
      child: InternationalDetailsTileEditableText.buildTextField(
        controller: textFieldController,
        enabled: false,
      ),
      onTap: () async {
        DateTime chosenDate = await showDatePicker(routeSettings: RouteSettings(),
            context: context,
            initialDate: value ?? DateTime.now(),
            firstDate: earliestDate,
            lastDate: latestDate,
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AaeColors.blue,
                      surface: AaeColors.blue,
                    ),
                    buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme.primary,
                    )
                ),
                child: child,
              );
            }
        );

        if (chosenDate != null) {
          setState(() {
            value = chosenDate;
            textFieldController.text = displayDateFormat.format(value);
          });

          if (widget.onChanged != null) widget.onChanged(value);
        }
      },
    );
  }
}


