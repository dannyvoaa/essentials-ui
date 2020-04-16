import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarEventCell extends StatelessWidget {
  // Setup any required variables
  final bool boolAllDay;
  final DateTime dateTimeStart;
  final DateTime dateTimeEnd;
  final int intUtcOffset;
  final String stringContactInfoName;
  final String stringEventName;
  final String stringId;
  final String stringLocationRoomNumber;
  final String stringLocationVenue;
  final bool boolShowDelete;
  final bool boolShowEdit;
  final String stringDeleteButtonLabel;
  final String stringEditButtonLabel;
  final Function() onDeleteAction;
  final Function() onEditAction;

  // Initialize the widget
  CalendarEventCell({
    @required this.boolAllDay,
    @required this.dateTimeStart,
    @required this.dateTimeEnd,
    @required this.intUtcOffset,
    @required this.stringContactInfoName,
    @required this.stringEventName,
    @required this.stringId,
    this.stringLocationRoomNumber,
    @required this.stringLocationVenue,
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
              !this.boolAllDay
                  ? '${DateFormat.jm().format(this.dateTimeStart)} - ${DateFormat.jm().format(this.dateTimeEnd)}'
                  : 'All Day',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.headline(),
            ),
            width: Dimensions.size128px,
          ),
          Container(
            child: Text(!this.boolAllDay ? '(UTC ${(this.intUtcOffset / 60).toStringAsFixed(2).replaceAll('.', ':')})' : '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            width: Dimensions.size64px + Dimensions.size16px,
          ),
          SizedBox(
            width: Dimensions.size32px,
          ),
          Container(
            child: Text(
              this.stringEventName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            width: Dimensions.size128px,
          ),
          SizedBox(
            width: Dimensions.size32px,
          ),
          Container(
            child: Text(
              '${this.stringLocationVenue}${this.stringLocationRoomNumber != '' ? ' ($stringLocationRoomNumber)' : ''}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            child: Text(
              this.stringContactInfoName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            width: 192,
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
