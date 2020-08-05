class SSOIdentity implements AmericanAirlinesIdentity {
  /// The user's display name (e.g., full name).
  ///
  /// This may be null if unavailable.
  final String displayName;

  final String email;

  final String id;

  final String userlocation;

  final String refreshToken;

  final String token;

  /// Constructor.
  ///
  /// Throws [InvalidSSOIdentityException] on failure.
  SSOIdentity(
      this.token, this.email, this.id, this.refreshToken, this.displayName, this.userlocation) {
    if (token == null || id == null) {
      throw InvalidSSOIdentityException();
    }
  }

//  Future<String> _token(String un, String pw) async {
//    try {
//      String payload = "grant_type=password&"
//          "username=$un&"
//          "password=$pw&"
//          "scope=openid";
//
//      log.fine(() => "oauth payload: $payload");
//
//      var response = await httpClient()
//          .post(sso_auth_constants.ACCESS_TOKEN_URL, body: payload, headers: {
//        'Content-Type': "application/x-www-form-urlencoded",
//        'accept': "application/json",
//        'authorization':
//        "Basic ${base64Encode(utf8.encode('${sso_auth_constants.CLIENT_ID}:${sso_auth_constants.CLIENT_SECRET}'))}"
//      });
//
//      log.fine(response.body);
//
//      if (response.statusCode != 200) {
//        throw TokenException(
//            "Invalid HTTP status ${response.statusCode}", response.statusCode);
//      }
//      _tokenTime = clock.now();
//      Map vars = jsonDecode(response.body);
//      _token = vars['access_token'];
//      var expiresIn = vars['expires_in'];
//      if (expiresIn is int) {
//        _expiration = clock.fromNow(seconds: expiresIn);
//      } else {
//        _expiration = null;
//      }
//      log.fine(() => "new token ${vars}");
//    } on TokenException {
//      rethrow;
//    } catch (e, s) {
//      log.shout(() => "${('error with token() work')}:", e, s);
//      throw TokenException("Error requesting access token", e);
//    }
//    return _token;
//  }
}

//  /// Returns a map of headers that can be attached to an HTTP request
//  /// in order to authenticate it for the provided [scopes].
//  Future<Map<String, String>> getAuthHeaders() async {
//    try {
//      final token = await _token();
//      return <String, String>{
//        'Authorization': 'Bearer $token',
//      };
//    } catch (e) {
//      null;
//      rethrow;
//    }
//  }

abstract class AmericanAirlinesIdentity {
  /// The unique ID for the American Airlines account.
  ///
  /// This is the preferred unique key to use for a user record.
  ///
  /// _Important_: Do not use this returned AA ID to communicate the
  /// currently signed in user to our backend server. Instead, send an ID token
  /// which can be securely validated on the server.
  /// provides such an ID token.
  String get id;

  /// The email address of the signed in user.
  ///
  /// Applications should not key users by email address since an American Airlines
  /// account's email address can change. Use [id] as a key instead.
  ///
  /// _Important_: Do not use this returned email address to communicate the
  /// currently signed in user to our backend server. Instead, send an ID token
  /// which can be securely validated on the server.
  String get email;

  /// The display name of the signed in user.
  ///
  /// Not guaranteed to be present for all users, even when configured.
  String get displayName;

  String get userlocation;

}

/// Thrown when an [SSOIdentity] fails to be constructed.
class InvalidSSOIdentityException implements Exception {}

