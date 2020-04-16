import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/locations_model.dart';
import 'package:american_essentials_web_admin/models/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Result for this API
class ApiLocationsUpdateResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  ApiLocationsUpdateStatus updateStatus;

  // Initialize the model
  ApiLocationsUpdateResult({
    this.statusCode,
    this.error,
    this.updateStatus,
  });
}

/// Return types for this API
enum ApiLocationsUpdateStatus {
  Success,
  Error,
}

class ApiLocationsUpdate {
  /// Send the API request
  static Future<ApiLocationsUpdateResult> sendRequest({
    @required LocationsModel locationsModel,
  }) async {
    // Initialize local storage
    LocalStorage _localStorage = LocalStorage();
    await _localStorage.initialize();

    // Retreive an access token
    ApiIamResult apiIamResult = await ApiIam.sendRequest(iamAccessLevel: ApiIamAccessLevel.ReadWrite);

    // Create the payload
    Map<String, Object> mapPayloadBody = await locationsModel.jsonEncode();

    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiIamResult.accessToken}',
    };

    // Post the network request
    NetworkResult networkResult = await NetworkCloudant.put(
      stringPath: 'locations',
      stringId: locationsModel.id,
      stringRevision: locationsModel.revision,
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkResult.statusCode == HttpStatusCode.Success) {
      // Configure the result
      ApiLocationsUpdateResult apiLocationsUpdateResult =
          ApiLocationsUpdateResult(
        error: networkResult.error,
        statusCode: networkResult.statusCode,
        updateStatus: ApiLocationsUpdateStatus.Success,
      );

      return apiLocationsUpdateResult;
    }

    return ApiLocationsUpdateResult(
      error: networkResult.error,
      statusCode: networkResult.statusCode,
      updateStatus: null,
    );
  }
}
