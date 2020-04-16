/// Library for request and caching OAuth2.0 access tokens.
/// Assumption: You are already authorized and have the refresh token,
/// client secret, client id.

import 'dart:async';
import 'dart:convert';

import 'package:aae/provided_service.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:http/http.dart' show Client;
import 'package:logging/logging.dart';
import 'package:quiver/time.dart';

import 'http_authentication.dart' as auth;
import 'sso_auth_constants.dart' as sso_auth_constants;
import 'sso_identity.dart';

/// Extends [auth.HttpAuthentication] with [ProvidedService] for widget lookup.
abstract class HttpAuthentication extends auth.HttpAuthentication
    implements ProvidedService {}

/// An [HttpAuthentication] implementation for when you absolutely don't care
/// about authentication.
class NoAuth implements HttpAuthentication {
  final String _token;

  const NoAuth({String token}) : _token = token;

  DateTime get expiration => null;

  bool get isExpired => false;

  /// Returns a fauxken, a fake oauth token.
  Future<String> token() => Future.value(_token);
}

/// Caches and maintains an active OAuth2 Access Token.
class OAuth2Token extends HttpAuthentication {
  static const Duration defaultTokenLife = Duration(days: 1);

  final String oauth2Url;
  final String clientId;
  final String clientSecret;
  final String refreshToken;
  final Duration maxTokenLife;
  final Clock clock;
  final Client httpClient = Client();
  final Logger log;

  /// Constructs a new OAuth2Token object.
  ///
  /// Users may override [log] as well as [clock] for testing purposes.
  OAuth2Token({
    this.oauth2Url = sso_auth_constants.ACCESS_TOKEN_URL,
    this.clientId,
    this.clientSecret,
    this.refreshToken,
    this.clock = const Clock(),
    this.maxTokenLife = defaultTokenLife,
    Logger log,
  }) : log = log ?? Logger('OAuth2');

  DateTime _expiration;

  DateTime get expiration => _expiration;

  bool get isExpired =>
      expiration != null && DateTime.now().isAfter(expiration);

  /// The current token.
  String _token;

  /// The time that the current token was created.
  DateTime _tokenTime;

  /// The time that the current token was created.
  DateTime get tokenTime => _tokenTime;

  /// Queues up multiple requests while a network request is ongoing.
  Future<String> work;

  /// Retrieves and/or updates the oauth2 token.
  Future<String> token() {
    if (refreshToken == null) return null;

    // The work is already being done, we should wait on it. This covers
    // initial conditions of not having a token / expiration.
    if (work != null) {
      log.info(() => "call for token() while work in progress");
      return work;
    }

    if (_token != null && !isExpired) {
      return Future.value(_token);
    }

    work = _refreshAccessToken().whenComplete(() {
      work = null;
    });

    return work;
  }

  Future<String> getAccessToken(String userName, String password) async {
    try {
      String payload = "grant_type=password&"
          "username=$userName&"
          "password=$password&"
          "scope=openid";

      log.fine(() => "oauth payload: $payload");

      var response = await httpClient
          .post(sso_auth_constants.ACCESS_TOKEN_URL, body: payload, headers: {
        'Content-Type': "application/x-www-form-urlencoded",
        'accept': "application/json",
        'authorization':
            "Basic ${base64Encode(utf8.encode('${sso_auth_constants.CLIENT_ID}:${sso_auth_constants.CLIENT_SECRET}'))}"
      });

      log.fine(response.body);

      if (response.statusCode != 200) {
        throw TokenException(
            "Invalid HTTP status ${response.statusCode}", response.statusCode);
      }
      _tokenTime = clock.now();
      Map vars = jsonDecode(response.body);
      _token = vars['access_token'];
      var expiresIn = vars['expires_in'];
      if (expiresIn is int) {
        _expiration = clock.fromNow(seconds: expiresIn);
      } else {
        _expiration = null;
      }
      log.fine(() => "new token $vars");
    } on TokenException {
      rethrow;
    } catch (e, s) {
      log.shout(() => "${('error with token() work')}:", e, s);
      throw TokenException("Error requesting access token", e);
    }
    return _token;
  }

  Future<String> _refreshAccessToken() async {
    try {
      String payload = "client_id=$clientId&"
          "client_secret=$clientSecret&"
          "refresh_token=$refreshToken&"
          "grant_type=refresh_token";
      log.fine(() => "oauth payload: $payload");
      var response = await httpClient.post(oauth2Url,
          body: payload,
          headers: {'Content-Type': "application/x-www-form-urlencoded"});
      if (response.statusCode != 200) {
        throw TokenException(
            "Invalid HTTP status ${response.statusCode}", response.statusCode);
      }
      _tokenTime = clock.now();
      Map vars = jsonDecode(response.body);
      _token = vars['access_token'];
      var expiresIn = vars['expires_in'];
      if (expiresIn is int) {
        _expiration = clock.fromNow(seconds: expiresIn);
      } else {
        _expiration = null;
      }
      log.fine(() => "new token $vars");
    } on TokenException {
      rethrow;
    } catch (e, s) {
      log.shout(() => "${('error with token() work')}:", e, s);
      throw TokenException("Error requesting access token", e);
    }
    return _token;
  }
}

/// Thrown when there is an issue retrieving the access token.
class TokenException implements Exception {
  final String message;
  final dynamic piggyback;

  TokenException([this.message, this.piggyback]);

  String toString() => 'TokenException: $message';
}

/// Interface for a service that can provide identity-related information to
/// the rest of the app.
abstract class SSOIdentityProvider {
  /// Returns a future for the current [SSOIdentity] that will block until there
  /// is a user.
  Future<SSOIdentity> get identity;

  /// Publishes changes to the current user.
  Observable<SSOIdentity> get currentUser;
}
