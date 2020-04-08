import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class TableCellTitleValue extends StatelessWidget {
  // Setup any required variables
  final bool boolBorderBottom;
  final bool boolBorderTop;
  final bool boolShowCheckmark;
  final bool boolShowDisclosureIndicator;
  final bool boolEnabled;
  final String stringTitle;
  final String stringValue;
  final void Function() onTapAction;

  // Initialize the widget
  TableCellTitleValue({
    this.boolBorderBottom = true,
    this.boolBorderTop = false,
    this.stringTitle = '',
    this.onTapAction,
    this.boolEnabled = true,
    this.boolShowCheckmark = false,
    this.boolShowDisclosureIndicator = false,
    this.stringValue = '',
  });

  @override
  Widget build(BuildContext context) {
    const tableRowLeftPadding = AaeDimens.tallListViewPadding;
    const tableRowRightPadding = AaeDimens.tallListViewPadding;
    const tableRowTopPadding = AaeDimens.tallListViewPadding;
    const tableRowBottomPadding = AaeDimens.tallListViewPadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: boolBorderTop,
          child: Divider(
            color: AaeColors.lightGray,
            height: AaeDimens.sizeDivider,
          ),
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(
              top: tableRowTopPadding,
              bottom: tableRowBottomPadding,
            ),
            child: TableCell(
              verticalAlignment: TableCellVerticalAlignment.fill,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: tableRowLeftPadding),
                    child: Text(
                      stringTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AaeTextStyles.tableCellTitle(
                        boolEnabled: this.boolEnabled,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: tableRowRightPadding),
                    child: Text(
                      stringValue,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AaeTextStyles.tableCellValue(
                        boolEnabled: this.boolEnabled,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  _cellAccessory(),
                ],
              ),
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
        Visibility(
          visible: boolBorderBottom,
          child: Divider(
            color: AaeColors.lightGray,
            height: AaeDimens.sizeDivider,
          ),
        ),
      ],
    );
  }

  /// If boolShowDisclosureIndicator == true, the disclosure indicator will be displayed
  Widget _cellAccessory() {
    Color colorAccessory;
    IconData iconAccessory;

    // Check to see if the checkmark should be shown
    if (this.boolShowCheckmark) {
      colorAccessory = AaeColors.blue
          .withAlpha(this.boolEnabled ? 255 : (255 * 0.40).round());
      iconAccessory = Icons.check;
    }

    // Check to see if the disclosure indicator should be shown
    if (this.boolShowDisclosureIndicator) {
      colorAccessory = AaeColors.lightGray
          .withAlpha(this.boolEnabled ? 255 : (255 * 0.40).round());
      iconAccessory = Icons.chevron_right;
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
