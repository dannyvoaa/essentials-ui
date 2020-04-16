import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';

class LocationCell extends StatelessWidget {
  // Setup any required variables
  final String stringId;
  final String stringCity;
  final String stringCountry;
  final String stringFaa;
  final String stringIcao;
  final String stringName;
  final String stringState;
  final bool boolShowDelete;
  final bool boolShowEdit;
  final String stringDeleteButtonLabel;
  final String stringEditButtonLabel;
  final Function() onDeleteAction;
  final Function() onEditAction;

  // Initialize the widget
  LocationCell({
    @required this.stringCity,
    @required this.stringCountry,
    @required this.stringFaa,
    @required this.stringIcao,
    @required this.stringId,
    @required this.stringName,
    @required this.stringState,
    this.boolShowDelete = true,
    this.boolShowEdit = true,
    this.stringDeleteButtonLabel = 'Delete',
    this.stringEditButtonLabel = 'Edit',
    this.onDeleteAction,
    this.onEditAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              this.stringCountry,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.body(),
            ),
            width: Dimensions.size256px,
          ),
          Expanded(
            child: Container(
              child: Text(
                '${this.stringCity} ${this.stringName != '' ? '(${this.stringName})' : ''}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.headline(),
              ),
            ),
          ),
          SizedBox(
            width: Dimensions.size32px,
          ),
          boolShowEdit
              ? RoundedButton(
                  child: Text(stringEditButtonLabel),
                  onPressed: () {
                    // Check to see if an action was supplied
                    if (this.onEditAction != null) {
                      // Execute the action
                      this.onEditAction();
                    }
                  },
                )
              : Container(),
          boolShowDelete && boolShowEdit
              ? SizedBox(
                  width: Dimensions.size16px,
                )
              : Container(),
          boolShowDelete
              ? RoundedButton(
                  child: Text(stringDeleteButtonLabel),
                  color: BrandColors.red,
                  onPressed: () {
                    // Check to see if an action was supplied
                    if (this.onDeleteAction != null) {
                      // Execute the action
                      this.onDeleteAction();
                    }
                  },
                )
              : Container(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.separator,
            width: Dimensions.sizeDivider,
          ),
        ),
      ),
      height: Dimensions.size48px,
    );
  }
}
