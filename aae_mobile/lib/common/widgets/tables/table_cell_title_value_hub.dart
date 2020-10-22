import 'package:aae/profile/profile_details.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class TableCellTitleValueHub extends StatelessWidget {
  // Setup any required variables
  final bool boolBorderBottom;
  final bool boolBorderTop;
  final bool boolShowCheckmark;
  final bool boolShowAdd;
  final bool boolShowDisclosureIndicator;
  final bool boolEnabled;
  final bool boolHubTextGray;
  final bool boolTopicWorkgroupSelected;
  final String stringTitle;
  final String txt;
  final String stringValue;
  final void Function() onTapAction;

  // Initialize the widget
  TableCellTitleValueHub({
    this.boolBorderBottom = true,
    this.boolBorderTop = false,
    this.boolHubTextGray = true,
    this.boolTopicWorkgroupSelected = false,
    this.stringTitle = '',
    this.stringValue = '',
    this.onTapAction,
    this.txt = '',
    this.boolEnabled = true,
    this.boolShowCheckmark = false,
    this.boolShowAdd = false,
    this.boolShowDisclosureIndicator = false,
  });

  @override
  Widget build(BuildContext context) {

    ProfileDetails profiledetails = ProfileDetails.getInstance();
    String location = profiledetails.userlocation;

    if (location == null) {
      location = "";
    }


    return Column(
      children: <Widget>[
        this.boolBorderTop
            ? Container(
          height: AaeDimens.sizeDivider,
          color: AaeColors.white,
        )
            : Container(),
        Material(
          child: InkWell(
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      stringTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                        style: stringTitle.substring(0,3).toUpperCase() != location.toUpperCase() ?
                        AaeTextStyles.tableCellTitle(boolEnabled: this.boolEnabled) :
                        //TextStyle(fontSize: 16,color: Colors.orange,fontWeight: FontWeight.bold),
                        AaeTextStyles.tableCellTitleHub(boolEnabled: this.boolEnabled),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    stringValue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ApplyStyle(),

                    textAlign: TextAlign.right,
                  ),
                  Text(
                    txt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AaeTextStyles.tableCellTitle(
                      boolEnabled: this.boolEnabled,

                    ),
                    textAlign: TextAlign.right,
                  ),
                  this._cellAccessory(),
                ],
              ),
              height: AaeDimens.sizeTableViewCell,
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
                top:6,
                bottom:6,

              ),
            ),
            onTap: () {
              // Check to see if an on-tap action was provided
              if (this.boolEnabled && this.onTapAction != null) {
                // Execute the on-tap action
                this.onTapAction();
              }
            },
            highlightColor: this.boolEnabled && onTapAction != null
                ? AaeColors.tableViewCellBackgroundSelected
                : Colors.transparent,
          ),
          //  color: AaeColors.tableViewCellBackground,
        ),
        this.boolBorderBottom
            ? Container(
          height: AaeDimens.sizeDivider,
          color: AaeColors.ultraLightGray,
        )
            : Container(),
      ],
    );
  }

  //AaeTextStyles.tableCellValue(boolEnabled: this.boolEnabled)
  //TextStyle(color: Colors.grey.withOpacity(0.6))

  TextStyle ApplyStyle() {
    if (this.boolHubTextGray)
      return AaeTextStyles.tableCellValueHub();
    else
      return AaeTextStyles.tableCellValue(boolEnabled: this.boolEnabled);
  }

  /// If boolShowDisclosureIndicator == true, the disclosure indicator will be displayed
  Widget _cellAccessory() {
    Color colorAccessory;
    IconData iconAccessory;



    // Check to see if the disclosure indicator should be shown
    if (this.boolShowDisclosureIndicator) {
      colorAccessory = AaeColors.lightGray
          .withAlpha(this.boolEnabled ? 255 : (255 * 0.40).round());
      iconAccessory = Icons.add;
    }

    // Check to see if the checkmark should be shown
    if (this.boolShowCheckmark) {
      colorAccessory = AaeColors.blue.withAlpha(255);
      iconAccessory = Icons.check;
    } else {
      colorAccessory = AaeColors.lightGray.withAlpha(195);
      iconAccessory = Icons.add;
    }

    // Check to see if the disclosure indicator should be shown
    if (this.boolShowAdd) {
      colorAccessory = AaeColors.ultraLightGray
          .withAlpha(this.boolEnabled ? 255 : (255 * 0.40).round());
      iconAccessory = Icons.add;
    }

    // Setup the accessory
    Container container = Container(
      child: Icon(
        iconAccessory,
        color: colorAccessory,
      ),
      padding: EdgeInsets.only(
        left: 8,
      ),
    );

    return this.boolShowCheckmark
        ? container
        : boolShowDisclosureIndicator ? container : Container();
  }
}