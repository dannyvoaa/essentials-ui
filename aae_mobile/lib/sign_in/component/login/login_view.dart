import 'package:aae/common/widgets/button/large_button.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'login_view_model.dart';

/// A login screen that signed-out users see.


class LoginView extends StatefulWidget {
//  LoginView({Key key}) : super(key: key);

  final LoginViewModel viewModel;
  final bool textFocus;
  final _keyboardVisible = KeyboardVisibilityNotification();
  final FocusNode _textFieldFocusNode = FocusNode();
  final _focusSubject = createBehaviorSubject<bool>();
  final ScrollController _scrollController = ScrollController();
  final _textEditingController = TextEditingController();
  final authType = "FaceID";

  void _textFieldHasFocus(FocusNode textFocus) {
//    print('keyboard visible');
  }

  LoginView({@required this.viewModel, this.textFocus, Key key}) : super(key: key) {
    combineLatest(
      Observable.just(_textFieldFocusNode),
      _textFieldHasFocus,
    );
    Observable.just(_keyboardVisible);
    _focusSubject.distinctUntilChanged();
  }

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState = false;
  double _logoHeight = 180;

  Size screenSize (BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double logoBox (BuildContext context, {double dividedBy = 1}) {
    return (screenSize(context).height)/dividedBy;
  }

  @protected
  void initState() {
    super.initState();

    _keyboardState = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
          _logoHeight = _keyboardState ? 100 : logoBox(context, dividedBy: 3.2);
        });
        print(visible);
        print(logoBox);
      },
    );

//    double _logoHeight = logoBox(context, dividedBy: 2);
  }

  @override
  void dispose() {
    super.dispose();
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
//                color:AaeColors.lightOrange,
                child: Container(),
//                height: 300,
              ),
              Container(
                color: AaeColors.white,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        'This is a placeholder for the privacy statement. A privacy statement will go here once it is written and approved, but for the time being, this is only a placeholder.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:AaeColors.ultraLightGray,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AaeColors.blue,
//            image: DecorationImage(
//              alignment: Alignment.topCenter,
//              fit: BoxFit.fitHeight,
//              image: AssetImage('assets/common/sign_in_background.png'),
//            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 36.0, bottom: 36.0, top: 0.0,),
//            child: CustomScrollView(
//              controller: _scrollController,
//              slivers: <Widget>[
//                _sectionLogo(context),
//                _buildLoginTextFields(context),
//              ],
//            ),
            child: Column(
              children: <Widget>[
                _sectionLogoStatic(context),
                _buildLoginTextFieldsStatic(context),
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

  Widget _buildLoginTextFieldsStatic(BuildContext context) {
    return Container(
//      color: AaeColors.white,
      decoration: BoxDecoration(
//        color: AaeColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
//              color: AaeColors.lightGray,
            offset: Offset(0.0, 0.0),
            blurRadius: 4,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          color: AaeColors.white,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                Text(
                  'AA ID',
                  style: AaeTextStyles.textFieldTitle(),
                ),
                TextField(
                  style: AaeTextStyles.textFieldModern(),
                  onChanged: widget.viewModel.onUsernameChanged,
                ),
                Divider(
                  color: AaeColors.lightGray,
                  height: 0,
                ),
                SizedBox(
                  height: AaeDimens.sizeDynamic_32px(),
                ),
                Text(
                  'Password',
                  style: AaeTextStyles.textFieldTitle(),
                ),
                TextField(
                  obscureText: true,
                  style: AaeTextStyles.textFieldModern(),
                  onChanged: widget.viewModel.onPasswordChanged,
                ),
                Divider(
                  color: Colors.white,
                  height: 0,
                ),
                SizedBox(
                  height: AaeDimens.sizeDynamic_32px(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 20,
                    right: 20,
                    bottom: 24,
                  ),
                  child: _buildSigninButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTextFields(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        SizedBox(
          height: AaeDimens.sizeDynamic_32px(),
        ),
        TextField(
          decoration: InputDecoration.collapsed(
              hintText: 'AA ID',
              hintStyle: AaeTextStyles.textFieldModernHint()),
          style: AaeTextStyles.textFieldModern(),
          onChanged: widget.viewModel.onUsernameChanged,
        ),
        Divider(
          color: Colors.white,
          height: 0,
        ),
        SizedBox(
          height: AaeDimens.sizeDynamic_32px(),
        ),
        TextField(
//          focusNode: _textFieldFocusNode,
          decoration: InputDecoration.collapsed(
              hintText: 'Password',
              hintStyle: AaeTextStyles.textFieldModernHint()),
          obscureText: true,
          style: AaeTextStyles.textFieldModern(),
          onChanged: widget.viewModel.onPasswordChanged,
        ),
        Divider(
          color: Colors.white,
          height: 0,
        ),
        SizedBox(
          height: AaeDimens.sizeDynamic_32px(),
        ),
        _buildSigninButton(context),
      ]),
    );
  }

  /// American Airlines logo in a resizable widget

  Widget _sectionLogoStatic(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0,bottom:10,),
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: Duration(
          milliseconds: 300,
        ),
        height: _keyboardState ? 90 : logoBox(context, dividedBy: 3.5),
//        height: 180,
//        height: _logoHeight,
//        height: 80,
        child: Image(
          image: AssetImage('assets/common/logo_inverted_horizontal.png'),
        ),
      ),
    );
  }

  Widget _sectionLogo(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          height: AaeDimens.workflowLargeIconSize,
//        height:300,
          child: Image(
            image: AssetImage('assets/common/logo_inverted_horizontal.png'),
          ),
        ),
      ),
    );
  }

  Widget _buildSigninButton(BuildContext context) {
    return Container(
      child: LargeButton(
        boolEnabled: widget.viewModel.signInButtonEnabled,
        onTapAction: () {
          widget.viewModel.onSignInButtonPressed();
        },
        stringTitle: 'Sign in',
      ),
      width: double.infinity,
      height: 48,
    );
  }

  Widget _buildAuthentificationSignIn(BuildContext context) {
    return Container(
      child: LargeButton(
        boolEnabled: widget.viewModel.biometricAuthEnabled,
        onTapAction: () {
          widget.viewModel.onBiometricAuthPressed();
        },
        stringTitle: 'Sign in with biometrics!',
      ),
      width: double.infinity,
    );
  }
}
