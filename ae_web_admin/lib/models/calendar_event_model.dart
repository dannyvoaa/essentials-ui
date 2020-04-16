import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:flutter/foundation.dart';

class CalendarEventModel {
  // Setup any required variables
  String id;
  String revision;
  bool allDay;
  String contactEmail;
  String contactName;
  String contactPhone;
  DateTime dateTimeEnd;
  DateTime dateTimeStart;
  bool ebrg;
  int end;
  String eventDescription;
  String eventName;
  String locationAddress1;
  String locationAddress2;
  String locationCity;
  String locationState;
  String locationRoomNumber;
  String locationVenue;
  int start;
  int timeZoneOffset;
  int created;
  String createdBy;
  int updated;
  String updatedBy;
  CalendarEventModel Function({@required dynamic object}) jsonDecode;
  Future<Map<String, dynamic>> Function() jsonEncode;

  // Initialize the model
  CalendarEventModel({
    this.id,
    this.revision,
    this.allDay = false,
    this.contactEmail = '',
    this.contactName = '',
    this.contactPhone = '',
    this.dateTimeEnd,
    this.dateTimeStart,
    this.ebrg = false,
    this.end,
    this.eventDescription = '',
    this.eventName = '',
    this.locationAddress1 = '',
    this.locationAddress2 = '',
    this.locationCity = '',
    this.locationState = 'TX',
    this.locationRoomNumber = '',
    this.locationVenue = '',
    this.start,
    this.timeZoneOffset,
    this.created,
    this.createdBy = '',
    this.updated,
    this.updatedBy = '',
  }) {
    // Check to see if dateTimeEnd is null
    if (this.timeZoneOffset == null) {
      // Set a default value
      this.timeZoneOffset = DateTime.now().timeZoneOffset.inMinutes;
    }

    // Check to see if dateTimeStart is null
    if (this.start == null) {
      // Check to see if dateTimeStart is null
      if (this.dateTimeStart == null) {
        // Set a default value (in UTC time)
        this.dateTimeStart = DateTime.utc(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          08,
          00,
        ).subtract(
          Duration(minutes: this.timeZoneOffset),
        );
      }

      // Set a default value (in UTC time)
      this.start = DateUtilities.secondsSinceEpoch(
        dateTime: this.dateTimeStart,
      );
    }

    // Check to see if end is null
    if (this.end == null) {
      // Check to see if dateTimeEnd is null
      if (this.dateTimeEnd == null) {
        // Set a default value (in UTC time)
        this.dateTimeEnd = DateTime.utc(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          09,
          00,
        ).subtract(
          Duration(minutes: this.timeZoneOffset),
        );
      }

      // Set a default value (in UTC time)
      this.end = DateUtilities.secondsSinceEpoch(
        dateTime: this.dateTimeEnd,
      );
    }

    /// Decode an object to the model
    this.jsonDecode = ({@required dynamic object}) {
      return CalendarEventModel(
        allDay: object['allDay'],
        contactEmail: object['contactEmail'],
        contactName: object['contactName'],
        contactPhone: object['contactPhone'],
        created: object['created'],
        createdBy: object['createdBy'],
        dateTimeEnd: DateUtilities.dateTimeFromEpoch(
            intSecondsSinceEpoch: object['end']),
        dateTimeStart: DateUtilities.dateTimeFromEpoch(
            intSecondsSinceEpoch: object['start']),
        ebrg: object['ebrg'],
        end: object['end'],
        eventDescription: object['eventDescription'],
        eventName: object['eventName'],
        id: object['_id'],
        locationAddress1: object['locationAddress1'],
        locationAddress2: object['locationAddress2'],
        locationCity: object['locationCity'],
        locationRoomNumber: object['locationRoomNumber'],
        locationState: object['locationState'],
        locationVenue: object['locationVenue'],
        revision: object['_rev'],
        start: object['start'],
        timeZoneOffset: object['timeZoneOffset'],
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
        'allDay': this.allDay,
        'contactEmail': this.contactEmail,
        'contactName': this.contactName,
        'contactPhone': this.contactPhone,
        'ebrg': this.ebrg,
        'end': DateUtilities.secondsSinceEpoch(dateTime: this.dateTimeEnd),
        'endLocal': DateUtilities.secondsSinceEpoch(
            dateTime:
                this.dateTimeEnd.add(Duration(minutes: this.timeZoneOffset))),
        'endYear': this.dateTimeEnd.year,
        'endMonth': this.dateTimeEnd.month,
        'endDay': this.dateTimeEnd.day,
        'endHour': this.dateTimeEnd.hour,
        'endMinute': this.dateTimeEnd.minute,
        'eventDescription': this.eventDescription,
        'eventName': this.eventName,
        'locationAddress1': this.locationAddress1,
        'locationAddress2': this.locationAddress2,
        'locationCity': this.locationCity,
        'locationState': this.locationState,
        'locationRoomNumber': this.locationRoomNumber,
        'locationVenue': this.locationVenue,
        'start': DateUtilities.secondsSinceEpoch(dateTime: this.dateTimeStart),
        'startLocal': DateUtilities.secondsSinceEpoch(
            dateTime:
                this.dateTimeStart.add(Duration(minutes: this.timeZoneOffset))),
        'startYear': this.dateTimeStart.year,
        'startMonth': this.dateTimeStart.month,
        'startDay': this.dateTimeStart.day,
        'startHour': this.dateTimeStart.hour,
        'startMinute': this.dateTimeStart.minute,
        'timeZoneOffset': this.timeZoneOffset,
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
