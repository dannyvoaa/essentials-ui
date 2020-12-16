import 'package:aae/main.dart';
import 'package:aae/programmatic_main.dart';

import '../../../build_flavor.dart';

class LoginSettings {
  String authorizationEndpoint;
  String tokenEndpoint;
  String identifier;
  String secret;
  String authorizationSecret;
  String redirectUri;
  String scopes;
  String logoutEndpoint;
  String authUrl;

  LoginSettings() {
    if (buildFlavor.name == "production") {
      authUrl = "https://idp.aa.com/as/authorization.oauth2?response_type=code&client_id=aa_essentials_prod&redirect_uri=aae://www.aa.com&scope=openid";
      authorizationEndpoint = "https://idp.aa.com/as/authorization.oauth2";
      tokenEndpoint = "https://idp.aa.com/as/token.oauth2";
      identifier = "aa_essentials_prod";
      secret = "XdEh3sq3ewreA8GuOpGqUHr7NTBQFgTxx8wYPFHnG9nUbxH9QVMVatzmiRsyJhzm";
      authorizationSecret = 'Basic YWFfZXNzZW50aWFsc19wcm9kOlhkRWgzc3EzZXdyZUE4R3VPcEdxVUhyN05UQlFGZ1R4eDh3WVBGSG5HOW5VYnhIOVFWTVZhdHptaVJzeUpoem0=';
      redirectUri = "aae://www.aa.com";
      scopes = "['openid']";
      logoutEndpoint = "https://smlogin.aa.com/login/SMLogout.jsp";
    } else if (buildFlavor.name == "preprod") {
      authUrl = "https://idpstage.aa.com/as/authorization.oauth2?response_type=code&client_id=aa_essentials_stage&redirect_uri=aae://www.aa.com&scope=openid";
      authorizationEndpoint = "https://idpstage.aa.com/as/authorization.oauth2";
      tokenEndpoint = "https://idpstage.aa.com/as/token.oauth2";
      identifier = "aa_essentials_stage";
      secret = "x66rbjeC0Wh70qfrcxlAy6fPGGQ9fLBjA27mY7CWkzTPZkUB8YKNsreDwwufaIAt";
      authorizationSecret = 'Basic YWFfZXNzZW50aWFsc19zdGFnZTp4NjZyYmplQzBXaDcwcWZyY3hsQXk2ZlBHR1E5ZkxCakEyN21ZN0NXa3pUUFprVUI4WUtOc3JlRHd3dWZhSUF0';
      redirectUri = "aae://www.aa.com";
      scopes = "['openid']";
      logoutEndpoint = "https://smlogin.stage.aa.com/login/SMLogout.jsp";
    } else if (buildFlavor.name == "debug") {
      authUrl = "https://idpstage.aa.com/as/authorization.oauth2?response_type=code&client_id=aa_essentials_stage&redirect_uri=aae://www.aa.com&scope=openid";
      authorizationEndpoint = "https://idpstage.aa.com/as/authorization.oauth2";
      tokenEndpoint = "https://idpstage.aa.com/as/token.oauth2";
      identifier = "aa_essentials_stage";
      secret = "x66rbjeC0Wh70qfrcxlAy6fPGGQ9fLBjA27mY7CWkzTPZkUB8YKNsreDwwufaIAt";
      authorizationSecret = 'Basic YWFfZXNzZW50aWFsc19zdGFnZTp4NjZyYmplQzBXaDcwcWZyY3hsQXk2ZlBHR1E5ZkxCakEyN21ZN0NXa3pUUFprVUI4WUtOc3JlRHd3dWZhSUF0';
      redirectUri = "aae://www.aa.com";
      scopes = "['openid']";
      logoutEndpoint = "https://smlogin.stage.aa.com/login/SMLogout.jsp";
    }

  }
}