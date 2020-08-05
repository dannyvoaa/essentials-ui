import 'dart:convert';
import 'package:aae/common/widgets/button/large_button.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_view_model.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/sign_in/component/login/SharedPrefUtils.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

final authorizationEndpoint = "https://idpstage.aa.com/as/authorization.oauth2";
final tokenEndpoint = "https://idpstage.aa.com/as/token.oauth2";
final identifier = "aa_essentials_stage";
final secret = "x66rbjeC0Wh70qfrcxlAy6fPGGQ9fLBjA27mY7CWkzTPZkUB8YKNsreDwwufaIAt";
final authorizationsecret = 'Basic YWFfZXNzZW50aWFsc19zdGFnZTp4NjZyYmplQzBXaDcwcWZyY3hsQXk2ZlBHR1E5ZkxCakEyN21ZN0NXa3pUUFprVUI4WUtOc3JlRHd3dWZhSUF0';
final redirectUri = "aae://www.aa.com";
final _scopes = ['openid'];
final logoutEndpoint = "https://smlogin.stage.aa.com/login/SMLogout.jsp";

class NetUtils {
  static Future<String> get(String url, Map<String, dynamic> params) async {
    if (url != null && params != null && params.isNotEmpty) {
      StringBuffer sb = StringBuffer('?');
      params.forEach((key, value) {
        sb.write('$key=$value&');
      });
      String paramStr = sb.toString().substring(0, sb.length - 1);
      url += paramStr;
    }
    print('NetUtils : $url');
    http.Response response = await http.get(url);
    return response.body;
  }

  static Future<String> post(String url, Map<String, dynamic> bodyparams, Map<String, String> headerparams) async {
    print('NetUtils : $url');
    http.Response response = await http.post(url, body: bodyparams, headers: headerparams);
    return response.body;
  }
}

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
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  String authUrl = "https://idpstage.aa.com/as/authorization.oauth2?response_type=code&client_id=aa_essentials_stage&redirect_uri=aae://www.aa.com&scope=openid";
  String redirectUrl = "aae://www.aa.com";

  String strUrl;

  String code;
  String token;

  void settingViewModel(LoginViewModel vm) {
    viewModel = vm;
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      //print("destroy");
    });

    _onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if(state.type== WebViewState.finishLoad){ // if the full website page loaded
          //print("------------loaded...");
        }else if (state.type== WebViewState.abortLoad){ // if there is a problem with loading the url
          //print("------------there is a problem...");
        } else if(state.type== WebViewState.startLoad){ // if the url started loading
          //print("------------start loading...");
        }
      }
          //print("onStateChanged: ${state.type} ${state.url}");
        });
    _onHttpError =
        flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error) {
          if (mounted) {
            //print('onHttpError: ${error.code}-${error.url}');
          }
        });
    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {

      if (mounted) {
        setState(() {
          //print("URL changed: $url");
          if (url.startsWith("aae://www.aa.com")) {
            if (url.contains("code=")) {
              this.code = url.replaceAll("aae://www.aa.com?code=", "");
              //print("code: $code");
              this.strUrl = url;

              Map<String, dynamic> bodyparams = Map<String, dynamic>();
              bodyparams['grant_type'] = 'authorization_code';
              bodyparams['redirect_uri'] = redirectUri;
              bodyparams['code'] = '$code';
              bodyparams['dataType'] = 'application/x-www-form-urlencoded';

              Map<String, String> headerparams = Map<String, String>();
              headerparams['Authorization'] = authorizationsecret;
              NetUtils.post(tokenEndpoint, bodyparams, headerparams).then((data) {
                this.token = data;
                //print('$data');
                if (data != null) {
                  Map<String, dynamic> map = json.decode(data);
                  if (map != null && map.isNotEmpty) {
                    this.token = map["access_token"];
                    //print('$token');
                    SharedPrefUtils.saveStr('tokenvalue', token);
                  }
                }
              });

              flutterWebviewPlugin.close();
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('********Inside Build value of strUrl:$strUrl**********');
    if ((strUrl == null) || (strUrl == "")) {
//      viewModel.onSignInButtonPressed;
      return WebviewScaffold(url: authUrl, withJavascript: true, useWideViewPort: true, ignoreSSLErrors: true, scrollBar: false, hidden: true, initialChild: Container(
        child: const Center(
          child: AaeLoadingSpinner(),
        ),
      ),);
    }
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