//import 'package:flutter/material.dart';
//
//import 'sso_auth.dart';
//import 'sso_auth_constants.dart' as sso_auth_constants;
//
///// Encapsulation of the fields that represent a American Airlines user's identity.
//
//class SSOIdentity implements AmericanAirlinesIdentity {
//  /// The user's display name (e.g., full name).
//  ///
//  /// This may be null if unavailable.
//  String displayName;
//
//  /// The email address of the signed in user.
//  /// we should not key users by email address since an
//  ///  account's email address can change. Use [id] as a key instead.
//  String email;
//
//  /// The unique ID for the American Airlines User record
//  String id;
//
//  final SSOAuth _ssoAuth;
//
//  final Map<String, dynamic> _accountData;
//
//  /// Constructor.
//  ///
//  /// Throws [InvalidSSOIdentityException] on failure.
//  SSOIdentity._(this._ssoAuth, this._accountData)
//      : displayName = _accountData[sso_auth_constants.DISPLAY_NAME],
//        email = _accountData[sso_auth_constants.EMAIL],
//        id = _accountData[sso_auth_constants.ID],{
//    if (email == null || id == null) {
//      throw InvalidSSOIdentityException();
//    }
//
//    Future<String> _token() async {
//      return await SSOAuth.channel
//          .invokeMethod(sso_auth_constants.GET_TOKEN_METHOD, <String, dynamic>{
//        sso_auth_constants.EMAIL: email,
//        sso_auth_constants.ID: id,
//      });
//    }
//      /// Returns a map of headers that can be attached to an HTTP request
//      /// in order to authenticate it for the provided [scopes].
//      ///
//      /// This method completes only after the user has finished
//      /// this flow (if necessary). If the user fails to complete the flow, throws
//      /// an [AuthRecoveryFailureException]. Defaults to false.
//      ///
//      ///
//      /// Throws a [UserRecoverableAuthException] if the user has a recoverable auth
//      /// exception. You can prompt the user to recover this by calling this method
//      /// with [shouldRecoverAuth] set to true.
//      ///
//      /// Throws an [AuthRecoveryFailureException] if the user is prompted to
//      /// recover their authentication but does not complete the process (e.g., due
//      /// to cancellation or network error).
//      Future<Map<String, String>> getAuthHeaders() async {
//        try {
//          final token = await _token();
//          return <String, String>{
//            'Authorization': 'Bearer $token',
//            'X-Goog-AuthUser': '0',
//          };
//        } catch (e) {
//          _tryMapPlatformException(this, e);
//          rethrow;
//        }
//        /// Clears the token cache if the authentication headers are no longer valid.
//        ///
//        /// Call this method if the requests start returning Unauthorized (401)
//        /// responses.
//        Future<void> clearAuthCache() async {
//          var args = <String, dynamic>{};
//          if (Platform.isAndroid) {
//            args[sso_auth_constants.TOKEN] = await _token(shouldRecoverAuth: false);
//          }
//          if (Platform.isIOS) {
//            args[sso_auth_constants.ID] = id;
//          }
//          await SSOAuth.channel
//              .invokeMethod(sso_auth_constants.CLEAR_AUTH_CACHE_METHOD, args);
//          /// Provides [SSOIdentity] data using the plugins/common [Account] type.
//          Account get asAccount => Account(email: email, userId: id);
//          @override
//          bool operator ==(dynamic other) {
//          if (identical(this, other)) return true;
//          if (other is! SSOIdentity) return false;
//          final SSOIdentity otherIdentity = other;
//          return displayName == otherIdentity.displayName &&
//          email == otherIdentity.email &&
//          id == otherIdentity.id &&
//          photoUrl == otherIdentity.photoUrl &&
//          coverImageUrl == otherIdentity.coverImageUrl;
//          @override
//          int get hashCode =>
//          hashValues(displayName, email, id, photoUrl, coverImageUrl);
//          @override
//          String toString() {
//          Map<String, dynamic> data = <String, dynamic>{
//          sso_auth_constants.DISPLAY_NAME: displayName,
//          sso_auth_constants.EMAIL: email,
//          sso_auth_constants.ID: id,
//          sso_auth_constants.PHOTO_URL: photoUrl,
//          sso_auth_constants.COVER_IMAGE_URL: coverImageUrl,
//          };
//          return 'SSOAuth:$data';
//}
//
//  /// Encapsulation of the fields that represent a American Airlines user's identity.
//  abstract class AmericanAirlinesIdentity {
//  /// The unique ID for the American Airlines account.
//  ///
//  /// This is the preferred unique key to use for a user record.
//  ///
//  /// _Important_: Do not use this returned American Airlines ID to communicate the
//  /// currently signed in user to your backend server. Instead, send an ID token
//  /// which can be securely validated on the server.
//  String get id;
//
//  /// The email address of the signed in user.
//  ///
//  /// Applications should not key users by email address since a American Airlines
//  /// account's email address can change. Use [id] as a key instead.
//  ///
//  /// _Important_: Do not use this returned email address to communicate the
//  /// currently signed in user to your backend server. Instead, send an ID token
//  /// which can be securely validated on the server.
//  String get email;
//
//  /// The display name of the signed in user.
//  ///
//  /// Not guaranteed to be present for all users, even when configured.
//  String get displayName;
//  }
