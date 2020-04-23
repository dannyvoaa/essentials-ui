import 'package:aae/common/widgets/button/large_button.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

import 'login_view_model.dart';

/// A login screen that signed-out users see.
///
class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;

  final FocusNode _textFieldFocusNode = FocusNode();

  final bool textFocus;
  final _focusSubject = createBehaviorSubject<bool>();
  final ScrollController _scrollController = ScrollController();

  final _textEditingController = TextEditingController();

  final authType = "FaceID";

  LoginView({@required this.viewModel, this.textFocus}) {
    combineLatest(
      Observable.just(_textFieldFocusNode),
      _textFieldHasFocus,
    );
    _focusSubject.distinctUntilChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AaeColors.backgroundBlue,
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/common/sign_in_background.png'),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                _sectionLogo(context),
                _buildLoginTextFields(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInOptions(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
//          _buildAuthentificationSignIn(context),
          _buildSigninButton(context),
        ],
      ),
    );
  }

  void _textFieldHasFocus(FocusNode textFocus) {}

  Widget _buildLoginTextFields(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        SizedBox(
          height: AaeDimens.sizeDynamic_32px(),
        ),
        _buildSigninButton(context),
        TextField(
          decoration: InputDecoration.collapsed(
              hintText: 'AA ID?',
              hintStyle: AaeTextStyles.textFieldModernHint()),
          style: AaeTextStyles.textFieldModern(),
          onChanged: viewModel.onUsernameChanged,
        ),
        Container(
          color: AaeColors.white,
          height: 2,
        ),
        SizedBox(
          height: AaeDimens.sizeDynamic_32px(),
        ),
        TextField(
          // focusNode: _textFieldFocusNode,
          decoration: InputDecoration.collapsed(
              hintText: 'Password?',
              hintStyle: AaeTextStyles.textFieldModernHint()),
          obscureText: true,
          style: AaeTextStyles.textFieldModern(),
          onChanged: viewModel.onPasswordChanged,
        ),
        Container(
          color: AaeColors.white,
          height: 2,
        ),
//        Spacer(flex: 2,),
//        _buildAuthentificationSignIn(context),
        SizedBox(
          height: AaeDimens.sizeDynamic_32px(),
        ),
        Spacer(flex: 2,),

        Spacer(flex: 2,),
      ]),
    );
  }

  /// American Airlines logo in a resizable widget
  Widget _sectionLogo(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: AaeDimens.workflowLargeIconSize,
        child: Image(
          image: AssetImage('assets/common/logo_inverted_horizontal.png'),
        ),
      ),
    );
  }

  Widget _buildSigninButton(BuildContext context) {
    return Container(
      child: LargeButton(
        boolEnabled: viewModel.signInButtonEnabled,
        onTapAction: () {
          viewModel.onSignInButtonPressed();
        },
        stringTitle: 'Sign in',
      ),
      width: double.infinity,
      height: 80,
    );
  }

  Widget _buildAuthentificationSignIn(BuildContext context) {
    return Container(
      child: LargeButton(
        boolEnabled: viewModel.biometricAuthEnabled,
        onTapAction: () {
          viewModel.onBiometricAuthPressed();
        },
        stringTitle: 'Sign in with biometrics!',
      ),
      width: double.infinity,
    );
  }
}
