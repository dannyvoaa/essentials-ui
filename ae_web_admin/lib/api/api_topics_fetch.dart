import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/network_cloudant_result.dart';
import 'package:american_essentials_web_admin/models/topics_model.dart';

/// Result for this API
class ApiTopicsFetchResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  List<TopicsModel> data;

  // Initialize the model
  ApiTopicsFetchResult({
    this.statusCode,
    this.error,
    this.data,
  });
}

class ApiTopicsFetch {
  /// Send the API request
  static Future<ApiTopicsFetchResult> sendRequest() async {
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
      stringPath: 'topics/_find',
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkCloudantResult.statusCode == HttpStatusCode.Success) {
      // Setup any required variables
      List<TopicsModel> listTopicsModel =
          List<TopicsModel>();

      // Declare the returned data as a list
      List listData = networkCloudantResult.docs;

      // Iterate through each object in the array
      listData.forEach(
        (element) {
          // Add the object to the list of CalendarEventModels
          listTopicsModel.add(
              // Decode the element to the model
              TopicsModel().jsonDecode(object: element));
        },
      );

      // Configure the result
      ApiTopicsFetchResult apiTopicsFetchResult =
          ApiTopicsFetchResult(
        data: listTopicsModel,
        error: networkCloudantResult.error,
        statusCode: networkCloudantResult.statusCode,
      );

      return apiTopicsFetchResult;
    }

    return ApiTopicsFetchResult(
      data: null,
      error: networkCloudantResult.error,
      statusCode: networkCloudantResult.statusCode,
    );
  }
}
