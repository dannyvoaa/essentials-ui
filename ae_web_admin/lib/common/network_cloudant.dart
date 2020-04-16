import 'dart:convert';
import 'package:american_essentials_web_admin/common/network.dart';
import 'package:american_essentials_web_admin/models/network_cloudant_result.dart';
import 'package:american_essentials_web_admin/models/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum _ApiEndpoint {
  Development,
  Production,
}

class NetworkCloudant {
  /// Retreive the URL for the specified endpoint
  static String _apiEndpoint({_ApiEndpoint apiEndpoint}) {
    // Map endpoints to URL's
    if (apiEndpoint == _ApiEndpoint.Development) {
      return 'https://b23661f9-9acc-4aab-9a2b-f8aa0f41b993-bluemix.cloudantnosqldb.appdomain.cloud'; // Do NOT include a trailing forward slash!
    } else if (apiEndpoint == _ApiEndpoint.Production) {
      return 'https://something.aa-on-ibm.com'; // Do NOT include a trailing forward slash!
    }

    return '';
  }

  // Define which endpoint is active
  static String _stringActiveEndpoint =
      _apiEndpoint(apiEndpoint: _ApiEndpoint.Development);
  // static String _stringActiveEndpoint = _apiEndpoint(apiEndpoint: _ApiEndpoint.Production);

  /// Check to see what HTTP status code was returned
  static HttpStatusCode _checkStatusCode({@required int intStatusCode}) {
    // Check to see what HTTP status code was returned
    if (intStatusCode == 200) {
      // HTTP 200: Ok
      return HttpStatusCode.Success;
    } else if (intStatusCode == 201) {
      // HTTP 201: Created
      return HttpStatusCode.Success;
    } else if (intStatusCode == 401) {
      
      print('Network.dart - You need to sign out and then sign back in to generate a new authorization token!');

      return HttpStatusCode.Unauthorized;
    } else {
      return HttpStatusCode.Error;
    }
  }

  /// Send the DELETE request to the API
  static Future<NetworkResult> delete({
    String stringUrl,
    @required String stringPath,
    @required String stringId,
    @required String stringRevision,
    @required Map<String, String> mapPayloadHeader,
  }) async {
    NetworkResult _networkResult = NetworkResult();

    try {
      // Attempt to upload the data to the API
      await http
          .delete(
        '${stringUrl ?? _stringActiveEndpoint}/$stringPath/$stringId?rev=$stringRevision',
        headers: mapPayloadHeader,
      )
          .then((response) {
        // Write the status code to the API Result
        _networkResult.statusCode =
            _checkStatusCode(intStatusCode: response.statusCode);

        // Check to see if a response was received
        if (response.body != null && response.body != '') {
          // Write the response data to the API Result
          _networkResult.data = jsonDecode(utf8.decode(response.bodyBytes));
        }
      });
    } catch (error) {
      // Do nothing; the default value of mapResults is an empty map
      print('Network.dart - Error: $error');

      // Record that an error occured
      _networkResult.error = error;
    }

    return _networkResult;
  }

  /// Send the GET request to the API
  static Future<NetworkResult> get({
    String stringUrl,
    @required String stringPath,
    @required Map<String, String> mapPayloadHeader,
  }) async {
    NetworkResult _networkResult = NetworkResult();

    try {
      // Attempt to upload the data to the API
      await http
          .get(
        '${stringUrl ?? _stringActiveEndpoint}/$stringPath',
        headers: mapPayloadHeader,
      )
          .then((response) {
        // Write the status code to the API Result
        _networkResult.statusCode =
            _checkStatusCode(intStatusCode: response.statusCode);

        // Check to see if a response was received
        if (response.body != null && response.body != '') {
          // Write the response data to the API Result
          _networkResult.data = jsonDecode(utf8.decode(response.bodyBytes));
        }
      });
    } catch (error) {
      // Do nothing; the default value of mapResults is an empty map
      print('Network.dart - Error: $error');

      // Record that an error occured
      _networkResult.error = error;
    }

    return _networkResult;
  }

