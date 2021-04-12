import 'dart:convert';
import 'package:aae/model/airport.dart';
import 'package:aae/model/airports_wrapper.dart';
import 'package:aae/model/check_in_request.dart';
import 'package:aae/model/boarding_pass.dart';
import 'package:aae/model/boarding_pass_wrapper.dart';
import 'package:aae/model/countries.dart';
import 'package:aae/model/flight_search.dart';
import 'package:aae/model/priority_list.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/trips.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class TravelServiceApi {
  static final Logger _log = Logger('AAE Travel API Client');
  final http.Client httpClient = http.Client();

  static const String baseUrl =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/travel-stage';

  static const travelReservationsEndpoint = '$baseUrl/reservations';
  static const priorityListEndpoint = '$baseUrl/prioritylist';
  static const travelFlightStatusEndpoint = '$baseUrl/flightstatus';
  static const travelFlightSearchEndpoint = '$baseUrl/flightsearch';
  static const airportsEndpoint = '$baseUrl/airports';
  static const countriesEndpoint = '$baseUrl/countries';
  static const reservationDetailEndpoint = '$baseUrl/reservation';
  static const checkInEndpoint = '$baseUrl/checkin';
  static const boardingPassEndpoint = '$baseUrl/boardingpass';

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
      //_log.info(response.body.toString().substring(0,50));

      /// Populates trips object with available PNRs
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
      //_log.info(response.body.toString().substring(0,50));
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

  Future<BuiltList<Country>> getCountries(String employeeId, String smsession) async {
    _log.info("initiating countries request.");
    _log.info("url: $countriesEndpoint");

    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);

    var response;
    try {
      response = await httpClient.get(countriesEndpoint, headers: headers);
    } catch (e) {
      String msg = 'failed to load the airports list.\n' + e.toString();
      _log.severe(msg);
      throw Exception(msg);
    }

    if (response.statusCode == 200) {
      _log.info("countries request successful");
      CountriesWrapper wrapper = CountriesWrapper.fromJson(response.body);

      if (wrapper != null && wrapper.countries != null)
        return wrapper.countries;
      else {
        throw Exception("failed to load the airports list. received 200 response with no contents.");
      }

    } else {
      throw Exception(
          'failed to load the countries list.\n ${response.body} - ${response.statusCode} - ${response.headers["error"]}');
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

  Future<BuiltList<BoardingPass>> pushCheckIn(CheckInArguments checkInArguments, String employeeId, String smsession) async {
    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);
    String constructedUrl = "$checkInEndpoint/${checkInArguments.pnr}";

    _log.info("initiating check in request: ${checkInArguments.pnr}");
    _log.info(constructedUrl);

    // Test data for initial page build only...
    // var testData = "{\r\n    \"boardingPasses\": [{\r\n            \"arrivalTime\": \"2021-01-28T22:02\",\r\n            \"arrivalTimezone\": \"PST\",\r\n            \"barcodeString\": \"M1CONRAD JR\/JOHN      EYKYNVS DFWSANAA 2443 028J00000003 148>218       BAA              29             0                            d2FnQd7NgySsvhSc5z6MojpGL6GB3Jvl|AMh9P\/SQnfoRy0NZ4CduvR4QXC11xrzLhw==\",\r\n            \"boardingTime\": \"2021-01-28T20:10\",\r\n            \"boardingTimezone\": \"CST\",\r\n            \"checkinSequenceNumber\": 3,\r\n            \"departureTime\": \"2021-01-28T20:40\",\r\n            \"departureTimezone\": \"CST\",\r\n            \"estimatedArrivalTime\": \"2021-01-28T22:02\",\r\n            \"estimatedBoardingTime\": \"2021-01-28T20:10\",\r\n            \"estimatedDepartureTime\": \"2021-01-28T20:40\",\r\n            \"firstName\": \"JOHN\",\r\n            \"flightNumber\": \"2443\",\r\n            \"fromCityCode\": \"DFW\",\r\n            \"gateInfo\": \"C15\",\r\n            \"groupInfo\": \"1\",\r\n            \"isTsaPrecheck\": false,\r\n            \"lastName\": \"CONRAD JR\",\r\n            \"pnrCode\": \"YKYNVS\",\r\n            \"seatNumber\": null,\r\n            \"terminal\": \"C\",\r\n            \"toCityCode\": \"SAN\",\r\n            \"travelerId\": 1\r\n        }\r\n    ]\r\n}";

    var response;
    try {

      CheckInRequest request = CheckInRequest((b) => b
        ..pnr = checkInArguments.pnr
        ..employeeId = employeeId
        ..passengers = checkInArguments.passengers.toBuilder()
      );

      String checkinDetailsJson = request.toJson();
      _log.info(checkinDetailsJson);

      response = await httpClient.post(constructedUrl, headers: headers, body: checkinDetailsJson);
    } catch (e) {
      String msg = 'failed to push the check in request.\n' + e.toString();
      _log.severe(msg);
      throw Exception(msg);
    }

    if (response.statusCode == 200) {
      _log.info("check in request successful");
      _log.info(response.body);

      BoardingPassWrapper boardingPassWrapper = BoardingPassWrapper.fromJson(response.body);
      return boardingPassWrapper.boardingPasses;

    } else {
      throw Exception(
          'failed to push the check in request.\n ${response.body} - ${response.statusCode} - ${response.headers["error"]}');
    }
  }

  Future<ReservationDetail> getReservationDetail(String employeeId, String smsession, String pnr) async {
    _log.info("initiating reservation detail request: $pnr");

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

    //String testData = "{\r\n    \"description\": \"DFW - SAN  03\/02\/2021\",\r\n    \"employeeId\": \"72000054\",\r\n    \"firstDepartureDateTime\": \"2021-03-02T08:55:00\",\r\n    \"lastArrivalDateTime\": \"2021-03-02T08:55:00\",\r\n    \"passType\": \"D2\",\r\n    \"passengers\": [{\r\n            \"countryOfCitizenship\": null,\r\n            \"countryOfResidence\": null,\r\n            \"destination\": null,\r\n            \"emergencyContact\": {\r\n                \"country\": \"US\",\r\n                \"firstName\": \"JOHN\",\r\n                \"lastName\": \"BO\",\r\n                \"phoneNumber\": \"2113456666\"\r\n            },\r\n            \"firstName\": \"ARTY\",\r\n            \"lastName\": \"FISCHEL\",\r\n            \"nrsTravelerId\": 1,\r\n            \"passengerId\": \"01.01\",\r\n            \"passport\": {\r\n                \"expirationDate\": \"2029-10-21\",\r\n                \"issuingCountry\": \"US\",\r\n                \"number\": \"4549577402\"\r\n            },\r\n            \"usResidencyCard\": {\r\n                \"expirationDate\": \"2000-10-21\",\r\n                \"number\": \"LPR52369\"\r\n            },\r\n            \"visa\": {\r\n                \"expirationDate\": \"2025-02-07\",\r\n                \"issuedDate\": \"2017-03-03\",\r\n                \"issuingCity\": \"HYDERABAD\",\r\n                \"number\": \"1AV2727\"\r\n            }\r\n        }\r\n    ],\r\n    \"recordLocator\": \"VMLZML\",\r\n    \"segments\": [{\r\n            \"aircraftName\": \"Airbus Industrie A321\",\r\n            \"arrivalTimeActual\": null,\r\n            \"arrivalTimeEstimated\": \"2021-03-02T10:21:00\",\r\n            \"arrivalTimeScheduled\": \"2021-03-02T10:21:00\",\r\n            \"baggageClaimArea\": null,\r\n            \"cabin\": \"FIRST\",\r\n            \"departureTimeActual\": null,\r\n            \"departureTimeEstimated\": \"2021-03-02T08:55:00\",\r\n            \"departureTimeScheduled\": \"2021-03-02T08:55:00\",\r\n            \"destinationAirportCode\": \"SAN\",\r\n            \"destinationCity\": \"San Diego\",\r\n            \"destinationCountry\": \"US\",\r\n            \"destinationGate\": null,\r\n            \"destinationTerminal\": \"2\",\r\n            \"duration\": 206,\r\n            \"flightNumber\": 1846,\r\n            \"hasWifi\": true,\r\n            \"legNumber\": 1,\r\n            \"originAirportCode\": \"DFW\",\r\n            \"originCity\": \"Dallas\/Fort Worth\",\r\n            \"originCountry\": \"US\",\r\n            \"originGate\": \"--\",\r\n            \"originTerminal\": \"--\",\r\n            \"seatAssignments\": [{\r\n                    \"passengerId\": \"01.01\",\r\n                    \"seatAssignment\": null\r\n                }\r\n            ],\r\n            \"segmentNumber\": 1,\r\n            \"status\": \"ON TIME\"\r\n        }\r\n    ]\r\n}\r\n";

    if (response.statusCode == 200) {
      _log.info("reservation detail request successful");
      _log.info(response.body);
      return ReservationDetail.fromJson(response.body);

    } else {
      throw Exception(
          'failed to load the reservation details.\n ${response.body} - ${response.statusCode} - ${response.headers["error"]}');
    }
  }

  Future<BuiltList<BoardingPass>> getBoardingPasses(String employeeId, String smsession, String pnr) async {
    _log.info("initiating boarding pass request: $pnr");

    Map<String, String> headers = _getRequestHeaders(employeeId, smsession);
    String constructedUrl = "$boardingPassEndpoint/$pnr";

    _log.info(constructedUrl);

    var response;
    try {
      response = await httpClient.get(constructedUrl, headers: headers);
    } catch (e) {
      String msg = 'failed to load boarding passes.\n' + e.toString();
      _log.severe(msg);
      throw Exception(msg);
    }

    if (response.statusCode == 200) {

      _log.info("boarding pass request successful");
      _log.info(response.body);

      BoardingPassWrapper boardingPassWrapper = BoardingPassWrapper.fromJson(response.body);
      return boardingPassWrapper.boardingPasses;

    } else {
      throw Exception(
          'failed to load boarding passes.\n ${response.body} - ${response.statusCode} - ${response.headers["error"]}');
    }
  }

}
