import 'dart:math';

import 'package:aae/events/page/aae_strings.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'caledar.dart';

class CalendarView extends StatefulWidget {
  static const String routeId = 'CalendarView';

  // Setup any required variables
  final Map arguments;

  // Initialize the view
  CalendarView({this.arguments});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  // Setup any required variables
  DateTime datePage = DateTime.now();
  DateTime dateSelected = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<DateTime> listDateEvents = [DateTime.now()];

  // TODO: Do we want to persist the currently paged month in a settings file somewhere and only reset it to default (the current month) on cold start?
  // TODO: Do we want to persist the current selected date in a settings file somewhere and only reset it to default (the current month) on cold start?

  @override
  Widget build(BuildContext context) {
    // Check to see if the array of fake events needs populated
    if (this.listDateEvents.length == 0) {
      // Populate the list of fake events
      this._populateListDateEvents();
    }

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            this._navigation(
              onNextTapAction: () {
                // Update the view's state
                setState(
                  () {
                    // Incriment the month
                    datePage = DateTime(
                      datePage.year,
                      datePage.month + 1,
                      datePage.day,
                    );
                  },
                );
              },
              onPreviousTapAction: () {
                // Update the view's state
                setState(
                  () {
                    // Deincriment the month
                    datePage = DateTime(
                      datePage.year,
                      datePage.month - 1,
                      datePage.day,
                    );
                  },
                );
              },
            ),
            Container(
              child: Calendar(
                datePage: datePage,
                dateSelected: dateSelected,
                onTapAction: (DateTime dateTime) {
                  // Update the view's state
                  setState(
                    () {
                      // Update the selected date
                      dateSelected = dateTime;
                    },
                  );
                },
                listDateEvents: listDateEvents,
              ),
              margin: EdgeInsets.only(
                bottom: AaeDimens.baseUnit * 3,
              ),
            ),
            this._selectedDate(),
            this._event(
              colorIcon: AaeColors.blue,
              dateTimeEnd: DateTime(
                      dateSelected.year, dateSelected.month, dateSelected.day)
                  .add(Duration(hours: 9)),
              dateTimeStart: DateTime(
                      dateSelected.year, dateSelected.month, dateSelected.day)
                  .add(Duration(hours: 8)),
              stringEventLocation: AaeStrings.lipsumLong,
              stringEventName: AaeStrings.lipsumLong,
            ),
            this._event(
              colorIcon: AaeColors.red,
              dateTimeEnd: DateTime(
                      dateSelected.year, dateSelected.month, dateSelected.day)
                  .add(Duration(hours: 14, minutes: 30)),
              dateTimeStart: DateTime(
                      dateSelected.year, dateSelected.month, dateSelected.day)
                  .add(Duration(hours: 13)),
              stringEventLocation: AaeStrings.lipsumLong,
              stringEventName: AaeStrings.lipsumLong,
            ),
          ],
        ),
        margin: EdgeInsets.only(
          left: AaeDimens.baseUnit * 3,
          right: AaeDimens.baseUnit * 3,
        ),
      ),
    );
  }

  /// A calendar event
  Widget _event(
      {@required Color colorIcon,
      @required DateTime dateTimeEnd,
      @required DateTime dateTimeStart,
      @required String stringEventName,
      @required String stringEventLocation}) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: colorIcon,
              shape: BoxShape.circle,
            ),
            height: AaeDimens.baseUnit,
            margin: EdgeInsets.only(
              right: AaeDimens.baseUnit * 3,
            ),
            width: AaeDimens.baseUnit * 3,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  DateFormat.jm().format(dateTimeStart),
                  style: AaeTextStyles.body(boolDefaultHeight: true),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  DateFormat.jm().format(dateTimeEnd),
                  style: AaeTextStyles.body(boolDefaultHeight: true),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            ),
            margin: EdgeInsets.only(
              right: AaeDimens.baseUnit,
            ),
          ),
          Flexible(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    stringEventName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AaeTextStyles.headline(boolDefaultHeight: true),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    stringEventLocation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AaeTextStyles.body(boolDefaultHeight: true),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      color: AaeColors.white,
      margin: EdgeInsets.only(
        bottom: AaeDimens.baseUnit,
      ),
      padding: EdgeInsets.all(
        AaeDimens.baseUnit,
      ),
      width: double.infinity,
    );
  }

  /// Navigation for the calendar
  Widget _navigation(
      {@required Function() onNextTapAction,
      @required Function() onPreviousTapAction}) {
    // Get the currently paged month
    DateTime dateBuilder = DateTime.parse(
        '${datePage.year}-${datePage.month.toString().padLeft(2, '0')}-01T00:00:00Z');

    // Check to see if the year should be displayed
    // - The year is only displayed when the paged date's year is not the same as the current date's year
    String stringMonthYear = dateBuilder.year == DateTime.now().year
        ? DateFormat.MMMM().format(dateBuilder)
        : DateFormat.yMMMM().format(dateBuilder);

    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              child: Icon(
                Icons.chevron_left,
                color: AaeColors.blue,
              ),
              height: AaeDimens.baseUnit3x,
              width: AaeDimens.baseUnit3x,
            ),
            onTap: () {
              // Execute the on-tap action
              onPreviousTapAction();
            },
          ),
          Text(
            stringMonthYear,
            style: AaeTextStyles.title(),
          ),
          InkWell(
            child: Container(
              child: Icon(
                Icons.chevron_right,
                color: AaeColors.blue,
              ),
              height: AaeDimens.baseUnit3x,
              width: AaeDimens.baseUnit3x,
            ),
            onTap: () {
              // Execute the on-tap action
              onNextTapAction();
            },
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      color: AaeColors.white,
      margin: EdgeInsets.only(
        left: 0,
        top: AaeDimens.baseUnit,
        right: 0,
        bottom: AaeDimens.baseUnit,
      ),
    );
  }

  /// Populates listDateEvents with fake / testing data
  void _populateListDateEvents() {
    // Reset the list of fake events
    listDateEvents.clear();

    // Generate a list of dates with random events
    for (int intDay = 1; intDay < 30; intDay++) {
      // Get a random bool
      bool boolDateHasEvent = Random().nextBool();

      // Check to see if a simulated event should be added
      if (boolDateHasEvent) {
        // Add an event to this date
        listDateEvents.add(
            DateTime.utc(DateTime.now().year, DateTime.now().month, intDay));
      }
    }
  }

  /// The currently selected date
  Widget _selectedDate() {
    String stringSelectedDate = dateSelected.year == DateTime.now().year
        ? DateFormat.MMMMEEEEd().format(dateSelected)
        : DateFormat.yMMMMEEEEd().format(dateSelected);

    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        stringSelectedDate,
        style: AaeTextStyles.description(),
      ),
      color: AaeColors.white,
      margin: EdgeInsets.only(
        bottom: AaeDimens.baseUnit,
      ),
      padding: EdgeInsets.all(
        AaeDimens.baseUnit,
      ),
      width: double.infinity,
    );
  }
}
