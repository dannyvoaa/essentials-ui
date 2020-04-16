import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/network_cloudant_result.dart';
import 'package:american_essentials_web_admin/models/users_model.dart';

/// Result for this API
class ApiUsersFetchResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  List<UsersModel> data;

  // Initialize the model
  ApiUsersFetchResult({
    this.statusCode,
    this.error,
    this.data,
  });
}

class ApiUserFetch {
  /// Send the API request
  static Future<ApiUsersFetchResult> sendRequest() async {
    // Setup any required variables
    String _stringAaId;
    LocalStorage _localStorage = LocalStorage();

    // Initialize local storage
    await _localStorage.initialize().then((value) {
      // Retreive the selected filters from local storage
      _stringAaId = _localStorage.sharedPreferences.getString('users.filters.aaId');
    });
    // Retreive an access token
    ApiIamResult apiIamResult =
        await ApiIam.sendRequest(iamAccessLevel: ApiIamAccessLevel.ReadOnly);

    // Create the body payload
    Map<String, Object> mapPayloadBody = {
      'selector': {
        '_id': {
          '\$gt': "0",
        },
        'aaId': {
          '\$regex': _stringAaId,
        }
      },
      'fields': [],
      'sort': [
        {
          'aaId:string': 'asc',
        },
      ],
      'limit': 25,
    };

    // Create the header payload
    Map<String, String> mapPayloadHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiIamResult.accessToken}',
    };

    // Post the network request
    NetworkCloudantResult networkCloudantResult =
        await NetworkCloudant.fetchRows(
      stringPath: 'user_preferences/_find',
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkCloudantResult.statusCode == HttpStatusCode.Success) {
      // Setup any required variables
      List<UsersModel> listUsersModel = List<UsersModel>();

      // Declare the returned data as a list
      List listData = networkCloudantResult.docs;

      // Iterate through each object in the array
      listData.forEach(
        (element) {
          // Add the object to the list of CalendarEventModels
          listUsersModel.add(
              // Decode the element to the model
              UsersModel().jsonDecode(object: element));
        },
      );

      // Configure the result
      ApiUsersFetchResult apiUsersFetchResult = ApiUsersFetchResult(
        data: listUsersModel,
        error: networkCloudantResult.error,
        statusCode: networkCloudantResult.statusCode,
      );

      return apiUsersFetchResult;
    }

    return ApiUsersFetchResult(
      data: null,
      error: networkCloudantResult.error,
      statusCode: networkCloudantResult.statusCode,
    );
  }
}
