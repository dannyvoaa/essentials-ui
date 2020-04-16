import 'package:american_essentials_web_admin/api/api_calendar_events_delete.dart';
import 'package:american_essentials_web_admin/api/api_calendar_events_fetch.dart';
import 'package:american_essentials_web_admin/common/alerts.dart';
import 'package:american_essentials_web_admin/common/api_helper.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/models/calendar_event_model.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/views/calendar/calendar_add_view.dart';
import 'package:american_essentials_web_admin/views/calendar/calendar_filters_view.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/cells/calendar_event_cell.dart';
import 'package:american_essentials_web_admin/widgets/cells/error_cell.dart';
import 'package:american_essentials_web_admin/widgets/cells/header_cell.dart';
import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:american_essentials_web_admin/widgets/processing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class CalendarView extends StatefulWidget {
  static String routeId = 'CalendarView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  CalendarView({this.payload});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  // Setup any required variables
  List<CalendarEventModel> _listCalendarEvents = List<CalendarEventModel>();
  LocalStorage _localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();

    // Initialize local storage
    _localStorage.initialize().then((value) {
      // Reload the data source
      this._reloadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      boolBodyBottomPadding: false,
      boolBodyTopPadding: false,
      stringHeaderTitle: 'Calendar',
      widgetBody: this._body(),
      widgetHeaderActions: Row(
        children: <Widget>[
          RoundedButton(
            child: Text('Filters'),
            onPressed: () {
              // Show the Calendar Filters view
              showDialog(
                context: context,
                child: CalendarFiltersView(
                  onApplyAction: () {
                    // Reload the data source
                    this._reloadData();
                  },
                ),
              );
            },
          ),
          SizedBox(
            width: Dimensions.size16px,
          ),
          Container(
            color: CustomColors.separator,
            height: double.infinity,
            width: Dimensions.sizeDivider,
          ),
          SizedBox(
            width: Dimensions.size16px,
          ),
          RoundedButton(
            child: Text('Create Event'),
            onPressed: () {
              // Push to a new view with the fade animation
              Transitions.pushReplacementWithFade(
                buildContext: context,
                stringRouteId: CalendarAddView.routeId,
              );
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  // MARK: - Data

  /// Reload the data source
  Future<void> _reloadData() async {
    // Delay execution
    Future.microtask(() async {
      // Show the Processing view
      Processing.showProcessingView(buildContext: context, animated: false);

      // Delay execution to allow the Processing view to animate in
      Future.delayed(Duration(milliseconds: 250), () async {
        // Reset the list of calendar events
        _listCalendarEvents.clear();

        // Request data from the API
        ApiCalendarEventsFetchResult apiCalendarEventsFetchResult =
            await ApiCalendarEventsFetch.sendRequest(
            );

        // Execute the API Helper
        ApiHelper.execute(
          buildContext: context,
          boolDismissProcessingOnError: true,
          httpStatusCode: apiCalendarEventsFetchResult.statusCode,
          onSuccess: () {
            // Populate the list with event data from the API
            _listCalendarEvents = apiCalendarEventsFetchResult.data;

            // Update the application's state
            setState(() {});

            // Check to see if this view is currently at the top of the stack
            if (!ModalRoute.of(context).isCurrent) {
              // Hide the processing view
              Processing.dismiss(buildContext: context);
            }
          },
        );
      });
    });
  }

  /// Reload the list view
  List<Widget> _reloadListView() {
    // Setup any required variables
    DateTime _dateTimeSection = DateTime.utc(1900, 01, 01);
    List<Widget> listWidgets = List<Widget>();

    // Check to see if _listCalendarEvents has data
    if (_listCalendarEvents.length > 0) {
      // Iterate through each CalendarEventModel in the list
      for (CalendarEventModel calendarEventModel in _listCalendarEvents) {
        // Add the UTC offset
        DateTime dateTimeRow = calendarEventModel.dateTimeStart
            .add(Duration(minutes: calendarEventModel.timeZoneOffset));

        // Check to see if we need to add a new section header
        if (DateTime(_dateTimeSection.year, _dateTimeSection.month,
                    _dateTimeSection.day)
                .compareTo(DateTime(
                    dateTimeRow.year, dateTimeRow.month, dateTimeRow.day)) !=
            0) {
          // Add an item to the list of widgets
          listWidgets.add(
            // Add a new header
            HeaderCell(
              stringTitle: DateTime.now().year == dateTimeRow.year
                  ? DateFormat.MMMMEEEEd().format(dateTimeRow)
                  : DateFormat.yMMMMEEEEd().format(dateTimeRow),
            ),
          );

          // Update the date for this section
          _dateTimeSection = dateTimeRow;
        }

        // Add an item to the list of widgets
        listWidgets.add(
          // Add a new calendar event cell
          CalendarEventCell(
            stringId: calendarEventModel.id,
            stringEventName: calendarEventModel.eventName,
            boolAllDay: calendarEventModel.allDay,
            dateTimeStart: calendarEventModel.dateTimeStart
                .add(Duration(minutes: calendarEventModel.timeZoneOffset)),
            dateTimeEnd: calendarEventModel.dateTimeEnd
                .add(Duration(minutes: calendarEventModel.timeZoneOffset)),
            intUtcOffset: calendarEventModel.timeZoneOffset,
            stringContactInfoName: calendarEventModel.contactName,
            stringLocationVenue: calendarEventModel.locationVenue,
            stringLocationRoomNumber: calendarEventModel.locationRoomNumber,
            onDeleteAction: () {
              // Confirm that the user would like to delete this event
              this._deleteAction(
                buildContext: context,
                calendarEventModel: calendarEventModel,
              );
            },
            onEditAction: () {
              // Push to the add/edit view
              this._editAction(
                buildContext: context,
                calendarEventModel: calendarEventModel,
              );
            },
          ),
        );
      }
    } else {
      // Add an item to the list of widgets
      listWidgets.add(
        ErrorCell(
          stringMessage:
              'No calendar events were found or the network connection is unavailable.',
        ),
      );
    }

    return listWidgets;
  }

  // MARK: - Widgets

  Widget _body() {
    return Column(
      children: <Widget>[
        Container(
          child: ListView(
            children: _reloadListView(),
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            primary: false,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: CustomColors.separator,
                width: Dimensions.sizeDivider,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Action to be executed when the user taps the delete button
  void _deleteAction({
    @required BuildContext buildContext,
    @required CalendarEventModel calendarEventModel,
  }) async {
    // Alert: Bad username or password
    var dialogResult = await Alerts.delete(
      buildContext: buildContext,
      stringObject: 'event',
    );

    // Check to see what action was selected
    if (dialogResult.toString().toLowerCase() == 'delete') {
      // Show the Processing view
      Processing.showProcessingView(buildContext: context);

      // Attempt to delete the calendar event
      ApiCalendarEventsDeleteResult apiCalendarEventsDeleteResult =
          await ApiCalendarEventsDelete.sendRequest(
        calendarEventModel: calendarEventModel,
      );

      // Execute the API Helper
      ApiHelper.execute(
        buildContext: context,
        boolDismissProcessingOnError: true,
        httpStatusCode: apiCalendarEventsDeleteResult.statusCode,
        onSuccess: () {
          // Hide the processing view
          Processing.dismiss(buildContext: context);

          // Reload the data source
          this._reloadData();
        },
      );
    }
  }

  /// Action to be executed when the user taps the edit button
  void _editAction(
      {@required BuildContext buildContext,
      @required CalendarEventModel calendarEventModel}) async {
    // Push to a new view with the fade animation
    Transitions.pushReplacementWithFade(
      buildContext: context,
      stringRouteId: CalendarAddView.routeId,
      payload: {'calendarEventModel': calendarEventModel},
    );
  }
}
