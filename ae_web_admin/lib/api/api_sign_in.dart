import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/models/network_result.dart';
import 'package:flutter/foundation.dart';

/// Return types for this API
class ApiSignInResult {
  // Setup any required variables
  String accessToken;
  DateTime expiration;
  String idToken;
  String refreshToken;
  ApiSignInStatus status;

  // Initialize the model
  ApiSignInResult({
    this.accessToken,
    this.expiration,
    this.idToken,
    this.refreshToken,
    this.status,
  });
}

/// Return types for this API
enum ApiSignInStatus {
  Success,
  Error,
  InvalidUsernamePassword,
}

class ApiSignIn {
  /// Send the API request
  static Future<ApiSignInResult> sendRequest(
      {@required String stringUsername,
      @required String stringPassword}) async {
    // TODO: API - We need to check to see if the user who is trying to login has the appropriate rights; right now any user with a valid username and password can log in to the admin website

    // Create the payload
    Map<String, String> mapPayloadBody = {
      'grant_type': 'password',
      'username': stringUsername,
      'password': stringPassword,
      'scope': 'openid',
    };

    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'accept': 'application/json',
      'authorization':
          'Basic MGE4OTI2ZDAtMDAwOS00OGY2LWI3NTMtYTM2NDZhNmMxMWQ4OllUSTFNak0wTURJdE1UUmxZaTAwTlRCbUxUaGtaREV0TUdRd1pHSm1ZalUyWldObQ==',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    // Post the network request
    NetworkResult networkResult = await Network.postFormData(
      stringUrl: 'https://us-south.appid.cloud.ibm.com',
      stringPath: 'oauth/v4/95debee2-f9c4-4dec-b30c-701d9d7f8216/token',
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which result was returned
    if (networkResult.statusCode == HttpStatusCode.Success) {
      // Setup any required variables
      Map<String, Object> mapResults =
          networkResult.data as Map<String, Object>;

      // Calculate the token expiration
      DateTime dateTimeExpiration = DateTime.now()
          .add(Duration(seconds: mapResults['expires_in'] as int))
          .toUtc();

      return ApiSignInResult(
        accessToken: mapResults['access_token'],
        expiration: dateTimeExpiration,
        idToken: mapResults['id_token'],
        refreshToken: mapResults['refresh_token'],
        status: ApiSignInStatus.Success,
      );
    } else {
      return ApiSignInResult(
        status: ApiSignInStatus.InvalidUsernamePassword,
      );
    }
  }
}
