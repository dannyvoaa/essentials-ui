import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/network_result.dart';
import 'package:american_essentials_web_admin/models/workgroups_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Result for this API
class ApiWorkgroupsUpdateResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  ApiWorkgroupsUpdateStatus updateStatus;

  // Initialize the model
  ApiWorkgroupsUpdateResult({
    this.statusCode,
    this.error,
    this.updateStatus,
  });
}

/// Return types for this API
enum ApiWorkgroupsUpdateStatus {
  Success,
  Error,
}

class ApiWorkgroupsUpdate {
  /// Send the API request
  static Future<ApiWorkgroupsUpdateResult> sendRequest({
    @required WorkgroupsModel workgroupsModel,
  }) async {
    // Initialize local storage
    LocalStorage _localStorage = LocalStorage();
    await _localStorage.initialize();

    // Retreive an access token
    ApiIamResult apiIamResult = await ApiIam.sendRequest(iamAccessLevel: ApiIamAccessLevel.ReadWrite);

    // Create the payload
    Map<String, Object> mapPayloadBody = await workgroupsModel.jsonEncode();

    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiIamResult.accessToken}',
    };

    // Post the network request
    NetworkResult networkResult = await NetworkCloudant.put(
      stringPath: 'workgroups',
      stringId: workgroupsModel.id,
      stringRevision: workgroupsModel.revision,
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkResult.statusCode == HttpStatusCode.Success) {
      // Configure the result
      ApiWorkgroupsUpdateResult apiWorkgroupsUpdateResult =
          ApiWorkgroupsUpdateResult(
        error: networkResult.error,
        statusCode: networkResult.statusCode,
        updateStatus: ApiWorkgroupsUpdateStatus.Success,
      );

      return apiWorkgroupsUpdateResult;
    }

    return ApiWorkgroupsUpdateResult(
      error: networkResult.error,
      statusCode: networkResult.statusCode,
      updateStatus: null,
    );
  }
}
