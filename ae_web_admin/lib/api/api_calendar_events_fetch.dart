import 'package:american_essentials_web_admin/api/api_iam.dart';
import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/common/network_cloudant.dart';
import 'package:american_essentials_web_admin/models/calendar_event_model.dart';
import 'package:american_essentials_web_admin/models/network_cloudant_result.dart';

/// Result for this API
class ApiCalendarEventsFetchResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  List<CalendarEventModel> data;

  // Initialize the model
  ApiCalendarEventsFetchResult({
    this.statusCode,
    this.error,
    this.data,
  });
}

class ApiCalendarEventsFetch {
  /// Send the API request
  static Future<ApiCalendarEventsFetchResult> sendRequest() async {
    // Setup any required variables
    DateTime _dateTimeFrom;
    DateTime _dateTimeTo;
    LocalStorage _localStorage = LocalStorage();

    // Initialize local storage
    await _localStorage.initialize().then((value) {
      // Retreive the selected filters from local storage
      _dateTimeFrom = DateTime.parse(_localStorage.sharedPreferences
          .getString('calendar.filters.dateFrom'));
      _dateTimeTo = DateTime.parse(
          _localStorage.sharedPreferences.getString('calendar.filters.dateTo'));
    });

    // Retreive an access token
    ApiIamResult apiIamResult =
        await ApiIam.sendRequest(iamAccessLevel: ApiIamAccessLevel.ReadOnly);

    // Create the body payload
    Map<String, Object> mapPayloadBody = {
      'selector': {
        'startLocal': {
          '\$gte': DateUtilities.secondsSinceEpoch(
              dateTime: DateTime.utc(
                  _dateTimeFrom.year, _dateTimeFrom.month, _dateTimeFrom.day)),
        },
        'endLocal': {
          '\$lt': DateUtilities.secondsSinceEpoch(
              dateTime: DateTime.utc(_dateTimeTo.year, _dateTimeTo.month,
                  _dateTimeTo.day, 24, 00)),
        },
      },
      'fields': [],
      'sort': [
        {
          'allDay:number': 'asc',
        },
        {
          'startLocal:number': 'asc',
        },
        {
          'eventName:string': 'asc',
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
      stringPath: 'events/_find',
      mapPayloadBody: mapPayloadBody,
      mapPayloadHeader: mapPayloadHeader,
    );

    // Check to see which http status code was returned
    if (networkCloudantResult.statusCode == HttpStatusCode.Success) {
      // Setup any required variables
      List<CalendarEventModel> listCalendarEventModel =
          List<CalendarEventModel>();

      // Declare the returned data as a list
      List listData = networkCloudantResult.docs;

      // Iterate through each object in the array
      listData.forEach(
        (element) {
          // Add the object to the list of CalendarEventModels
          listCalendarEventModel.add(
              // Decode the element to the model
              CalendarEventModel().jsonDecode(object: element));
        },
      );

      // Configure the result
      ApiCalendarEventsFetchResult apiCalendarEventsFetchResult =
          ApiCalendarEventsFetchResult(
        data: listCalendarEventModel,
        error: networkCloudantResult.error,
        statusCode: networkCloudantResult.statusCode,
      );

      return apiCalendarEventsFetchResult;
    }

    return ApiCalendarEventsFetchResult(
      data: null,
      error: networkCloudantResult.error,
      statusCode: networkCloudantResult.statusCode,
    );
  }
}
