import 'package:american_essentials_web_admin/api/api_calendar_events_add.dart';
import 'package:american_essentials_web_admin/api/api_calendar_events_update.dart';
import 'package:american_essentials_web_admin/common/api_helper.dart';
import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/common/validation.dart';
import 'package:american_essentials_web_admin/models/calendar_event_model.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/views/calendar/calendar_view.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/controls/drop_down_menu.dart';
import 'package:american_essentials_web_admin/widgets/general/form_row.dart';
import 'package:american_essentials_web_admin/widgets/general/form_title.dart';
import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:american_essentials_web_admin/widgets/processing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _EventTimeMode {
  End,
  Start,
}

enum _Mode {
  Add,
  Update,
}

class CalendarAddView extends StatefulWidget {
  static String routeId = 'CalendarAddView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  CalendarAddView({this.payload});

  @override
  _CalendarAddViewState createState() => _CalendarAddViewState();
}

class _CalendarAddViewState extends State<CalendarAddView> {
  // Setup any required variables
  GlobalKey<FormState> _formKey;
  bool boolSelectedTimesValid = false;
  CalendarEventModel _calendarEventModel = CalendarEventModel();
  _Mode _mode = _Mode.Add;

  @override
  void initState() {
    super.initState();

    // Check to see if a payload was supplied
    if (widget.payload != null) {
      // Switch the view to update mode
      _mode = _Mode.Update;

      // Save the model payload to a local variable
      _calendarEventModel = widget.payload['calendarEventModel'];
    }

    // Adjust the start and end dates taking the UTC offset into account
    _calendarEventModel.dateTimeStart = _calendarEventModel.dateTimeStart
        .add(Duration(minutes: _calendarEventModel.timeZoneOffset));
    _calendarEventModel.dateTimeEnd = _calendarEventModel.dateTimeEnd
        .add(Duration(minutes: _calendarEventModel.timeZoneOffset));

    // Initialize the form key
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    // Check to see if the times are valid
    boolSelectedTimesValid = !_calendarEventModel.allDay
        ? Validation.date(
            dateTime1: this._calendarEventModel.dateTimeStart,
            dateTime2: this._calendarEventModel.dateTimeEnd,
            dateComparitor: DateComparitor.LessThan,
          )
        : true;

    return PageFrame(
      stringHeaderTitle: _mode == _Mode.Add ? 'Create Event' : 'Edit Event',
      widgetBody: Form(
        child: Column(
          children: <Widget>[
            FormFieldTitle(
              stringTitle: 'Date & Time',
              titleStyle: TitleStyle.Title2,
            ),
            FormFieldTitle(
              stringTitle: 'Date',
              titleStyle: TitleStyle.Title3,
            ),
            this._eventDate(),
            FormFieldTitle(
              stringTitle: 'Date',
              titleStyle: TitleStyle.Title3,
            ),
            this._eventTime(),
            FormFieldTitle(
              stringTitle: 'Event Details',
              titleStyle: TitleStyle.Title2,
            ),
            this._eventTitleDescription(),
            FormFieldTitle(
              stringTitle: 'Event Location',
              titleStyle: TitleStyle.Title2,
            ),
            FormFieldTitle(
              stringTitle: 'Location',
              titleStyle: TitleStyle.Title3,
            ),
            this._eventLocation(),
            FormFieldTitle(
              stringTitle: 'Address',
              titleStyle: TitleStyle.Title3,
            ),
            this._eventLocationAddress(),
            FormFieldTitle(
              stringTitle: 'Other Information',
              titleStyle: TitleStyle.Title2,
            ),
            this._eventEBRG(),
            FormFieldTitle(
              stringTitle: 'Contact Information',
              titleStyle: TitleStyle.Title2,
            ),
            this._eventContactInfo(),
            SizedBox(
              height: Dimensions.size16px,
            ),
            RoundedButton(
              child: Text(_mode == _Mode.Add ? 'Create Event' : 'Edit Event'),
              onPressed: () async {
                // Check to see if the form is valid
                if (_formKey.currentState.validate() &&
                    boolSelectedTimesValid) {
                  // Adjust the start and end dates taking the UTC offset into account
                  _calendarEventModel.dateTimeStart =
                      _calendarEventModel.dateTimeStart.subtract(Duration(
                          minutes: _calendarEventModel.timeZoneOffset));
                  _calendarEventModel.dateTimeEnd =
                      _calendarEventModel.dateTimeEnd.subtract(Duration(
                          minutes: _calendarEventModel.timeZoneOffset));

                  // Save the selected value to a local variable as time since the UNIX epoch
                  _calendarEventModel.start = DateUtilities.secondsSinceEpoch(
                      dateTime: _calendarEventModel.dateTimeStart);
                  _calendarEventModel.end = DateUtilities.secondsSinceEpoch(
                      dateTime: _calendarEventModel.dateTimeEnd);

                  // Check to see if the view is in add or update mode
                  if (_mode == _Mode.Add) {
                    // Show the Processing view
                    Processing.showProcessingView(buildContext: context);

                    // Attempt to insert the calendar event
                    ApiCalendarEventsAddResult apiCalendarEventsAddResult =
                        await ApiCalendarEventsAdd.sendRequest(
                      calendarEventModel: _calendarEventModel,
                    );

                    // Execute the API Helper
                    ApiHelper.execute(
                      buildContext: context,
                      boolDismissProcessingOnError: true,
                      httpStatusCode: apiCalendarEventsAddResult.statusCode,
                      onSuccess: () {
                        // Hide the processing view
                        Processing.dismiss(buildContext: context);

                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: context,
                          stringRouteId: CalendarView.routeId,
                        );
                      },
                    );
                  } else {
                    // Show the Processing view
                    Processing.showProcessingView(buildContext: context);

                    // Attempt to update the calendar event
                    ApiCalendarEventsUpdateResult
                        apiCalendarEventsUpdateResult =
                        await ApiCalendarEventsUpdate.sendRequest(
                      calendarEventModel: _calendarEventModel,
                    );

                    // Execute the API Helper
                    ApiHelper.execute(
                      buildContext: context,
                      boolDismissProcessingOnError: true,
                      httpStatusCode: apiCalendarEventsUpdateResult.statusCode,
                      onSuccess: () {
                        // Hide the processing view
                        Processing.dismiss(buildContext: context);

                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: context,
                          stringRouteId: CalendarView.routeId,
                        );
                      },
                    );
                  }
                }
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        key: this._formKey,
      ),
    );
  }

  // MARK: - Widgets

  /// A drop down button widget that handles time of day selection
  Widget _dropDownButtonAmPm({
    @required bool boolValid,
    @required _EventTimeMode eventTimeMode,
  }) {
    return RoundedDropDownMenu(
      boolValid: boolValid,
      listDropDownMenuItems: [
        DropdownMenuItem(
          child: Text('AM'),
          value: 'AM',
        ),
        DropdownMenuItem(
          child: Text('PM'),
          value: 'PM',
        ),
      ],
      onDropdownChanged: (String stringSelected) {
        // Check to see if we're modifying the start time or end time
        if (eventTimeMode == _EventTimeMode.Start) {
          // Check to see if AM or PM was selected
          if (stringSelected == 'AM' &&
              _calendarEventModel.dateTimeStart.hour >= 12) {
            // Save the selected value to a local variable
            _calendarEventModel.dateTimeStart = DateTime.utc(
                _calendarEventModel.dateTimeStart.year,
                _calendarEventModel.dateTimeStart.month,
                _calendarEventModel.dateTimeStart.day,
                _calendarEventModel.dateTimeStart.hour - 12,
                _calendarEventModel.dateTimeStart.minute);
          } else if (stringSelected == 'PM' &&
              _calendarEventModel.dateTimeStart.hour < 12) {
            // Save the selected value to a local variable
            _calendarEventModel.dateTimeStart = DateTime.utc(
                _calendarEventModel.dateTimeStart.year,
                _calendarEventModel.dateTimeStart.month,
                _calendarEventModel.dateTimeStart.day,
                _calendarEventModel.dateTimeStart.hour + 12,
                _calendarEventModel.dateTimeStart.minute);
          }
        } else {
          // Check to see if AM or PM was selected
          if (stringSelected == 'AM' &&
              _calendarEventModel.dateTimeEnd.hour >= 12) {
            // Save the selected value to a local variable
            _calendarEventModel.dateTimeEnd = DateTime.utc(
                _calendarEventModel.dateTimeEnd.year,
                _calendarEventModel.dateTimeEnd.month,
                _calendarEventModel.dateTimeEnd.day,
                _calendarEventModel.dateTimeEnd.hour - 12,
                _calendarEventModel.dateTimeEnd.minute);
          } else if (stringSelected == 'PM' &&
              _calendarEventModel.dateTimeEnd.hour < 12) {
            // Save the selected value to a local variable
            _calendarEventModel.dateTimeEnd = DateTime.utc(
                _calendarEventModel.dateTimeEnd.year,
                _calendarEventModel.dateTimeEnd.month,
                _calendarEventModel.dateTimeEnd.day,
                _calendarEventModel.dateTimeEnd.hour + 12,
                _calendarEventModel.dateTimeEnd.minute);
          }
        }

        // Update the application's state
        setState(() {});
      },
      selected: eventTimeMode == _EventTimeMode.Start
          ? _calendarEventModel.dateTimeStart.hour < 12 ? 'AM' : 'PM'
          : _calendarEventModel.dateTimeEnd.hour < 12 ? 'AM' : 'PM',
    );
  }

  /// A drop down button widget that handles day selection
  Widget _dropDownButtonDay() {
    List<DropdownMenuItem> listDowndownMenuItems = List<DropdownMenuItem>();

    // Retreive the number of days in the selected month/year combination
    int _intNumberOfDaysInMonth = DateUtilities.daysInMonth(
        intYear: _calendarEventModel.dateTimeStart.year,
        intMonth: _calendarEventModel.dateTimeStart.month);

    // Iterate through each day in the given month
    for (int i = 1; i < _intNumberOfDaysInMonth; i++) {
      // Add the day to the list of days
      listDowndownMenuItems.add(
        DropdownMenuItem(
          child: Text(i.toString()),
          value: i.toString(),
        ),
      );
    }

    return RoundedDropDownMenu(
      listDropDownMenuItems: listDowndownMenuItems ?? [],
      onDropdownChanged: (String stringSelected) {
        // Save the selected value to a local variable
        _calendarEventModel.dateTimeStart = DateTime.utc(
            _calendarEventModel.dateTimeStart.year,
            _calendarEventModel.dateTimeStart.month,
            int.parse(stringSelected),
            _calendarEventModel.dateTimeStart.hour,
            _calendarEventModel.dateTimeStart.minute);
        _calendarEventModel.dateTimeEnd = DateTime.utc(
            _calendarEventModel.dateTimeEnd.year,
            _calendarEventModel.dateTimeEnd.month,
            int.parse(stringSelected),
            _calendarEventModel.dateTimeEnd.hour,
            _calendarEventModel.dateTimeEnd.minute);

        // Update the application's state
        setState(() {});
      },
      selected: _calendarEventModel.dateTimeStart.day.toString(),
    );
  }

  /// A drop down button widget that handles hour selection
  Widget _dropDownButtonHour({
    @required bool boolValid,
    @required _EventTimeMode eventTimeMode,
  }) {
    return RoundedDropDownMenu(
      boolValid: boolValid,
      listDropDownMenuItems: [
        DropdownMenuItem(
          child: Text('12'),
          value: '0',
        ),
        DropdownMenuItem(
          child: Text('1'),
          value: '1',
        ),
        DropdownMenuItem(
          child: Text('2'),
          value: '2',
        ),
        DropdownMenuItem(
          child: Text('3'),
          value: '3',
        ),
        DropdownMenuItem(
          child: Text('4'),
          value: '4',
        ),
        DropdownMenuItem(
          child: Text('5'),
          value: '5',
        ),
        DropdownMenuItem(
          child: Text('6'),
          value: '6',
        ),
        DropdownMenuItem(
          child: Text('7'),
          value: '7',
        ),
        DropdownMenuItem(
          child: Text('8'),
          value: '8',
        ),
        DropdownMenuItem(
          child: Text('9'),
          value: '9',
        ),
        DropdownMenuItem(
          child: Text('10'),
          value: '10',
        ),
        DropdownMenuItem(
          child: Text('11'),
          value: '11',
        ),
      ],
      onDropdownChanged: (String stringSelected) {
        // Check to see if we're modifying the start time or end time
        if (eventTimeMode == _EventTimeMode.Start) {
          // Save the selected value to a local variable
          _calendarEventModel.dateTimeStart = DateTime.utc(
              _calendarEventModel.dateTimeStart.year,
              _calendarEventModel.dateTimeStart.month,
              _calendarEventModel.dateTimeStart.day,
              int.parse(stringSelected) +
                  (_calendarEventModel.dateTimeStart.hour < 12 ? 0 : 12),
              _calendarEventModel.dateTimeStart.minute);
        } else {
          // Save the selected value to a local variable
          _calendarEventModel.dateTimeEnd = DateTime.utc(
              _calendarEventModel.dateTimeEnd.year,
              _calendarEventModel.dateTimeEnd.month,
              _calendarEventModel.dateTimeEnd.day,
              int.parse(stringSelected) +
                  (_calendarEventModel.dateTimeEnd.hour < 12 ? 0 : 12),
              _calendarEventModel.dateTimeEnd.minute);
        }

        // Update the application's state
        setState(() {});
      },
      selected: eventTimeMode == _EventTimeMode.Start
          ? _calendarEventModel.dateTimeStart.hour < 12
              ? _calendarEventModel.dateTimeStart.hour.toString()
              : (_calendarEventModel.dateTimeStart.hour - 12).toString()
          : _calendarEventModel.dateTimeEnd.hour < 12
              ? _calendarEventModel.dateTimeEnd.hour.toString()
              : (_calendarEventModel.dateTimeEnd.hour - 12).toString(),
    );
  }

  /// A drop down button widget that handles minute selection
  Widget _dropDownButtonMinute({
    @required bool boolValid,
    @required _EventTimeMode eventTimeMode,
  }) {
    List<DropdownMenuItem> listDowndownMenuItems = List<DropdownMenuItem>();

    // Iterate through all of the minutes in an hour
    for (int intMinute = 00; intMinute <= 59; intMinute++) {
      // Add the minute to the list of minutes
      listDowndownMenuItems.add(
        DropdownMenuItem(
          child: Text(intMinute.toString().padLeft(2, '0')),
          value: intMinute.toString(),
        ),
      );
    }

    return RoundedDropDownMenu(
      boolValid: boolValid,
      listDropDownMenuItems: listDowndownMenuItems ?? [],
      onDropdownChanged: (String stringSelected) {
        // Check to see if we're modifying the start time or end time
        if (eventTimeMode == _EventTimeMode.Start) {
          // Save the selected value to a local variable
          _calendarEventModel.dateTimeStart = DateTime.utc(
              _calendarEventModel.dateTimeStart.year,
              _calendarEventModel.dateTimeStart.month,
              _calendarEventModel.dateTimeStart.day,
              _calendarEventModel.dateTimeStart.hour,
              int.parse(stringSelected));
        } else {
          // Save the selected value to a local variable
          _calendarEventModel.dateTimeEnd = DateTime.utc(
              _calendarEventModel.dateTimeEnd.year,
              _calendarEventModel.dateTimeEnd.month,
              _calendarEventModel.dateTimeEnd.day,
              _calendarEventModel.dateTimeEnd.hour,
              int.parse(stringSelected));
        }

        // Update the application's state
        setState(() {});
      },
      selected: eventTimeMode == _EventTimeMode.Start
          ? _calendarEventModel.dateTimeStart.minute.toString()
          : _calendarEventModel.dateTimeEnd.minute.toString(),
    );
  }

  /// A drop down button widget that handles month selection
  Widget _dropDownButtonMonth() {
    return RoundedDropDownMenu(
      listDropDownMenuItems: [
        DropdownMenuItem(
          child: Text('January'),
          value: '1',
        ),
        DropdownMenuItem(
          child: Text('February'),
          value: '2',
        ),
        DropdownMenuItem(
          child: Text('March'),
          value: '3',
        ),
        DropdownMenuItem(
          child: Text('April'),
          value: '4',
        ),
        DropdownMenuItem(
          child: Text('May'),
          value: '5',
        ),
        DropdownMenuItem(
          child: Text('June'),
          value: '6',
        ),
        DropdownMenuItem(
          child: Text('July'),
          value: '7',
        ),
        DropdownMenuItem(
          child: Text('August'),
          value: '8',
        ),
        DropdownMenuItem(
          child: Text('September'),
          value: '9',
        ),
        DropdownMenuItem(
          child: Text('October'),
          value: '10',
        ),
        DropdownMenuItem(
          child: Text('November'),
          value: '11',
        ),
        DropdownMenuItem(
          child: Text('December'),
          value: '12',
        ),
      ],
      onDropdownChanged: (String stringSelected) {
        // Check to see if the selected day is beyond the bounds of the list of selectable days
        if (_calendarEventModel.dateTimeStart.day <=
            DateUtilities.daysInMonth(
                intYear: _calendarEventModel.dateTimeStart.year,
                intMonth: int.parse(stringSelected))) {
          // Save the selected value to a local variable
          _calendarEventModel.dateTimeStart = DateTime.utc(
              _calendarEventModel.dateTimeStart.year,
              int.parse(stringSelected),
              _calendarEventModel.dateTimeStart.day,
              _calendarEventModel.dateTimeStart.hour,
              _calendarEventModel.dateTimeStart.minute);
          _calendarEventModel.dateTimeEnd = DateTime.utc(
              _calendarEventModel.dateTimeEnd.year,
              int.parse(stringSelected),
              _calendarEventModel.dateTimeEnd.day,
              _calendarEventModel.dateTimeEnd.hour,
              _calendarEventModel.dateTimeEnd.minute);
        } else {
          // Save the selected value to a local variable
          _calendarEventModel.dateTimeStart = DateTime.utc(
              _calendarEventModel.dateTimeStart.year,
              int.parse(stringSelected),
              1,
              _calendarEventModel.dateTimeStart.hour,
              _calendarEventModel.dateTimeStart.minute);
          _calendarEventModel.dateTimeEnd = DateTime.utc(
              _calendarEventModel.dateTimeEnd.year,
              int.parse(stringSelected),
              1,
              _calendarEventModel.dateTimeEnd.hour,
              _calendarEventModel.dateTimeEnd.minute);
        }

        // Update the application's state
        setState(() {});
      },
      selected: _calendarEventModel.dateTimeStart.month.toString(),
    );
  }

  /// A drop down button widget that handles time zone selection
  Widget _dropDownButtonTimezone({
    @required bool boolValid,
  }) {
    // TODO: Timezone support is rudimentary with the user having to select their UTC offset; is there not a better way to do this where we can look up the event's location on a specific date and determine the offset?

    return RoundedDropDownMenu(
      boolValid: boolValid,
      listDropDownMenuItems: [
        DropdownMenuItem(
          child: Text('UTC -11:00'),
          value: '-660',
        ),
        DropdownMenuItem(
          child: Text('UTC -10:00'),
          value: '-600',
        ),
        DropdownMenuItem(
          child: Text('UTC -9:00'),
          value: '-540',
        ),
        DropdownMenuItem(
          child: Text('UTC -8:00'),
          value: '-480',
        ),
        DropdownMenuItem(
          child: Text('UTC -7:00'),
          value: '-420',
        ),
        DropdownMenuItem(
          child: Text('UTC -6:00'),
          value: '-360',
        ),
        DropdownMenuItem(
          child: Text('UTC -5:00'),
          value: '-300',
        ),
        DropdownMenuItem(
          child: Text('UTC -4:00'),
          value: '-240',
        ),
        DropdownMenuItem(
          child: Text('UTC -3:00'),
          value: '-180',
        ),
        DropdownMenuItem(
          child: Text('UTC -2:00'),
          value: '-120',
        ),
        DropdownMenuItem(
          child: Text('UTC -1:00'),
          value: '-60',
        ),
        DropdownMenuItem(
          child: Text('UTC'),
          value: '0',
        ),
        DropdownMenuItem(
          child: Text('UTC +1:00'),
          value: '60',
        ),
        DropdownMenuItem(
          child: Text('UTC +2:00'),
          value: '120',
        ),
        DropdownMenuItem(
          child: Text('UTC +3:00'),
          value: '180',
        ),
        DropdownMenuItem(
          child: Text('UTC +4:00'),
          value: '240',
        ),
        DropdownMenuItem(
          child: Text('UTC +5:00'),
          value: '300',
        ),
        DropdownMenuItem(
          child: Text('UTC +6:00'),
          value: '360',
        ),
        DropdownMenuItem(
          child: Text('UTC +7:00'),
          value: '420',
        ),
        DropdownMenuItem(
          child: Text('UTC +8:00'),
          value: '480',
        ),
        DropdownMenuItem(
          child: Text('UTC +9:00'),
          value: '540',
        ),
        DropdownMenuItem(
          child: Text('UTC +10:00'),
          value: '600',
        ),
        DropdownMenuItem(
          child: Text('UTC +11:00'),
          value: '660',
        ),
      ],
      onDropdownChanged: (String stringSelected) {
        // Save the selected value to a local variable
        _calendarEventModel.timeZoneOffset = int.parse(stringSelected);

        // Update the application's state
        setState(() {});
      },
      selected: _calendarEventModel.timeZoneOffset.toString(),
    );
  }

  /// A drop down button widget that handles year selection
  Widget _dropDownButtonYear() {
    List<DropdownMenuItem> listDowndownMenuItems = List<DropdownMenuItem>();

    // Iterate through each year between now and five years from now
    for (int intYear = DateTime.now().year;
        intYear < (DateTime.now().year + 5);
        intYear++) {
      // Add the year to the list of years
      listDowndownMenuItems.add(
        DropdownMenuItem(
          child: Text(intYear.toString()),
          value: intYear.toString(),
        ),
      );
    }

    return RoundedDropDownMenu(
      listDropDownMenuItems: listDowndownMenuItems ?? [],
      onDropdownChanged: (String stringSelected) {
        // Save the selected value to a local variable
        _calendarEventModel.dateTimeStart = DateTime.utc(
            int.parse(stringSelected),
            _calendarEventModel.dateTimeStart.month,
            _calendarEventModel.dateTimeStart.day,
            _calendarEventModel.dateTimeStart.hour,
            _calendarEventModel.dateTimeStart.minute);
        _calendarEventModel.dateTimeEnd = DateTime.utc(
            int.parse(stringSelected),
            _calendarEventModel.dateTimeEnd.month,
            _calendarEventModel.dateTimeEnd.day,
            _calendarEventModel.dateTimeEnd.hour,
            _calendarEventModel.dateTimeEnd.minute);

        // Update the application's state
        setState(() {});
      },
      selected: _calendarEventModel.dateTimeStart.year.toString(),
    );
  }

  ///
  Widget _error({@required bool boolValid, @required String stringError}) {
    return !boolValid
        ? Container(
            child: Text(
              stringError,
              style: TextStyles.error(),
            ),
            margin: EdgeInsets.only(
              left: Dimensions.size16px,
            ),
            padding: EdgeInsets.only(
              top: Dimensions.size8px,
            ),
          )
        : Container();
  }

  /// Information regarding contact information of the event
  Widget _eventContactInfo() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Name',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.contactName,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.contactName = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _calendarEventModel.contactName,
                  stringError: "Please enter the contact's name",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'Email Address',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.contactEmail,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.contactEmail = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _calendarEventModel.contactEmail,
                  stringError: "Please enter the contact's email address",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'Phone Number',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.contactPhone,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.contactPhone = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _calendarEventModel.contactPhone,
                  stringError: "Please enter the contact's phone number",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        )
      ],
    );
  }

  /// Information regarding the date of the event
  Widget _eventDate() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Event Date',
          widget: Row(
            children: <Widget>[
              this._dropDownButtonMonth(),
              SizedBox(
                width: Dimensions.size8px,
              ),
              this._dropDownButtonDay(),
              SizedBox(
                width: Dimensions.size8px,
              ),
              this._dropDownButtonYear(),
              SizedBox(
                width: Dimensions.size8px,
              ),
              Text('(' +
                  DateFormat.EEEE()
                      .format(this._calendarEventModel.dateTimeStart) +
                  ')'),
            ],
          ),
        )
      ],
    );
  }

  /// Information regarding the EBRG status of the event
  Widget _eventEBRG() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'EBRG Event',
          widget: Column(
            children: <Widget>[
              RoundedDropDownMenu(
                listDropDownMenuItems: [
                  DropdownMenuItem(
                    child: Text('Yes'),
                    value: '1',
                  ),
                  DropdownMenuItem(
                    child: Text('No'),
                    value: '0',
                  ),
                ],
                onDropdownChanged: (String stringSelected) {
                  // Save the selected value to a local variable
                  _calendarEventModel.ebrg =
                      stringSelected == '1' ? true : false;

                  // Update the application's state
                  setState(() {});
                },
                selected: _calendarEventModel.ebrg ? '1' : '0',
              ),
            ],
          ),
        )
      ],
    );
  }

  /// Information regarding the location of the event
  Widget _eventLocation() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Venue',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.locationVenue,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.locationVenue = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _calendarEventModel.locationVenue,
                  stringError: "Please enter a venue",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'Room Number',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.locationRoomNumber,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.locationRoomNumber = stringValue;
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        )
      ],
    );
  }

  /// Information regarding the location (address) of the event
  Widget _eventLocationAddress() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Address 1',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.locationAddress1,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.locationAddress1 = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _calendarEventModel.locationAddress1,
                  stringError: "Please enter an address",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'Address 2',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.locationAddress2,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.locationAddress2 = stringValue;
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'City',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.locationCity,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.locationCity = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _calendarEventModel.locationCity,
                  stringError: "Please enter a city",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'State',
          widget: RoundedDropDownMenu(
            listDropDownMenuItems: [
              DropdownMenuItem(
                child: Text('Alabama'),
                value: 'AL',
              ),
              DropdownMenuItem(
                child: Text('Alaska'),
                value: 'AK',
              ),
              DropdownMenuItem(
                child: Text('Arizona'),
                value: 'AZ',
              ),
              DropdownMenuItem(
                child: Text('Arkansas'),
                value: 'AR',
              ),
              DropdownMenuItem(
                child: Text('California'),
                value: 'CA',
              ),
              DropdownMenuItem(
                child: Text('Colorado'),
                value: 'CO',
              ),
              DropdownMenuItem(
                child: Text('Connecticut'),
                value: 'CT',
              ),
              DropdownMenuItem(
                child: Text('Delaware'),
                value: 'DE',
              ),
              DropdownMenuItem(
                child: Text('District of Columbia'),
                value: 'DC',
              ),
              DropdownMenuItem(
                child: Text('Florida'),
                value: 'FL',
              ),
              DropdownMenuItem(
                child: Text('Georgia'),
                value: 'GA',
              ),
              DropdownMenuItem(
                child: Text('Hawaii'),
                value: 'HI',
              ),
              DropdownMenuItem(
                child: Text('Idaho'),
                value: 'ID',
              ),
              DropdownMenuItem(
                child: Text('Illinois'),
                value: 'IL',
              ),
              DropdownMenuItem(
                child: Text('Indiana'),
                value: 'IN',
              ),
              DropdownMenuItem(
                child: Text('Iowa'),
                value: 'IA',
              ),
              DropdownMenuItem(
                child: Text('Kansas'),
                value: 'KS',
              ),
              DropdownMenuItem(
                child: Text('Kentucky'),
                value: 'KY',
              ),
              DropdownMenuItem(
                child: Text('Louisiana'),
                value: 'LA',
              ),
              DropdownMenuItem(
                child: Text('Maine'),
                value: 'ME',
              ),
              DropdownMenuItem(
                child: Text('Maryland'),
                value: 'MD',
              ),
              DropdownMenuItem(
                child: Text('Massachusetts'),
                value: 'MA',
              ),
              DropdownMenuItem(
                child: Text('Michigan'),
                value: 'MI',
              ),
              DropdownMenuItem(
                child: Text('Minnesota'),
                value: 'MN',
              ),
              DropdownMenuItem(
                child: Text('Mississippi'),
                value: 'MS',
              ),
              DropdownMenuItem(
                child: Text('Missouri'),
                value: 'MO',
              ),
              DropdownMenuItem(
                child: Text('Montana'),
                value: 'MT',
              ),
              DropdownMenuItem(
                child: Text('Nebraska'),
                value: 'NE',
              ),
              DropdownMenuItem(
                child: Text('Nevada'),
                value: 'NV',
              ),
              DropdownMenuItem(
                child: Text('New Hampshire'),
                value: 'NH',
              ),
              DropdownMenuItem(
                child: Text('New Jersey'),
                value: 'NJ',
              ),
              DropdownMenuItem(
                child: Text('New Mexico'),
                value: 'NM',
              ),
              DropdownMenuItem(
                child: Text('New York'),
                value: 'NY',
              ),
              DropdownMenuItem(
                child: Text('North Carolina'),
                value: 'NC',
              ),
              DropdownMenuItem(
                child: Text('North Dakota'),
                value: 'ND',
              ),
              DropdownMenuItem(
                child: Text('Ohio'),
                value: 'OH',
              ),
              DropdownMenuItem(
                child: Text('Oklahoma'),
                value: 'OK',
              ),
              DropdownMenuItem(
                child: Text('Oregon'),
                value: 'OR',
              ),
              DropdownMenuItem(
                child: Text('Pennsylvania'),
                value: 'PA',
              ),
              DropdownMenuItem(
                child: Text('Puerto Rico'),
                value: 'PR',
              ),
              DropdownMenuItem(
                child: Text('Rhode Island'),
                value: 'RI',
              ),
              DropdownMenuItem(
                child: Text('South Carolina'),
                value: 'SC',
              ),
              DropdownMenuItem(
                child: Text('South Dakota'),
                value: 'SD',
              ),
              DropdownMenuItem(
                child: Text('Tennessee'),
                value: 'TN',
              ),
              DropdownMenuItem(
                child: Text('Texas'),
                value: 'TX',
              ),
              DropdownMenuItem(
                child: Text('U.S. Virgin Islands'),
                value: 'VI',
              ),
              DropdownMenuItem(
                child: Text('Utah'),
                value: 'UT',
              ),
              DropdownMenuItem(
                child: Text('Vermont'),
                value: 'VT',
              ),
              DropdownMenuItem(
                child: Text('Virginia'),
                value: 'VA',
              ),
              DropdownMenuItem(
                child: Text('Washington'),
                value: 'WA',
              ),
              DropdownMenuItem(
                child: Text('West Virginia'),
                value: 'WV',
              ),
              DropdownMenuItem(
                child: Text('Wisconsin'),
                value: 'WI',
              ),
              DropdownMenuItem(
                child: Text('Wyoming'),
                value: 'WY',
              ),
            ],
            onDropdownChanged: (String stringSelected) {
              // Save the selected value to a local variable
              _calendarEventModel.locationState = stringSelected;

              // Update the application's state
              setState(() {});
            },
            selected: _calendarEventModel.locationState,
          ),
        )
      ],
    );
  }

  /// Information regarding the time of the event
  Widget _eventTime() {
    // Create the default list of input items
    List<Widget> listStartStopTime = [
      FormFieldRow(
        stringTitle: 'Start Time',
        widget: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                this._dropDownButtonHour(
                  boolValid: boolSelectedTimesValid,
                  eventTimeMode: _EventTimeMode.Start,
                ),
                SizedBox(
                  width: Dimensions.size8px,
                ),
                this._dropDownButtonMinute(
                  boolValid: boolSelectedTimesValid,
                  eventTimeMode: _EventTimeMode.Start,
                ),
                SizedBox(
                  width: Dimensions.size8px,
                ),
                this._dropDownButtonAmPm(
                  boolValid: boolSelectedTimesValid,
                  eventTimeMode: _EventTimeMode.Start,
                ),
              ],
            ),
            this._error(
              boolValid: this.boolSelectedTimesValid,
              stringError: 'Start Time must be before End Time',
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      FormFieldRow(
        stringTitle: 'End Time',
        widget: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                this._dropDownButtonHour(
                  boolValid: boolSelectedTimesValid,
                  eventTimeMode: _EventTimeMode.End,
                ),
                SizedBox(
                  width: Dimensions.size8px,
                ),
                this._dropDownButtonMinute(
                  boolValid: boolSelectedTimesValid,
                  eventTimeMode: _EventTimeMode.End,
                ),
                SizedBox(
                  width: Dimensions.size8px,
                ),
                this._dropDownButtonAmPm(
                  boolValid: boolSelectedTimesValid,
                  eventTimeMode: _EventTimeMode.End,
                ),
              ],
            ),
            this._error(
              boolValid: this.boolSelectedTimesValid,
              stringError: 'End Time must be after Start Time',
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      FormFieldRow(
        stringTitle: 'Timezone',
        widget: this._dropDownButtonTimezone(
          boolValid: true,
        ),
      ),
    ];

    // Check to see if this is an all-day event
    if (_calendarEventModel.allDay) {
      // Clear the list
      listStartStopTime.clear();
    }

    // Add the 'All Day' switch to the list of input items
    listStartStopTime.add(
      FormFieldRow(
        stringTitle: 'All Day',
        widget: Column(
          children: <Widget>[
            RoundedDropDownMenu(
              listDropDownMenuItems: [
                DropdownMenuItem(
                  child: Text('Yes'),
                  value: '1',
                ),
                DropdownMenuItem(
                  child: Text('No'),
                  value: '0',
                ),
              ],
              onDropdownChanged: (String stringSelected) {
                // Save the selected value to a local variable
                _calendarEventModel.allDay =
                    stringSelected == '1' ? true : false;

                // Update the application's state
                setState(() {});
              },
              selected: _calendarEventModel.allDay ? '1' : '0',
            ),
          ],
        ),
      ),
    );

    return Column(
      children: listStartStopTime,
    );
  }

  /// Information regarding the title of the event
  Widget _eventTitleDescription() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Name',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.eventName,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.eventName = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _calendarEventModel.eventName,
                  stringError: "Please enter an event name",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'Description',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _calendarEventModel.eventDescription,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _calendarEventModel.eventDescription = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _calendarEventModel.eventDescription,
                  stringError: "Please enter a description",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        )
      ],
    );
  }

  // /// Used to divide content into sections
  // Widget _section(
  //     {@required String stringTitle,
  //     TitleStyle titleStyle = TitleStyle.Title1,
  //     List<Widget> listWidgets,
  //     }) {
  //   TextStyle _textStyleTitle;

  //   // Check to see which TextStyle was specified
  //   switch (titleStyle) {
  //     case TitleStyle.Title1:
  //       _textStyleTitle = TextStyles.title1();
  //       break;
  //     case TitleStyle.Title2:
  //       _textStyleTitle = TextStyles.title2();
  //       break;
  //     case TitleStyle.Title3:
  //       _textStyleTitle = TextStyles.title3();
  //       break;
  //     default:
  //       _textStyleTitle = TextStyles.title1();
  //       break;
  //   }

  //   return Container(
  //     child: stringTitle != null
  //         ? Column(
  //             children: <Widget>[
  //               Container(
  //                 child: Text(stringTitle, style: _textStyleTitle),
  //                 padding: EdgeInsets.only(
  //                   bottom: (listWidgets ?? []).length > 0
  //                       ? Dimensions.size16px
  //                       : 0,
  //                 ),
  //               ),
  //               Column(
  //                 children: listWidgets ?? [],
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //               ),
  //             ],
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //           )
  //         : Column(
  //             children: listWidgets ?? [],
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //           ),
  //     padding: EdgeInsets.only(
  //       bottom: Dimensions.size16px,
  //     ),
  //   );
  // }
}
