import 'package:aae/common/network/network.dart';

class NetworkResult {
  // Setup any required variables
  HttpStatusCode statusCode;
  Object error;
  Object data;

  // Initialize the model
  NetworkResult({
    this.statusCode,
    this.error,
    this.data,
  });
}
