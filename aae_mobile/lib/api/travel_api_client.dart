import 'dart:convert';
import 'package:aae/model/flight_search.dart';
import 'package:aae/model/priority_list.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/trips.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class TravelServiceApi {
  static final Logger _log = Logger('AAE Travel API Client');
  final http.Client httpClient = http.Client();

  static const String baseUrl =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/travel';

  static const travelReservationsEndpoint = '$baseUrl/reservations';
  static const priorityListEndpoint = '$baseUrl/prioritylist';
  static const travelFlightStatusEndpoint = '$baseUrl/flightstatus';
  static const travelFlightSearchEndpoint = '$baseUrl/flightsearch';

  final dateFormatter = DateFormat("yyyy-MM-dd");

  Map<String, String> _getRequestHeaders(String employeeId) {
    String username = employeeId;
    String password = '4Password';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };

    return headers;
  }

  static Trips _tripsToModel(String tripsJson) {
    _log.info(jsonDecode(tripsJson));

    Trips trips =
        serializers.deserializeWith(Trips.serializer, jsonDecode(tripsJson));
    return trips;
  }

  static FlightStatus _flightStatusToModel(String flightStatusJson) {
    _log.info(jsonDecode(flightStatusJson));

    _log.info(jsonDecode(flightStatusJson));

    FlightStatus flightStatus = serializers.deserializeWith(
        FlightStatus.serializer, jsonDecode(flightStatusJson));
    return flightStatus;
  }

  static FlightSearch _flightSearchToModel(String flightSearchJson) {
    _log.info(jsonDecode(flightSearchJson));

    _log.info(jsonDecode(flightSearchJson));

    FlightSearch flightSearch = serializers.deserializeWith(
        FlightSearch.serializer, jsonDecode(flightSearchJson));
    return flightSearch;
  }

  Future<Trips> getReservations(String employeeId) async {
    Map<String, String> headers = _getRequestHeaders(employeeId);
    final response =
        await httpClient.get(travelReservationsEndpoint, headers: headers);
    if (response.statusCode == 200) {
      _log.info("Reservation API request successful");
      _log.info(response.body);

      Trips trips = _tripsToModel(response.body);

      return trips;
    } else {
      throw Exception(
          'Failed to load the trips\n ${response.body} - ${response.statusCode}');
    }
  }

  Future<PriorityList> getPriorityList(
      String origin, int flightNum, DateTime date) async {
    _log.info("initiating priority list request: $origin $flightNum $date");

    Map<String, String> headers = _getRequestHeaders("72000027");
    String constructedUrl =
        "$priorityListEndpoint/$origin/$flightNum/${dateFormatter.format(date)}";
    _log.info(constructedUrl);

    var response;
    try {
      response = await httpClient.get(constructedUrl, headers: headers);
    } catch (e) {
      String msg = 'failed to load the priority list.\n' + e.toString();
      _log.severe(msg);
      throw Exception(msg);
    }

    if (response.statusCode == 200) {
      _log.info("priority list request successful");
      _log.info(response.body);
      return serializers.deserializeWith(
          PriorityList.serializer, jsonDecode(response.body));
    } else {
      throw Exception(
          'failed to load the priority list.\n ${response.body} - ${response.statusCode} - ${response.headers["error"]}');
    }
  }

  Future<FlightStatus> getFlightStatus(String employeeId, String flightNumber,
      String origin, String date) async {
    Map<String, String> headers = _getRequestHeaders(employeeId);
    String constructedUrl =
        "$travelFlightStatusEndpoint/$origin/$flightNumber/$date";
    final response = await httpClient.get(constructedUrl, headers: headers);
    if (response.statusCode == 200) {
      _log.info("Flight Status API request successful");
      _log.info(response.body);
      FlightStatus flightStatus;
      try {
        flightStatus = _flightStatusToModel(response.body);
      } catch (e, s) {
        _log.info("FAILED BECAUSE OF", e, s);
        _log.info(s);
      }
      return flightStatus;
    } else {
      throw Exception(
          'Failed to load the flightStatus\n ${response.body} - ${response.statusCode}');
    }
  }

  Future<FlightSearch> getFlightSearch(
      String employeeId, String origin, String destination, String date) async {
    Map<String, String> headers = _getRequestHeaders(employeeId);
    String constructedUrl =
        "$travelFlightStatusEndpoint/$origin/$destination/$date";
    final response = await httpClient.get(constructedUrl, headers: headers);
    if (response.statusCode == 200) {
      _log.info("Flight Search API request successful");
      _log.info(response.body);
      FlightSearch flightSearch;
      try {
        flightSearch = _flightSearchToModel(response.body);
      } catch (e, s) {
        _log.info("FAILED BECAUSE OF", e, s);
        _log.info(s);
      }
      return flightSearch;
    } else {
      throw Exception(
          'Failed to load the flightSearch\n ${response.body} - ${response.statusCode}');
    }
  }
}
