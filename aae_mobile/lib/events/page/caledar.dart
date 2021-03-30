import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

class Calendar extends StatefulWidget {
  // Setup any required variables
  final DateTime datePage;
  final DateTime dateSelected;
  final Function(DateTime) onTapAction;
  final List<DateTime> listDateEvents;

  // Initialize the widget
  Calendar({
    @required this.datePage,
    @required this.dateSelected,
    this.onTapAction,
    this.listDateEvents,
  });

  @override
  _CalendarState createState() => _CalendarState();
  // Somewhere in your widgets...
 // FirebaseAnalytics().setCurrentScreen(AAECalscreenName: 'AAECalendar');
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    // Setup any needed variables
    List<DateTime> listDays = List<DateTime>();
    List<Widget> listRows = List<Widget>();

    // Get the currently paged month
    DateTime dateBuilder = DateTime.parse(
        '${this.widget.datePage.year}-${this.widget.datePage.month.toString().padLeft(2, '0')}-01T00:00:00Z');

    // Loop through every day in the month
    while (dateBuilder.year == this.widget.datePage.year &&
        dateBuilder.month == this.widget.datePage.month) {
      // Check to see if listDays is empty and if the current day of the week is  t Sunday
      if (listDays.length == 0 && dateBuilder.weekday < 7) {
        // Loop through each day prior to the dateBuilder.weekday
        for (int i = 0; i < dateBuilder.weekday; i++) {
          // Add an empty day entry
          listDays.add(null);
        }
      }

      // Add the date to listDays
      listDays.add(dateBuilder);

      // Incriment the date
      dateBuilder = dateBuilder.add(
        Duration(
          days: 1,
        ),
      );

      // Check to see if we should add a new row
      if (dateBuilder.weekday == 7 ||
          dateBuilder.year != this.widget.datePage.year ||
          dateBuilder.month != this.widget.datePage.month) {
        // Look through each remaining day entry
        while (listDays.length < 7) {
          // Add an empty day entry
          listDays.add(null);
        }

        // Create the calendar row
        listRows.add(
          // Populate the row
          this._row(
            dateDay1: listDays[0],
            dateDay2: listDays[1],
            dateDay3: listDays[2],
            dateDay4: listDays[3],
            dateDay5: listDays[4],
            dateDay6: listDays[5],
            dateDay7: listDays[6],
          ),
        );

        // Reset listDays
        listDays.clear();
      }
    }

    return Column(
      children: <Widget>[
        this._header(),
        Column(
          children: listRows,
        ),
      ],
    );
  }

  /// A single date cell
  Widget _day({bool boolSelected = false, @required DateTime date}) {
    return Expanded(
      child: InkWell(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    date != null ? date.day.toString() : '',
                    style: AaeTextStyles.body16,
                  ),
                  Expanded(
                    child: this.widget.listDateEvents.contains(date)
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: !boolSelected
                                    ? AaeColors.blue
                                    : AaeColors.white100,
                                shape: BoxShape.circle,
                              ),
                              height: 5,
                              width: 5,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: !boolSelected ? null : AaeColors.darkGray,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.only(top: 2.5),
              margin: EdgeInsets.all(4),
            ),
          ],
        ),
        onTap: () {
          // Check to see if an on-tap action was provided
          if (date != null && this.widget.onTapAction != null) {
            // Execute the on-tap action
            this.widget.onTapAction(date);
          }
        },
      ),
    );
  }

  /// The calendar's header row (includes day names)
  Widget _header() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('S'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('M'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('T'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('W'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('T'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('F'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('S'),
                    height: double.infinity,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            height: AaeDimens.baseUnit * 3,
          ),
        ],
      ),
    );
  }

  /// A calendar row comprised of seven date cells
  Widget _row({
    DateTime dateDay1,
    DateTime dateDay2,
    DateTime dateDay3,
    DateTime dateDay4,
    DateTime dateDay5,
    DateTime dateDay6,
    DateTime dateDay7,
  }) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                this._day(
                  date: dateDay1,
                  boolSelected: widget.dateSelected != null &&
                      widget.dateSelected == dateDay1,
                ),
                this._day(
                  date: dateDay2,
                  boolSelected: widget.dateSelected != null &&
                      widget.dateSelected == dateDay2,
                ),
                this._day(
                  date: dateDay3,
                  boolSelected: widget.dateSelected != null &&
                      widget.dateSelected == dateDay3,
                ),
                this._day(
                  date: dateDay4,
                  boolSelected: widget.dateSelected != null &&
                      widget.dateSelected == dateDay4,
                ),
                this._day(
                  date: dateDay5,
                  boolSelected: widget.dateSelected != null &&
                      widget.dateSelected == dateDay5,
                ),
                this._day(
                  date: dateDay6,
                  boolSelected: widget.dateSelected != null &&
                      widget.dateSelected == dateDay6,
                ),
                this._day(
                  date: dateDay7,
                  boolSelected: widget.dateSelected != null &&
                      widget.dateSelected == dateDay7,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            height: AaeDimens.baseUnit * 3,
          ),
        ],
      ),
    );
  }
}
