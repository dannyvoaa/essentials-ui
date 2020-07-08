import 'package:aae/events/component/calendar/calendar_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A view that shows a calendar on the events page.
class CalendarView extends StatelessWidget {
  final CalendarViewModel viewModel;

  CalendarView({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildNavigation(context),
        _buildHeader(context),
        _buildCalendarGrid(context),
      ],
    );
  }

  /// The calendar's header row (includes day names)
  _buildHeader(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Sun'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Mon'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Tue'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Wed'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Thu'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Fri'),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Sat'),
                    height: double.infinity,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            height: AaeDimens.sizeDynamic_48px(),
          ),
        ],
      ),
    );
  }

  /// A single date cell
  Widget _buildCalendarGrid(BuildContext context) {
    TextStyle formatDay(x) {
      int day = int.tryParse(x) ?? 0;
      var now = DateTime.now();
      var today = now.day;
      var thisMonth = now.month;
      var thisYear = now.year;

      var result = day < today && thisMonth == viewModel.datePage.month
          ? AaeTextStyles.calendarOld(boolDefaultHeight: true)
          : thisMonth > viewModel.datePage.month ||
                  thisYear > viewModel.datePage.year
              ? AaeTextStyles.calendarOld(boolDefaultHeight: true)
              : thisYear < viewModel.datePage.year
                  ? AaeTextStyles.calendarMain(boolDefaultHeight: true)
                  : day == viewModel.selectedDate
                      ? TextStyle(color: AaeColors.white)
                      : AaeTextStyles.calendarMain(boolDefaultHeight: true);
      return result;
    }

    Color formatColor(x) {
      int day = int.tryParse(x) ?? 0;
      var now = DateTime.now();
      var today = now.day;
      var thisMonth = now.month;
      var thisYear = now.year;

      var result = viewModel.daysWithEvents.contains(int?.parse(x)) &&
              day >= today &&
              thisMonth <= viewModel.datePage.month
          ? AaeColors.blue
          : viewModel.daysWithEvents.contains(int?.parse(x)) &&
                  thisMonth < viewModel.datePage.month
              ? AaeColors.blue
              : thisMonth >= viewModel.datePage.month
                  ? null
                  : viewModel.daysWithEvents.contains(int?.parse(x)) &&
                          day == viewModel.selectedDate
                      ? null
                      : null;

      return result;
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      children: List.generate(
          viewModel.numOfDaysInCurrentMonth + viewModel.firstWeekdayInMonth,
          (index) {
        // Set the string value for the current day in the month
        String stringDay = index < viewModel.firstWeekdayInMonth
            ? ''
            : '${(index + 1) - viewModel.firstWeekdayInMonth}';

        return InkWell(
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    Text(stringDay, style: formatDay(stringDay)),
                    Expanded(
                      child: viewModel.daysWithEvents
                              .contains(int?.tryParse(stringDay))
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: formatColor(stringDay),
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
                  color: int.tryParse(stringDay) == viewModel.selectedDate
                      ? AaeColors.darkGray
                      : null,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.only(top: 2.5),
                margin: EdgeInsets.all(6),
              ),
            ],
          ),
          onTap: stringDay != ''
              ? () {
                  viewModel.onDaySelected(
                      (index + 1) - viewModel.firstWeekdayInMonth);
                }
              : null,
        );
      }),
    );
  }

  /// Navigation for the calendar
  Widget _buildNavigation(BuildContext context) {
    // Get the currently paged month
    DateTime dateBuilder = DateTime.parse(
        '${viewModel.datePage.year}-${viewModel.datePage.month.toString().padLeft(2, '0')}-01T00:00:00Z');

    // Check to see if the year should be displayed
    // - The year is only displayed when the paged date's year is not the same as the current date's year
    String stringMonthYear = dateBuilder.year == DateTime.now().year
        ? DateFormat.MMMM().format(dateBuilder)
        : DateFormat.yMMMM().format(dateBuilder);

    return Padding(
      padding: EdgeInsets.only(left:6.0, right:6.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
//              color: AaeColors.lightGray,
              offset: Offset(0.2, 2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Container(
            color: AaeColors.white,
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    child: Icon(
                      Icons.chevron_left,
                      color: AaeColors.blue,
                    ),
                    height: AaeDimens.sizeDynamic_48px(),
                    width: AaeDimens.sizeDynamic_48px(),
                  ),
                  onTap: viewModel.onPreviousMonthPressed,
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
                    height: AaeDimens.sizeDynamic_48px(),
                    width: AaeDimens.sizeDynamic_48px(),
                  ),
                  onTap: viewModel.onNextMonthPressed,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
//      color: AaeColors.red,
        margin: EdgeInsets.only(
          left: 0,
          top: AaeDimens.sizeDynamic_16px(),
          right: 0,
          bottom: AaeDimens.sizeDynamic_16px(),
        ),
      ),
    );
  }
}
