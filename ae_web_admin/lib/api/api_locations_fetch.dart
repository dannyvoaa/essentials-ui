import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/locations_model.dart';
import 'package:american_essentials_web_admin/models/network_cloudant_result.dart';

/// Result for this API
class ApiLocationsFetchResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  List<LocationsModel> data;

  // Initialize the model
  ApiLocationsFetchResult({
    this.statusCode,
    this.error,
    this.data,
  });
}

class ApiLocationsFetch {
  /// Send the API request
  static Future<ApiLocationsFetchResult> sendRequest() async {
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
          'country:string': 'asc',
        },
        {
          'city:string': 'asc',
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
      stringPath: 'locations/_find',
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkCloudantResult.statusCode == HttpStatusCode.Success) {
      // Setup any required variables
      List<LocationsModel> listLocationsModel =
          List<LocationsModel>();

      // Declare the returned data as a list
      List listData = networkCloudantResult.docs;

      // Iterate through each object in the array
      listData.forEach(
        (element) {
          // Add the object to the list of CalendarEventModels
          listLocationsModel.add(
              // Decode the element to the model
              LocationsModel().jsonDecode(object: element));
        },
      );

      // Configure the result
      ApiLocationsFetchResult apiLocationsFetchResult =
          ApiLocationsFetchResult(
        data: listLocationsModel,
        error: networkCloudantResult.error,
        statusCode: networkCloudantResult.statusCode,
      );

      return apiLocationsFetchResult;
    }

    return ApiLocationsFetchResult(
      data: null,
      error: networkCloudantResult.error,
      statusCode: networkCloudantResult.statusCode,
    );
  }
}
