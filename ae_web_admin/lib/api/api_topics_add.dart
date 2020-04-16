import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/network_result.dart';
import 'package:american_essentials_web_admin/models/topics_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Result for this API
class ApiTopicsAddResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  ApiTopicsAddStatus addStatus;

  // Initialize the model
  ApiTopicsAddResult({
    this.statusCode,
    this.error,
    this.addStatus,
  });
}

/// Return types for this API
enum ApiTopicsAddStatus {
  Success,
  Error,
}

class ApiTopicsAdd {
  /// Send the API request
  static Future<ApiTopicsAddResult> sendRequest({
    @required TopicsModel topicsModel,
  }) async {
    // Initialize local storage
    LocalStorage _localStorage = LocalStorage();
    await _localStorage.initialize();

    // Retreive an access token
    ApiIamResult apiIamResult = await ApiIam.sendRequest(iamAccessLevel: ApiIamAccessLevel.ReadWrite);

    // Create the payload
    Map<String, Object> mapPayloadBody = await topicsModel.jsonEncode();

    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiIamResult.accessToken}',
    };

    // Post the network request
    NetworkResult networkResult = await NetworkCloudant.post(
      stringPath: 'topics', 
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkResult.statusCode == HttpStatusCode.Success) {
      // Configure the result
      ApiTopicsAddResult apiTopicsAddResult =
          ApiTopicsAddResult(
        addStatus: ApiTopicsAddStatus.Success,
        error: networkResult.error,
        statusCode: networkResult.statusCode,
      );

      return apiTopicsAddResult;
    }

    return ApiTopicsAddResult(
      addStatus: null,
      error: networkResult.error,
      statusCode: networkResult.statusCode,
    );
  }
}
