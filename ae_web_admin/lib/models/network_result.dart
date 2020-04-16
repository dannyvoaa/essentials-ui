import 'package:american_essentials_web_admin/common/network.dart';

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