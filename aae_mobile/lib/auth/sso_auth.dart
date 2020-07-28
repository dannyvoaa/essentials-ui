import 'dart:async';
import 'dart:convert';

import 'package:aae/auth/sso_auth_constants.dart' as sso_auth_constants;
import 'package:aae/cache/cache_service.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:aae/sign_in/component/login/SharedPrefUtils.dart';

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
      'Fleet',
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

  Future<void> signIn() async {
    try {
      String tokenvalue = _cache.readString("tokenvalue").value;
      var jwt = tryParseJwt(tokenvalue);
      print(jwt);

      SSOIdentity _user = new SSOIdentity(
        tokenvalue,
        jwt['email'],
        jwt['uid'],
        '',
        jwt['fullname'],
        jwt['location'],
        'Fleet',
      );

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
