import 'dart:convert';
import 'package:aae/common/network/network.dart';
import 'package:aae/common/network/network_cloudant_result.dart';
import 'package:aae/common/network/network_result.dart';
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
      return 'https://uisheitzearionstoodueget:eccadc4ad470f4ed210410939dc5a2115b0d7b58@ebc9e7bc-8615-4d08-8451-4f7f5c7d85ee-bluemix.cloudant.com'; // Do NOT include a trailing forward slash!
    } else if (apiEndpoint == _ApiEndpoint.Production) {
      return 'https://api.aa.com'; // Do NOT include a trailing forward slash!
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
      print(
          'Network.dart - You need to sign out and then sign back in to generate a new authorization token!');

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
          _networkResult.data = jsonDecode(response.body);
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
          _networkResult.data = jsonDecode(response.body);
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

    // Encode the API input
    String stringPayloadBodyEncoded = jsonEncode(mapPayloadBody);

    try {
      // Attempt to upload the data to the API
      await http
          .post(
        '${stringUrl ?? _stringActiveEndpoint}/$stringPath',
        body: stringPayloadBodyEncoded,
        encoding: Encoding.getByName('utf-8'),
        headers: mapPayloadHeader,
      )
          .then((response) {
        // Write the status code to the API Result
        _networkCloudantResult.statusCode =
            _checkStatusCode(intStatusCode: response.statusCode);

        // Check to see if a response was received
        if (response.body != null && response.body != '') {
          // Decode the response body
          Map mapBody = jsonDecode(response.body);

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

    // Encode the API input
    String stringPayloadBodyEncoded = jsonEncode(mapPayloadBody);

    try {
      // Attempt to upload the data to the API
      await http
          .post(
        '${stringUrl ?? _stringActiveEndpoint}/$stringPath',
        body: stringPayloadBodyEncoded,
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

    // Encode the API input
    String stringPayloadBodyEncoded = jsonEncode(mapPayloadBody);

    try {
      // Attempt to upload the data to the API
      await http
          .put(
        '${stringUrl ?? _stringActiveEndpoint}/$stringPath/$stringId?rev=$stringRevision',
        body: stringPayloadBodyEncoded,
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
          _networkResult.data = jsonDecode(response.body);
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
