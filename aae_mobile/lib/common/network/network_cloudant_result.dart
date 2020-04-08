import 'package:aae/common/network/network_result.dart';

class NetworkCloudantResult extends NetworkResult {
  // Setup any required variables
  List docs;
  String bookmark;
  String warning;

  // Initialize the model
  NetworkCloudantResult({
    this.docs,
    this.bookmark,
    this.warning,
  });
}
