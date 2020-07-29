import 'package:aae/common/widgets/button/large_button.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

import 'welcome_view_model.dart';

/// A welcome splash screen that signed-out users see.
///
///
class WelcomeView extends StatelessWidget {
  final WelcomeViewModel viewModel;

  WelcomeView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
    child: Scaffold(
      backgroundColor: AaeColors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  _sectionWelcome(
                    buildContext: context,
                    boolCompactHeight:
                        AaeDimens.compactHeight(buildContext: context),
                  ),
                  _sectionDescription(
                    buildContext: context,
                    boolCompactHeight:
                        AaeDimens.compactHeight(buildContext: context),
                  ),
                  _sectionSignInButton(
                    buildContext: context,
                    boolCompactHeight:
                        AaeDimens.compactHeight(buildContext: context),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              margin: AaeDimens.pageMarginLarge,
            ),
          ),
        ],
      ),
    )
    );
  }

  /// Description text
  Widget _sectionDescription(
      {BuildContext buildContext,
      bool boolKeyboardVisible = false,
      bool boolCompactHeight = false}) {
    return Text(
      'Please sign in using your company credentials to enjoy your mobile work space',
      textAlign: TextAlign.center,
      style: AaeTextStyles.description(),
    );
  }

  /// Sign in button
  Widget _sectionSignInButton(
      {BuildContext buildContext,
      bool boolKeyboardVisible = false,
      bool boolCompactHeight = false}) {
    return Container(
      child: LargeButton(
        onTapAction: viewModel.onPrimaryButtonPressed,
        stringTitle: 'Get Started',
      ),
      width: double.infinity,
      padding: EdgeInsets.only(
        top: AaeDimens.sizeDynamic_32px(
            boolCompact: boolCompactHeight,
            boolKeyboardVisible: boolKeyboardVisible),
        bottom: AaeDimens.sizeDynamic_32px(
            boolCompact: boolCompactHeight,
            boolKeyboardVisible: boolKeyboardVisible),
      ),
    );
  }

  /// Flight Symbol and welcome text
  Widget _sectionWelcome(
      {BuildContext buildContext,
      bool boolKeyboardVisible = false,
      bool boolCompactHeight = false}) {
    // Check to see if the logo should be returned
    if (boolCompactHeight && boolKeyboardVisible) {
      return Container();
    } else {
      return Expanded(
        child: Column(
          children: <Widget>[
            Hero(
              child: Image.asset(
                'assets/common/flight_symbol.png',
                width: AaeDimens.sizeDynamic_128px(),
              ),
              tag: 'aaFlightSymbol',
            ),
            SizedBox(
              height: AaeDimens.sizeDynamic_48px(),
            ),
            Text(
              'Welcome',
              style: AaeTextStyles.titleLarge(),
            ),
            Text(
              'to American Essentials',
              style: AaeTextStyles.subTitleLarge(),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }
}
