import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';

class Alerts {
  /// Creates an alert dialog with the specified title, message and buttons
  static Widget _alert({
    @required BuildContext buildContext,
    @required String stringTitle,
    @required String stringMessage,
    @required Map<String, Color> mapButtons,
  }) {
    // Setup any required variables
    List<Widget> _listButtons = List<Widget>();

    // Iterate through each string in the list of strings
    for (String stringKey in mapButtons.keys) {
      // Add a button
      _listButtons.add(
        // Constrain the Raised Button in a Container; that way the Raised Button doesn't add additional padding to it's top and bottom
        Container(
          child: RoundedButton(
            child: Text(stringKey),
            color: mapButtons[stringKey],
            onPressed: () {
              // Pop the view and return the text of the selected button
              Navigator.pop(buildContext, stringKey);
            },
          ),
          height: Dimensions.buttonHeight,
          margin: EdgeInsets.only(
            left: Dimensions.size16px,
          ),
        ),
      );
    }

    return Material(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                stringTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.title1(),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: Dimensions.size16px,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(stringMessage),
                ),
              ),
              SizedBox(
                height: Dimensions.size32px,
              ),
              Row(
                children: _listButtons,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          constraints: BoxConstraints(
            maxHeight: Dimensions.size256px + Dimensions.size128px,
            maxWidth: Dimensions.size256px + Dimensions.size128px,
            minWidth: Dimensions.size256px + Dimensions.size128px,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.size8px,
            ),
            color: BrandColors.white,
          ),
          padding: EdgeInsets.all(
            Dimensions.size16px,
          ),
        ),
      ),
      color: CustomColors.transparent,
    );
  }

  /// Presents the passed dialog modally
  static Future<Object> _presentDialog({
    @required BuildContext buildContext,
    @required Widget widget,
  }) async {
    // Show the alert dialog and await a result
    var result = await showDialog(
      builder: (BuildContext buildContext) {
        return widget;
      },
      context: buildContext,
    );

    return result;
  }

  // MARK: - Specific alert dialogs

  /// Creates an alert dialog verifying that the user would like to delete an object
  static Future<Object> delete({
    @required BuildContext buildContext,
    @required String stringObject,
  }) async {
    // Declare any strings used by this button
    String stringDeleteButton = 'Delete';
    String stringCancelButton = 'Cancel';

    // Present the dialog
    return _presentDialog(
      buildContext: buildContext,
      widget: _alert(
        buildContext: buildContext,
        stringTitle:
            'Delete ${stringObject.substring(0, 1).toUpperCase() + stringObject.substring(1).toLowerCase()}',
        stringMessage:
            'Are you sure that you want to delete this ${stringObject.toLowerCase()}?',
        mapButtons: {
          stringCancelButton: null,
          stringDeleteButton: BrandColors.red,
        },
      ),
    );
  }

  /// Creates an error dialog that indicates that an error has occured
  static Future<Object> error({
    @required BuildContext buildContext,
  }) {
    // Declare any strings used by this button
    String stringOkButton = 'OK';

    // Present the dialog
    return _presentDialog(
      buildContext: buildContext,
      widget: _alert(
        buildContext: buildContext,
        stringTitle: 'Error',
        stringMessage:
            'An unknown error occured while attempting to process your request. Please try again in a moment.',
        mapButtons: {
          stringOkButton: null,
        },
      ),
    );
  }

  /// Creates an alert dialog with the specified title, message and an OK button
  static Future<Object> generic({
    @required BuildContext buildContext,
    @required String stringTitle,
    @required String stringMessage,
  }) async {
    // Declare any strings used by this button
    String stringOkButton = 'OK';

    // Present the dialog
    return _presentDialog(
      buildContext: buildContext,
      widget: _alert(
        buildContext: buildContext,
        stringTitle: stringTitle,
        stringMessage: stringMessage,
        mapButtons: {
          stringOkButton: null,
        },
      ),
    );
  }

  /// Creates an alert dialog that indicates that the user's session is about to expire'
  static Future<Object> sessionExpiration({
    @required BuildContext buildContext,
  }) async {
    // Declare any strings used by this button
    String stringOkButton = 'Continue';
    String stringLogOutButton = 'Log Out';

    // Present the dialog
    return _presentDialog(
      buildContext: buildContext,
      widget: _alert(
        buildContext: buildContext,
        stringTitle: 'Session Expiration',
        stringMessage: 'Your session will expire in two minutes after which time you will be automatically logged out. You can choose to continue to keep working up until your session expires, or you can log out now.',
        mapButtons: {
          stringOkButton: null,
          stringLogOutButton: BrandColors.red,
        },
      ),
    );
  }
}
