import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Processing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              CircularProgressIndicator(
                strokeWidth: Dimensions.size2px,
              ),
              Expanded(
                child: Container(),
              ),
              SizedBox(
                height: Dimensions.size8px,
              ),
              Text(
                'One Moment',
                style: TextStyles.processing(),
              ),
              SizedBox(
                height: Dimensions.size8px,
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.size8px,
            ),
            color: BrandColors.white,
          ),
          height: Dimensions.size128px,
          width: Dimensions.size128px,
        ),
      ),
      color: CustomColors.transparent,
    );
  }

  /// Hide the Processing view
  static void dismiss({@required BuildContext buildContext}) {
    // Hide the processing view
    Navigator.of(buildContext, rootNavigator: true).pop();
  }

  /// Show the Processing view
  static void showProcessingView({@required BuildContext buildContext, bool animated = true}) {
    // Show the processing view
    showGeneralDialog(
      transitionDuration: Duration(milliseconds: animated ? 150 : 0),
      barrierColor: Colors.black54,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(buildContext).modalBarrierDismissLabel,
      context: buildContext,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Processing();
      },
      useRootNavigator: true,
    );
  }
}