  /// Send the POST request to the API
  static Future<NetworkResult> fetchRows({
    String stringUrl,
    @required String stringPath,
    @required Map<String, Object> mapPayloadBody,
    @required Map<String, String> mapPayloadHeader,
  }) async {
    NetworkCloudantResult _networkCloudantResult = NetworkCloudantResult();

    // Encode the payload to JSON
    String stringPayloadBodyJsonEncoded = jsonEncode(mapPayloadBody);

    // Encode the payload JSON as UTF8
    List<int> utfEncodedString = utf8.encode(stringPayloadBodyJsonEncoded);

    try {
      // Attempt to upload the data to the API
      await http
          .post(
        '${stringUrl ?? _stringActiveEndpoint}/$stringPath',
        body: utfEncodedString,
        encoding: Encoding.getByName('utf-8'),
        headers: mapPayloadHeader,
      )
          .then((response) {
        // Write the status code to the API Result
        _networkCloudantResult.statusCode =
            _checkStatusCode(intStatusCode: response.statusCode);

        // Check to see if a response was received
        if (response.body != null && response.body != '') {
          // Translate the response to a map after decoding to UTF-8
          Map mapBody = jsonDecode(utf8.decode(response.bodyBytes));

          // Write the response data to the API Result
          _networkCloudantResult.docs = mapBody['docs'];
          _networkCloudantResult.bookmark = mapBody['bookmark'];
          _networkCloudantResult.warning = mapBody['warning'];
        }
      });
    } catch (error) {
      // Do nothing; the default value of mapResults is an empty map
      print('Network.dart - Error: $error');

      // Record that an error occured
      _networkCloudantResult.error = error;
    }

    return _networkCloudantResult;
  }

  /// Send the POST request to the API
  static Future<NetworkResult> post({
    String stringUrl,
    @required String stringPath,
    @required Map<String, Object> mapPayloadBody,
    @required Map<String, String> mapPayloadHeader,
  }) async {
    NetworkCloudantResult _networkCloudantResult = NetworkCloudantResult();

    // Encode the payload to JSON
    String stringPayloadBodyJsonEncoded = jsonEncode(mapPayloadBody);

    // Encode the payload JSON as UTF8
    List<int> utfEncodedString = utf8.encode(stringPayloadBodyJsonEncoded);

    try {
      // Attempt to upload the data to the API
      await http
          .post(
        '${stringUrl ?? _stringActiveEndpoint}/$stringPath',
        body: utfEncodedString,
        encoding: Encoding.getByName('utf-8'),
        headers: mapPayloadHeader,
      )
          .then((response) {
        // Write the status code to the API Result
        _networkCloudantResult.statusCode =
            _checkStatusCode(intStatusCode: response.statusCode);
      });
    } catch (error) {
      // Do nothing; the default value of mapResults is an empty map
      print('Network.dart - Error: $error');

      // Record that an error occured
      _networkCloudantResult.error = error;
    }

    return _networkCloudantResult;
  }

  /// Send the PUT request to the API
  static Future<NetworkResult> put({
    String stringUrl,
    @required String stringPath,
    @required String stringId,
    @required String stringRevision,
    @required Map<String, Object> mapPayloadBody,
    @required Map<String, String> mapPayloadHeader,
  }) async {
    NetworkResult _networkResult = NetworkResult();

    // Encode the payload to JSON
    String stringPayloadBodyJsonEncoded = jsonEncode(mapPayloadBody);

    // Encode the payload JSON as UTF8
    List<int> utfEncodedString = utf8.encode(stringPayloadBodyJsonEncoded);

    try {
      // Attempt to upload the data to the API
      await http
          .put(
        '${stringUrl ?? _stringActiveEndpoint}/$stringPath/$stringId?rev=$stringRevision',
        body: utfEncodedString,
        encoding: Encoding.getByName('utf-8'),
        headers: mapPayloadHeader,
      )
          .then((response) {
        // Write the status code to the API Result
        _networkResult.statusCode =
            _checkStatusCode(intStatusCode: response.statusCode);

        // Check to see if a response was received
        if (response.body != null && response.body != '') {
          // Write the response data to the API Result
          _networkResult.data = jsonDecode(utf8.decode(response.bodyBytes));
        }
      });
    } catch (error) {
      // Do nothing; the default value of mapResults is an empty map
      print('Network.dart - Error: $error');

      // Record that an error occured
      _networkResult.error = error;
    }

    return _networkResult;
  }
}
