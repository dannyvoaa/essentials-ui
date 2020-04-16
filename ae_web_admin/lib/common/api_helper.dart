import 'package:american_essentials_web_admin/common/alerts.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:flutter/material.dart';

class ApiHelper {
  static Future<void> execute({
    @required BuildContext buildContext,
    bool boolDismissProcessingOnError = false,
    @required HttpStatusCode httpStatusCode,
    Function onError,
    @required Function onSuccess,
    Function onUnauthorized,
  }) async {
    // Check to see which http status code was returned
    if (httpStatusCode == HttpStatusCode.Success) {
      // Execute the On Success action
      onSuccess();
    } else if (httpStatusCode == HttpStatusCode.Unauthorized) {
      // Check to see if a custom On Unauthorized function was specified
      if (onUnauthorized != null) {
        // Execute the custom On Unauthorized function
        onUnauthorized();
      } else {
        // Check to see if we should dismiss the Processing view
        if (boolDismissProcessingOnError) {
          // Hide the processing view
          Navigator.of(buildContext, rootNavigator: true).pop();
        }

        // Alert: Unauthorized
        Alerts.generic(
          buildContext: buildContext,
          stringTitle: 'Error',
          stringMessage:
              'It appears that your session has expired. Please sign out and then sign back in order to continue.',
        );
      }
    } else if (httpStatusCode == HttpStatusCode.Error) {
      // Check to see if acustom On Error function was specified
      if (onError != null) {
        // Execute the custom On Error function
        onError();
      } else {
        // Check to see if we should dismiss the Processing view
        if (boolDismissProcessingOnError) {
          // Hide the processing view
          Navigator.of(buildContext, rootNavigator: true).pop();
        }

        // Alert: Unknown Error
        Alerts.error(buildContext: buildContext);
      }
    }
  }
}
