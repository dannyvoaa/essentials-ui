import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/network_cloudant_result.dart';
import 'package:american_essentials_web_admin/models/workgroups_model.dart';

/// Result for this API
class ApiWorkgroupsFetchResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  List<WorkgroupsModel> data;

  // Initialize the model
  ApiWorkgroupsFetchResult({
    this.statusCode,
    this.error,
    this.data,
  });
}

class ApiWorkgroupsFetch {
  /// Send the API request
  static Future<ApiWorkgroupsFetchResult> sendRequest() async {
    // Retreive an access token
    ApiIamResult apiIamResult =
        await ApiIam.sendRequest(iamAccessLevel: ApiIamAccessLevel.ReadOnly);

    // Create the body payload
    Map<String, Object> mapPayloadBody = {
      'selector': {
        '_id': {
          '\$gt': "0",
        },
      },
      'fields': [],
      'sort': [
        {
          'label:string': 'asc',
        }
      ],
    };
    
    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiIamResult.accessToken}',
    };

    // Post the network request
    NetworkCloudantResult networkCloudantResult =
        await NetworkCloudant.fetchRows(
      stringPath: 'workgroups/_find',
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkCloudantResult.statusCode == HttpStatusCode.Success) {
      // Setup any required variables
      List<WorkgroupsModel> listWorkgroupsModel =
          List<WorkgroupsModel>();

      // Declare the returned data as a list
      List listData = networkCloudantResult.docs;

      // Iterate through each object in the array
      listData.forEach(
        (element) {
          // Add the object to the list of CalendarEventModels
          listWorkgroupsModel.add(
              // Decode the element to the model
              WorkgroupsModel().jsonDecode(object: element));
        },
      );

      // Configure the result
      ApiWorkgroupsFetchResult apiWorkgroupsFetchResult =
          ApiWorkgroupsFetchResult(
        data: listWorkgroupsModel,
        error: networkCloudantResult.error,
        statusCode: networkCloudantResult.statusCode,
      );

      return apiWorkgroupsFetchResult;
    }

    return ApiWorkgroupsFetchResult(
      data: null,
      error: networkCloudantResult.error,
      statusCode: networkCloudantResult.statusCode,
    );
  }
}
