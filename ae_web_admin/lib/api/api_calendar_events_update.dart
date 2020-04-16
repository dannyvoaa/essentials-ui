import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/calendar_event_model.dart';
import 'package:american_essentials_web_admin/models/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Result for this API
class ApiCalendarEventsUpdateResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  ApiCalendarEventsUpdateStatus updateStatus;

  // Initialize the model
  ApiCalendarEventsUpdateResult({
    this.statusCode,
    this.error,
    this.updateStatus,
  });
}

/// Return types for this API
enum ApiCalendarEventsUpdateStatus {
  Success,
  Error,
}

class ApiCalendarEventsUpdate {
  /// Send the API request
  static Future<ApiCalendarEventsUpdateResult> sendRequest({
    @required CalendarEventModel calendarEventModel,
  }) async {
    // Initialize local storage
    LocalStorage _localStorage = LocalStorage();
    await _localStorage.initialize();

    // Retreive an access token
    ApiIamResult apiIamResult = await ApiIam.sendRequest(iamAccessLevel: ApiIamAccessLevel.ReadWrite);

    // Create the payload
    Map<String, Object> mapPayloadBody = await calendarEventModel.jsonEncode();

    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiIamResult.accessToken}',
    };

    // Post the network request
    NetworkResult networkResult = await NetworkCloudant.put(
      stringPath: 'events',
      stringId: calendarEventModel.id,
      stringRevision: calendarEventModel.revision,
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkResult.statusCode == HttpStatusCode.Success) {
      // Configure the result
      ApiCalendarEventsUpdateResult apiCalendarEventsUpdateResult =
          ApiCalendarEventsUpdateResult(
        error: networkResult.error,
        statusCode: networkResult.statusCode,
        updateStatus: ApiCalendarEventsUpdateStatus.Success,
      );

      return apiCalendarEventsUpdateResult;
    }

    return ApiCalendarEventsUpdateResult(
      error: networkResult.error,
      statusCode: networkResult.statusCode,
      updateStatus: null,
    );
  }
}
