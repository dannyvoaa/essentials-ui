import 'package:flutter/foundation.dart';

class UserPreferencesModel {
  // Setup any required variables
  String location;
  List<String> topics;
  List<String> workgroup;
  UserPreferencesModel Function({@required dynamic object}) jsonDecode;

  // Initialize the model
  UserPreferencesModel({
    this.location,
    this.topics,
    this.workgroup
  }) {

    
    
    /// Decode an object to the model
    this.jsonDecode = ({@required dynamic object}) {
      return UserPreferencesModel(
        location: object['location'],
        topics: List<String>.from(object['topics']),
        workgroup: List<String>.from(object['workgroup']),
      );
    };
  }
}