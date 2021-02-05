import 'package:aae/common/widgets/workflow_page/workflow_footer_button/workflow_footer_button.dart';
import 'package:aae/common/widgets/workflow_page/workflow_page_template.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';

import 'sign_in_failed_view_model.dart';
import 'package:flutter/material.dart';

/// View indicating to the user that their sign in attempt has failed and giving
/// the option to log in as a different user.

class SignInFailedView extends StatelessWidget {
  final SignInFailedViewModel viewModel;

  SignInFailedView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AaeColors.black,
      child: Column(
        children: <Widget>[
          Icon(
            Icons.error_outline,
            size: AaeDimens.signInFailureIconSize,
          ),
          Expanded(
            child: WorkflowPageTemplate(
              title: 'Sign in failed',
              body:
                  'Usually this means that you are not authorized to use this app.',
              primaryButtonText: 'Try again',
              onPrimaryButtonTapped: viewModel.onPrimaryButtonPressed,
              footerButtonLayout: ButtonLayout.vertical,
            ),
          ),
        ],
      ),
    );
  }
}
