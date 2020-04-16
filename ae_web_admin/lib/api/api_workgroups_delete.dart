import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/network_result.dart';
import 'package:american_essentials_web_admin/models/workgroups_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Result for this API
class ApiWorkgroupsDeleteResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  ApiWorkgroupsDeleteStatus deleteStatus;

  // Initialize the model
  ApiWorkgroupsDeleteResult({
    this.statusCode,
    this.error,
    this.deleteStatus,
  });
}

/// Return types for this API
enum ApiWorkgroupsDeleteStatus {
  Success,
  Error,
}

class ApiWorkgroupsDelete {
  /// Send the API request
  static Future<ApiWorkgroupsDeleteResult> sendRequest({
    @required WorkgroupsModel workgroupsModel,
  }) async {
    // Initialize local storage
    LocalStorage _localStorage = LocalStorage();
    await _localStorage.initialize();

    // Retreive an access token
    ApiIamResult apiIamResult = await ApiIam.sendRequest(iamAccessLevel: ApiIamAccessLevel.ReadWrite);

    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiIamResult.accessToken}',
    };

    // Post the network request
    NetworkResult networkResult = await NetworkCloudant.delete(
      stringPath: 'workgroups',
      stringId: workgroupsModel.id,
      stringRevision: workgroupsModel.revision,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkResult.statusCode == HttpStatusCode.Success) {
      // Configure the result
      ApiWorkgroupsDeleteResult apiWorkgroupsDeleteResult =
          ApiWorkgroupsDeleteResult(
        deleteStatus: ApiWorkgroupsDeleteStatus.Success,
        error: networkResult.error,
        statusCode: networkResult.statusCode,
      );

      return apiWorkgroupsDeleteResult;
    }

    return ApiWorkgroupsDeleteResult(
      deleteStatus: null,
      error: networkResult.error,
      statusCode: networkResult.statusCode,
    );
  }
}
