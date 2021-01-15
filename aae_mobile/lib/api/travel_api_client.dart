import 'dart:convert';
import 'package:aae/model/airport.dart';
import 'package:aae/model/airports_wrapper.dart';
import 'package:aae/model/flight_search.dart';
import 'package:aae/model/priority_list.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/trips.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:built_collection/built_collection.dart';
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
  static const airportsEndpoint = '$baseUrl/airports';
  static const reservationDetailEndpoint = '$baseUrl/reservation';

  final dateFormatter = DateFormat("yyyy-MM-dd");

  Map<String, String> _getRequestHeaders(String employeeId, String smsession) {
      Map<String, String> headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'smsession': smsession,
        'smuser': employeeId
      };
      return headers;
  }


  static Trips _tripsToModel(String tripsJson) {
    _log.info(jsonDecode(tripsJson));

    Trips trips =
        serializers.deserializeWith(Trips.serializer, jsonDecode(tripsJson));
    return trips;
  }

  Future<Trips> getReservations(String employeeId, String smsession) async {
    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);
    final response = await httpClient.get(travelReservationsEndpoint, headers: headers);
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

  Future<PriorityList> getPriorityList(String employeeId, String smsession,
      String origin, int flightNum, DateTime date) async {
    _log.info("initiating priority list request: $origin $flightNum $date");

    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);
    String constructedUrl = "$priorityListEndpoint/$origin/$flightNum/${dateFormatter.format(date)}";
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
      return serializers.deserializeWith(PriorityList.serializer, jsonDecode(response.body));
    } else {
      throw Exception(
          'failed to load the priority list.\n ${response.body} - ${response.statusCode} - ${response.headers["error"]}');
    }
  }

  Future<BuiltList<Airport>> getAirports(String employeeId, String smsession) async {
    _log.info("initiating airports request.");
    _log.info("url: $airportsEndpoint");

    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);

    var response;
    try {
      response = await httpClient.get(airportsEndpoint, headers: headers);
    } catch (e) {
      String msg = 'failed to load the airports list.\n' + e.toString();
      _log.severe(msg);
      throw Exception(msg);
    }

    if (response.statusCode == 200) {
      _log.info("airports request successful");
      _log.info(response.body);
      AirportsWrapper wrapper = serializers.deserializeWith(
          AirportsWrapper.serializer, jsonDecode(response.body));

      if (wrapper != null && wrapper.airports != null)
        return wrapper.airports;
      else {
        throw Exception("failed to load the airports list. received 200 response with no contents.");
      }

    } else {
      throw Exception(
          'failed to load the airports list.\n ${response.body} - ${response.statusCode} - ${response.headers["error"]}');
    }
  }

  Future<FlightStatus> getFlightStatus(String employeeId, String smsession, String flightNumber, String origin, String date) async {
    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);
    String constructedUrl = "$travelFlightStatusEndpoint/$origin/$flightNumber/$date";
    final response = await httpClient.get(constructedUrl, headers: headers);
    if (response.statusCode == 200) {
      FlightStatus flightStatus;
      try {
        flightStatus = serializers.deserializeWith(
            FlightStatus.serializer, jsonDecode(response.body));
      } catch (e, s) {
        _log.severe("FAILED BECAUSE OF", e, s);
      }
      return flightStatus;
    } else {
      throw Exception(
          'Failed to load the flightStatus\n ${response.body} - ${response.statusCode}');
    }
  }

  Future<FlightSearch> getFlightSearch(
      String employeeId, String smsession, String origin, String destination, String date) async {
    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);
    String constructedUrl =
        "$travelFlightSearchEndpoint/$origin/$destination/$date";
    final response = await httpClient.get(constructedUrl, headers: headers);
//    String jsonObject =
//        await rootBundle.loadString('assets/static_records/FlightSearch.json');
    if (response.statusCode == 200) {
      FlightSearch flightSearch;
      try {
        flightSearch = serializers.deserializeWith(
            FlightSearch.serializer, jsonDecode(response.body));
      } catch (e, s) {
        _log.severe("FAILED BECAUSE OF", e, s);
      }
      return flightSearch;
    } else {
      throw new Exception(
          'Failed to load the flightSearch\n ${response.body} - ${response.statusCode}');
    }
  }

  Future<ReservationDetail> getReservationDetail(String employeeId, String smsession,String pnr) async {
    _log.info("initiating priority reservation detail request: $pnr");

    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);
    String constructedUrl = "$reservationDetailEndpoint/$pnr";

    _log.info(constructedUrl);

    var response;
    try {
      response = await httpClient.get(constructedUrl, headers: headers);
    } catch (e) {
      String msg = 'failed to load the reservation details.\n' + e.toString();
      _log.severe(msg);
      throw Exception(msg);
    }

    if (response.statusCode == 200) {

      _log.info("priority list request successful");
      _log.info(response.body);
      return serializers.deserializeWith(ReservationDetail.serializer, jsonDecode(response.body));

    } else {
      throw Exception(
          'failed to load the reservation details.\n ${response.body} - ${response.statusCode} - ${response.headers["error"]}');
    }
  }

}
