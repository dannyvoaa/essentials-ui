import 'package:flutter/foundation.dart';

class NotificationModel {
  // Setup any required variables
  List<String> listDeviceTokens;
  DateTime dateTimeScheduled;
  String stringBody;
  String stringTitle;

  // Initialize the model
  NotificationModel({
    @required this.listDeviceTokens,
    @required this.dateTimeScheduled,
    @required this.stringBody,
    @required this.stringTitle,
  });
}