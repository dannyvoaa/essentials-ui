import 'package:aae/common/widgets/button/large_button.dart';
import 'package:aae/sign_in/component/login/login_bloc.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_view_model.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/sign_in/component/login/SharedPrefUtils.dart';

final authorizationEndpoint = Uri.parse("https://idpstage.aa.com/as/authorization.oauth2");
final tokenEndpoint = Uri.parse("https://idpstage.aa.com/as/token.oauth2");
final identifier = "aa_essentials_stage";
final secret = "x66rbjeC0Wh70qfrcxlAy6fPGGQ9fLBjA27mY7CWkzTPZkUB8YKNsreDwwufaIAt";
final redirectUrl = Uri.parse("aae://www.aa.com");
final _scopes = ['openid'];

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;
  final CacheService cache;

  LoginView({@required this.viewModel, this.cache, Key key}) : super(key: key) {}

  @override
  LoginViewState createState() {
    LoginViewState myloginState = LoginViewState();
    myloginState.settingViewModel(viewModel);
    return myloginState;
  }
}

class LoginViewState extends State<LoginView> {
  LoginViewModel viewModel;
  oauth2.AuthorizationCodeGrant grant;
  oauth2.Client _client;
  Uri _uri;
  LoginBloc loginBloc;

  void settingViewModel(LoginViewModel vm) {
    viewModel = vm;
  }

  @override
  void initState() {
    super.initState();
    grant = new oauth2.AuthorizationCodeGrant(identifier, authorizationEndpoint, tokenEndpoint, secret: secret);
    _uri = grant.getAuthorizationUrl(redirectUrl, scopes: _scopes);
    getUriLinksStream().listen((Uri uri) async {
      print("Init URL Listener: $uri");
      var client = await grant.handleAuthorizationResponse(uri.queryParameters);
      setState(() {
        _client = client;
      });
    });
  }


  signIn() async {
    var url = _uri.toString();
    await launch(url);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (_client?.credentials?.accessToken != null) {
      String strtoken = _client?.credentials?.accessToken.toString();
      SharedPrefUtils.saveStr('tokenvalue', strtoken);
      return Scaffold(
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
      );
    } else {
      signIn();
      return Scaffold(
      );
    }
  }

  /// Description text
  Widget _sectionDescription(
      {BuildContext buildContext,
        bool boolKeyboardVisible = false,
        bool boolCompactHeight = false}) {
    return Text(
      '',
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
        onTapAction: viewModel.onSignInButtonPressed,
        stringTitle: 'Continue',
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
  Widget _sectionWelcome2(
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
              'Taking you to sign-in page',
              style: AaeTextStyles.titleLarge(),
            ),
            Text(
              '',
              style: AaeTextStyles.subTitleLarge(),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
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
              'Login Success',
              style: AaeTextStyles.titleLarge(),
            ),
            Text(
              'Please click continue to access the app!',
              style: AaeTextStyles.subTitleLarge(),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }
}
