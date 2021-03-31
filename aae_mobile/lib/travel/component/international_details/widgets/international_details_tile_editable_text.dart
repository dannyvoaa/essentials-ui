import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

import 'international_details_tile_editable.dart';

class InternationalDetailsTileEditableText extends StatefulWidget {
  final String label;
  final String initialValue;
  final TextInputType inputType;
  final Function (String newValue) onChanged;

  const InternationalDetailsTileEditableText({
    this.label,
    this.initialValue,
    this.onChanged,
    this.inputType = TextInputType.text,
  });

  @override
  _InternationalDetailsTileEditableTextState createState() => _InternationalDetailsTileEditableTextState();

  static TextFormField buildTextField({
    Function onSaved,
    Function onChanged,
    TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      style: AaeTextStyles.body16,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: AaeDimens.baseUnit/2),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AaeColors.gray),
        ),
      ),
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}

class _InternationalDetailsTileEditableTextState extends State<InternationalDetailsTileEditableText> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.initialValue ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return InternationalDetailsTileEditable(
      label: widget.label,
      formField: InternationalDetailsTileEditableText.buildTextField(
        onChanged: widget.onChanged,
        inputType: widget.inputType,
        controller: controller,
        enabled: true,
      ),
    );
  }
}