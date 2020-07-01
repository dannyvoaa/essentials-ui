import 'dart:convert';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/trips.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class TravelServiceApi {
  static final Logger _log = Logger('AAE Travel API Client');
  final http.Client httpClient = http.Client();

  final baseUrl =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/default/ae-newsfeed.json?tag=';

  final travelReservationsEndpoint =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/travel/reservations';

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
    Trips trips =
        serializers.deserializeWith(Trips.serializer, jsonDecode(tripsJson));
    return trips;
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
}
