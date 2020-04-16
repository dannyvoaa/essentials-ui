import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:flutter/material.dart';

class RoundedDropDownMenu extends StatelessWidget {
  // Setup any required variables
  final bool boolValid;
  final List<DropdownMenuItem> listDropDownMenuItems;
  final String selected;
  final Function(String) onDropdownChanged;

  // Initialize the widget
  RoundedDropDownMenu({
    this.boolValid = true,
    this.listDropDownMenuItems,
    this.selected,
    this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        icon: Icon(Icons.keyboard_arrow_down),
        isDense: true,
        items: listDropDownMenuItems ?? [],
        onChanged: (var value) {
          // Check to see if an on changed action was supplied
          if (this.onDropdownChanged != null) {
            // Execute the on changed action
            this.onDropdownChanged(value.toString());
          }
        },
        underline: Container(),
        value: selected,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: boolValid ? CustomColors.separator : BrandColors.red,
          width: Dimensions.size1px,
        ),
        borderRadius: BorderRadius.circular(
          Dimensions.size4px,
        ),
      ),
      padding: EdgeInsets.only(
        left: 12,
        top: 6,
        right: 12,
        bottom: 6,
      ),
    );
  }
}
