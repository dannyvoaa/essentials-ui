import 'package:american_essentials_web_admin/models/user_preferences_model.dart';
import 'package:flutter/foundation.dart';

class UsersModel {
  // Setup any required variables
  String id;
  String revision;
  String aaId;
  UserPreferencesModel preferences;
  int created;
  int updated;
  UsersModel Function({@required dynamic object}) jsonDecode;

  // Initialize the model
  UsersModel({
    this.id,
    this.revision,
    this.aaId,
    this.preferences,
    this.created,
    this.updated,
  }) {

    
    
    /// Decode an object to the model
    this.jsonDecode = ({@required dynamic object}) {
      return UsersModel(
        aaId: object['aaId'],
        created: object['created'],
        id: object['_id'],
        preferences: UserPreferencesModel().jsonDecode(object: object['preferences']),
        revision: object['_rev'],
        updated: object['updated'],
      );
    };
  }
}