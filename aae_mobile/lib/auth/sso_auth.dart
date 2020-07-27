import 'dart:async';
import 'dart:convert';

import 'package:aae/auth/sso_auth_constants.dart' as sso_auth_constants;
import 'package:aae/cache/cache_service.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

import 'sso_identity.dart';

class SSOAuth {
  static final _log = Logger('SSOAuth');

  static const currentUserAuthKey = 'SSOSSOAuth.lastUser';

  final CacheService _cache;

  @provide
  @singleton
  SSOAuth(
    this._cache,
  );

  final _currentUserController = StreamController<SSOIdentity>.broadcast();

  /// Subscribe to this stream to be notified when the current user changes.
  Stream<SSOIdentity> get onCurrentUserChanged => _currentUserController.stream;

  SSOIdentity _setCurrentUser(SSOIdentity currentUser) {
    if (currentUser != _currentUser) {
      _currentUser = currentUser;
      _currentUserController.add(_currentUser);
    }
    return _currentUser;
  }

  /// The currently signed in account, or null if the user is signed out
  // TODO: (kiheke) - Implement in memory log-out
  SSOIdentity _currentUser;

  SSOIdentity get currentUser => _currentUser;

  _returnUser(vars) {
    var cachedUser = tryParseJwt(vars);

    print(cachedUser);
    print("-------------------------------${cachedUser['preferred_username']}-----------------");
    //cachedUser['userlocation'],cachedUser['userworkgroup'],
    SSOIdentity _user = new SSOIdentity(
      cachedUser['access_token'],
      cachedUser['email'],
      cachedUser['preferred_username'],
      cachedUser['refresh_token'],
      cachedUser['name'],
      'DFW',
      'Leadership and Support Staff',
    );
    _setCurrentUser(_user);
    return _user;
  }

  signInSilently() {
    _cache.readString(currentUserAuthKey).ifPresent(_returnUser);
    return _cache.readString(currentUserAuthKey).ifAbsent(() {
      return null;
    });
  }

  Map<String, dynamic> tryParseJwt(String token) {
    if (token == null) return null;
    final parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var jwt = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(jwt);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }

  /// Retrieves tokens and user profile, signs in user
  Future<void> signIn(String username, String password, String token) async {
    try {
      //var client = await oauth2.resourceOwnerPasswordGrant(Uri.parse(sso_auth_constants.ACCESS_TOKEN_URL), 'username', 'password', identifier: sso_auth_constants.CLIENT_ID, secret: sso_auth_constants.CLIENT_SECRET, scopes: sso_auth_constants.SCOPE);
      token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IkFFIiwicGkuYXRtIjoiYzl1NiJ9.eyJzY29wZSI6Im9wZW5pZCIsImNsaWVudF9pZCI6ImFhX2Vzc2VudGlhbHNfc3RhZ2UiLCJpc3MiOiJodHRwczovL2lkcHN0YWdlLmFhLmNvbSIsImp0aSI6IlFacVQ3bTFLIiwidWlkIjoiMDA2MjgyMzAiLCJsb2NhdGlvbiI6IkhEUSIsImFtcm9yZ3VuaXRkZXNjcmlwdGlvbiI6IkxlYWRlcnNoaXAgYW5kIFN1cHBvcnQgU3RhZmYiLCJmdWxsbmFtZSI6IkFTSUYiLCJlbWFpbCI6ImFzaWYubW9oYW1tZWRAYWEuY29tIiwiZXhwIjoxNTk1Mzc2OTc4fQ.TKgN-JsMdcTkAss7cTAXgEV4Ddmo9ZH_Bm361T23kWZMpUaPZ3F_hvYqigmC1Om7ei0LdOk8svWerBCpkLm9GRCvv4Sm-ish7MfsxmUt9rXll_SW6OpNcq7X0cidEQ3Wjw2lAR2REzqRDIThZHyR9QFDrk-OkPh5eqzNVZzd-nHxTZbR8fMMM8Fw6HdSt7syTkxoLYpgLxQLroayHh-OA_DL-pelf7YkmNJ7XW_AQ6c_nYMuld7oTtHUE5ZxxKuXQor0f1jvK6c8RxxnWzA-vgjCA31TEsap9MBJNNSuc_Jx_tyQJoy_FoPaR_sTc9YLmSR51wxvNien21oZJY6WlQ";
      var jwt = tryParseJwt(token);
      print(jwt);

      //jwt['userlocation'],jwt['userworkgroup'],jwt['given_name'], jwt['family_name']
      SSOIdentity _user = new SSOIdentity(
        token,
        jwt['email'],
        jwt['preferred_username'],
        '',
        jwt['name'],
        'DFW',
        'Leadership and Support Staff',
      );

      //TODO: Asif
      //_cache.writeString(currentUserAuthKey, client.credentials.idToken);

      _setCurrentUser(_user);
      // Wait for sign in flow to complete.

    } on Exception catch (e, s) {
      _log.severe('Error signing in with SSO:', e, s);
      throw TokenException('Error signing in with SSO:', e);
    }
  }
}

/// Thrown when there is an issue retrieving the access token.
class TokenException implements Exception {
  final String message;
  final dynamic piggyback;

  TokenException([this.message, this.piggyback]);

  String toString() => 'TokenException: $message';
}
