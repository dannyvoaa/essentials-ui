import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:flutter/foundation.dart';

class LocationsModel {
  // Setup any required variables
  String id;
  String revision;
  String city;
  String country;
  String faa;
  String icao;
  String name;
  String state;
  int created;
  String createdBy;
  int updated;
  String updatedBy;
  LocationsModel Function({@required dynamic object}) jsonDecode;
  Future<Map<String, dynamic>> Function() jsonEncode;

  // Initialize the model
  LocationsModel({
    this.id,
    this.revision,
    this.city = '',
    this.country = '',
    this.faa = '',
    this.icao = '',
    this.name = '',
    this.state = '',
    this.created,
    this.createdBy = '',
    this.updated,
    this.updatedBy = ''
  }) {


    /// Decode an object to the model
    this.jsonDecode = ({@required dynamic object}) {
      return LocationsModel(
        id: object['_id'],
        city: object['city'],
        country: object['country'],
        faa: object['faa'],
        icao: object['icao'],
        name: object['name'],
        revision: object['_rev'],
        state: object['state'],
        updated: object['updated'],
        updatedBy: object['updatedBy'],
      );
    };

    /// Encode the model to a the format expected by the database
    this.jsonEncode = () async {
      // Initialize local storage
      LocalStorage _localStorage = LocalStorage();
      await _localStorage.initialize();

      // Setup any required variables
      Map<String, Object> map;

      // Generate the JSON
      map = {
        'city': this.city,
        'country': this.country,
        'faa': this.faa,
        'icao': this.icao,
        'name': this.name,
        'state': this.state,
        'created': this.id == null
            ? DateUtilities.secondsSinceEpoch(dateTime: DateTime.now().toUtc())
            : this.created,
        'createdBy': this.id == null
            ? _localStorage.sharedPreferences.getString('auth.username')
            : this.createdBy,
        'updated':
            DateUtilities.secondsSinceEpoch(dateTime: DateTime.now().toUtc()),
        'updatedBy': _localStorage.sharedPreferences.getString('auth.username'),
      };

      // Check to see if an ID was specified
      // - This differentiates between an insert and an update
      if (this.id != null) {
        // Add the ID and Revision data
        map['_id'] = this.id;
        map['_rev'] = this.revision;
      }

      return map;
    };
  }
}