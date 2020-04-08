import 'package:aae/common/widgets/workflow_page/workflow_footer_button/workflow_footer_button.dart';
import 'package:aae/common/widgets/workflow_page/workflow_page_template.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

import 'login_view_model.dart';

/// A login screen that signed-out users see.
///
class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;

  LoginView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return WorkflowPageTemplate(
      child: _buildNextStepsColumn(context),
      primaryButtonText: viewModel.primaryButtonText,
      onPrimaryButtonTapped: viewModel.onPrimaryButtonPressed,
      footerButtonLayout: ButtonLayout.vertical,
    );
  }

  Widget _buildNextStepsColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIconTitleAndBody(
          Icons.looks_one,
        ),
        _buildUserNameEntryField(context),
        _buildPasswordEntryField(context)
      ],
    );
  }

  Widget _buildIconTitleAndBody(IconData icon) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AaeDimens.baseUnit),
          child: Image.asset('assets/common/american-airlines-eaagle-logo.png'),
        ),
      ],
    );
  }

  Widget _buildUserNameEntryField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AaeDimens.baseUnit / 2),
      child: TextField(
        style: AaeTextStyles.b1SingleLine,
        autocorrect: false,
        decoration: InputDecoration(hintText: 'AA ID', filled: true),
      ),
    );
  }

  Widget _buildPasswordEntryField(BuildContext context) {
    return TextField(
      obscureText: true,
      style: AaeTextStyles.b1SingleLine,
      decoration: InputDecoration(filled: true, hintText: 'Password'),
    );
  }
}
