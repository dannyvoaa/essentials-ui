import 'dart:convert';
import 'dart:io';
import 'package:aae/common/widgets/button/large_button.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_bloc.dart';
import 'login_settings.dart';
import 'login_view_model.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/sign_in/component/login/SharedPrefUtils.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

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
    //print('NetUtils : $url');
    http.Response response = await http.get(url);
    return response.body;
  }

  static Future<String> post(String url, Map<String, dynamic> bodyparams, Map<String, String> headerparams) async {
    //print('NetUtils : $url');
    http.Response response = await http.post(url, body: bodyparams, headers: headerparams);
    return response.body;
  }
}

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;
  final CacheService cache;
  final LoginBloc bloc;

  LoginView({@required this.viewModel, this.cache, this.bloc, Key key}) : super(key: key) {}

  @override
  LoginViewState createState() {
    LoginViewState myloginState = LoginViewState();
    myloginState.settingVCB(viewModel, cache, bloc );
    return myloginState;
  }
}

class LoginViewState extends State<LoginView> {
  LoginViewModel viewModel;
  CacheService cache;
  LoginBloc bloc;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  LoginSettings myloginSettings = new LoginSettings();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  String strUrl;

  String code;
  String token;

  void settingVCB(LoginViewModel vm, CacheService cs, LoginBloc lb) {
    this.viewModel = vm;
    this.cache = cs;
    this.bloc = lb;
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
        _getAllCookies(state.url, "2");
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
        //_getAllCookies(url, "1");
        setState(() {
          //print("URL changed: $url");
          if (url.startsWith("aae://www.aa.com")) {
            if (url.contains("code=")) {
              this.code = url.replaceAll("aae://www.aa.com?code=", "");
              //print("code: $code");
              this.strUrl = url;

              Map<String, dynamic> bodyparams = Map<String, dynamic>();
              bodyparams['grant_type'] = 'authorization_code';
              bodyparams['redirect_uri'] = myloginSettings.redirectUri;
              bodyparams['code'] = '$code';
              bodyparams['dataType'] = 'application/x-www-form-urlencoded';

              Map<String, String> headerparams = Map<String, String>();
              headerparams['Authorization'] = myloginSettings.authorizationSecret;
              NetUtils.post(myloginSettings.tokenEndpoint, bodyparams, headerparams).then((data) {
                this.token = data;
                //print('--------data:$data');
                if (data != null) {
                  Map<String, dynamic> map = json.decode(data);
                  if (map != null && map.isNotEmpty) {
                    this.token = map["access_token"];
                    print('--------token saved');
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

  Future<Null> _getAllCookies(String url, String message) async {
    //print(url);
    try {
      final String result = await flutterWebviewPlugin.getAllCookies(url);

      //print(result);
      if ((result != null) && (result.contains(";"))){
        var rawCookieParams = result.split(";");
        if ((rawCookieParams[0] != null) && (rawCookieParams[0].contains("="))) {
          for (int i = 1; i < rawCookieParams.length; i++) {
            var rawCookieParamNameAndValue = rawCookieParams[i].trim().split("=");
            String paramName = rawCookieParamNameAndValue[0].trim();
            String paramValue = rawCookieParamNameAndValue[1].trim();
            //print(paramName + message + ": " + paramValue);
            if (paramName == 'SMSESSION') {
              //print(paramName + message + ": " + paramValue);

              if (paramValue.length > 50) {
                String smsession = 'SMSESSION=$paramValue';
                SharedPrefUtils.saveStr('SMSESSION', smsession);
              }
            }
          }
        }
      }
    } on PlatformException catch (e) {
        print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //print('********Inside Build value of strUrl:$strUrl**********');
    if ((strUrl == null) || (strUrl == "")) {
      return WebviewScaffold(url: myloginSettings.authUrl, withJavascript: true, useWideViewPort: true, ignoreSSLErrors: true, scrollBar: false, hidden: true, initialChild: Container(
        child: const Center(
          child: AaeLoadingSpinner(),
        ),
      ),);
    }
    sleep(Duration(milliseconds:250));
    bloc.loginInProgress.sendNext(true);
    bloc.signIn();

    //return FlatButton(child: Text('Continue'), onPressed: viewModel.onSignInButtonPressed);
    return new Scaffold();
  }
}
