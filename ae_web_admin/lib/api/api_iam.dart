import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/models/network_result.dart';
import 'package:flutter/foundation.dart';

/// Result for this API
class ApiIamResult {
  // Setup any required variables
  String accessToken;
  int expiration;
  int expiresIn;
  String
      refreshToken; // IAM support documents indicate that a refresh token cannot currently be used to generated a new access token; instead you need to resubmit the request
  String scope;
  String tokenType;

  // Initialize the model
  ApiIamResult({
    this.accessToken,
    this.expiration,
    this.expiresIn,
    this.refreshToken,
    this.scope,
    this.tokenType,
  });
}

/// Return types for this API
enum ApiIamAccessLevel {
  ReadOnly,
  ReadWrite,
}

class ApiIam {
  static String _apiKey({
    @required ApiIamAccessLevel iamAccessLevel,
  }) {
    // Check to see which access level is being requested
    // - API keys for service credentials can be viewed here: https://cloud.ibm.com/services/cloudantnosqldb/crn%3Av1%3Abluemix%3Apublic%3Acloudantnosqldb%3Aus-south%3Aa%2Fb9cd61ee73f24af3b6e2ef01e0534884%3Aa5c50318-631f-4a40-851f-6aabb65731e2%3A%3A?paneId=manage
    if (iamAccessLevel == ApiIamAccessLevel.ReadOnly) {
      // API key for service account 'ae_cloudant_ro'
      return 'zJ47OfLtYBKgwmeaVTOaz00qxZAo7IiU6XFxjrHGOpQ9';
    } else if (iamAccessLevel == ApiIamAccessLevel.ReadWrite) {
      // API key for service account 'ae_cloudant_rw'
      return 'Bc1WKuyWe7Hj0d0yzz_srG3zzDTjD7tpS7Yzb3M87wFq';
    } else {
      // If you hit this, then you screwed something up bad
      return '';
    }
  }

  /// Send the API request
  static Future<ApiIamResult> sendRequest(
      {@required ApiIamAccessLevel iamAccessLevel}) async {
    // Initialize local storage
    LocalStorage _localStorage = LocalStorage();
    await _localStorage.initialize();

    // Create the payload
    Map<String, String> mapPayloadBody = {
      'grant_type': 'urn:ibm:params:oauth:grant-type:apikey',
      'apikey': _apiKey(iamAccessLevel: iamAccessLevel),
    };

    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };

    // Post the network request
    NetworkResult networkResult = await Network.postFormData(
      stringUrl: 'https://iam.cloud.ibm.com',
      stringPath: 'identity/token',
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkResult.statusCode == HttpStatusCode.Success) {
      // Setup any required variables
      Map<String, Object> mapResults =
          networkResult.data as Map<String, Object>;

      // Configure the result
      ApiIamResult apiIamResult = ApiIamResult(
        accessToken: mapResults['access_token'],
        expiration: mapResults['expiration'],
        expiresIn: mapResults['expires_in'],
        refreshToken: mapResults['refresh_token'],
        scope: mapResults['scope'],
        tokenType: mapResults['token_type'],
      );

      return apiIamResult;
    }

    return ApiIamResult();
  }
}
