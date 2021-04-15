import 'package:aae/events/component/calendar/calendar_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A view that shows a calendar on the events page.
class CalendarView extends StatefulWidget {
  final CalendarViewModel viewModel;
  final CalendarDayViewModel dayViewModel;
  CalendarView({this.viewModel, this.dayViewModel});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  String stringMonthYear;

  @override
  void initState(){
    widget.viewModel.onDaySelected(DateTime.now().day);
    super.initState();
  }

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

  Color formatDayWeek(index) {
    var now = DateTime.now();
    var today = now.weekday;
    var thisMonth = now.month;

    var color = today == index && thisMonth == widget.viewModel.datePage.month
        ? AaeColors.lightBlue
        : AaeColors.cadetGray;

    return color;
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
                    child: Text(
                      'Sun',
                      style: TextStyle(
                        color: formatDayWeek(7),
                      ),
                    ),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Mon',
                      style: TextStyle(
                        color: formatDayWeek(1),
                      ),
                    ),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Tue',
                      style: TextStyle(
                        color: formatDayWeek(2),
                      ),
                    ),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Wed',
                      style: TextStyle(
                        color: formatDayWeek(3),
                      ),
                    ),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Thu',
                      style: TextStyle(
                        color: formatDayWeek(4),
                      ),
                    ),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Fri',
                      style: TextStyle(
                        color: formatDayWeek(5),
                      ),
                    ),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Sat',
                      style: TextStyle(
                        color: formatDayWeek(6),
                      ),
                    ),
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

      var result = day < today &&
              thisMonth == widget.viewModel.datePage.month &&
              thisYear == widget.viewModel.datePage.year
          ? AaeTextStyles.body16Gray
          : day == widget.viewModel.selectedDate
              ? AaeTextStyles.body16WhiteMed
              : AaeTextStyles.body16;
      return result;
    }

    bool formatTap(x) {
      int day = int.tryParse(x) ?? 0;
      var now = DateTime.now();
      var today = now.day;
      var thisMonth = now.month;
      var thisYear = now.year;

      var result = day < today &&
              thisMonth == widget.viewModel.datePage.month &&
              thisYear == widget.viewModel.datePage.year
          ? false
          : day == widget.viewModel.selectedDate ? false : true;
      return result;
    }

    Color formatColor(x) {
      int day = int.tryParse(x) ?? 0;
      var now = DateTime.now();
      var today = now.day;
      var thisMonth = now.month;
      var thisYear = now.year;

      var result = widget.viewModel.daysWithEvents.contains(int?.parse(x)) &&
              thisMonth < widget.viewModel.datePage.month &&
              day != widget.viewModel.selectedDate
          ? AaeColors.blue
          : widget.viewModel.daysWithEvents.contains(int?.parse(x)) &&
                  day != widget.viewModel.selectedDate &&
                  day >= today
              ? AaeColors.blue
              : null;

      return result;
    }

    Color formatHighlight(x) {
      int day = int.tryParse(x);
      var now = DateTime.now();
      var today = now.day;
      var thisMonth = now.month;
      var thisYear = now.year;

      var result =
          day == widget.viewModel.selectedDate && thisMonth != widget.viewModel.datePage.month
              ? AaeColors.cadetGray
              : day == widget.viewModel.selectedDate &&
                      today != widget.viewModel.selectedDate &&
                      thisMonth == widget.viewModel.datePage.month
                  ? AaeColors.cadetGray
                  : day == widget.viewModel.selectedDate &&
                          today == widget.viewModel.selectedDate &&
                          thisMonth == widget.viewModel.datePage.month &&
                          thisYear == widget.viewModel.datePage.year
                      ? AaeColors.lightBlue
                      : day == widget.viewModel.selectedDate &&
                              thisYear != widget.viewModel.datePage.year
                          ? AaeColors.cadetGray
                          : null;

      return result;
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
          widget.viewModel.numOfDaysInCurrentMonth + widget.viewModel.firstWeekdayInMonth,
          (index) {
        // Set the string value for the current day in the month
        String stringDay = index < widget.viewModel.firstWeekdayInMonth
            ? ''
            : '${(index + 1) - widget.viewModel.firstWeekdayInMonth}';

        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
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
                      child: widget.viewModel.daysWithEvents
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
                  color: formatHighlight(stringDay),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.only(top: 2.5),
                margin: EdgeInsets.all(6),
              ),
            ],
          ),
          onTap: formatTap(stringDay)
              ? () {
                  widget.viewModel.onDaySelected(
                      (index + 1) - widget.viewModel.firstWeekdayInMonth);
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
        '${widget.viewModel.datePage.year}-${widget.viewModel.datePage.month.toString().padLeft(2, '0')}-01T00:00:00Z');

    // Check to see if the year should be displayed
    // - The year is only displayed when the paged date's year is not the same as the current date's year
    stringMonthYear = dateBuilder.year == DateTime.now().year
        ? DateFormat.MMMM().format(dateBuilder)
        : DateFormat.yMMMM().format(dateBuilder);

    bool thisMonth() {
      var selectedMonth = widget.viewModel.datePage.month;
      var now = DateTime.now();
      var thisMonth = now.month;
      var result = selectedMonth == thisMonth ? true : false;
      return result;
    }

    bool formatMonthTap() {
//      int day = int.tryParse(x) ?? 0;
      var now = DateTime.now();
      var thisMonth = now.month;
      var thisYear = now.year;
      var selectedMonth = widget.viewModel.datePage.month;
      var selectedYear = widget.viewModel.datePage.year;
      var today = now.day;

      var result =
          thisMonth == widget.viewModel.datePage.month && thisYear == selectedYear
              ? false
              : thisMonth > widget.viewModel.datePage.month ? true : true;
      return result;
    }

    void backMonth() {
      var now = DateTime.now();
      var thisMonth = now.month;
      var displayedMonth = widget.viewModel.datePage.month;
      var selectedMonth = widget.viewModel.datePage.month - 1;
      int today = now.day;
      int index = today;

      widget.viewModel.onPreviousMonthPressed();
//      print("Testing............................................");
//      print(selectedMonth);
//      print(today);

      selectedMonth == thisMonth
          ? widget.viewModel.onDaySelected(today)
          : selectedMonth != thisMonth
              ? widget.viewModel.onDaySelected(1)
              : widget.viewModel.onDaySelected(1);

//      viewModel.onDaySelected((index + 1) - viewModel.firstWeekdayInMonth);
    }

    void forwardMonth() {
      widget.viewModel.onNextMonthPressed();
      widget.viewModel.onDaySelected(1);
    }

    return Padding(
      padding: EdgeInsets.only(left: 6.0, right: 6.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AaeColors.lightGray,
//              color: AaeColors.lightGray,
              offset: Offset(0.2, 2),
              blurRadius: 2,
              spreadRadius: 1.2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Container(
            color: AaeColors.white100,
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    child: Icon(
                      Icons.chevron_left,
                      color: formatMonthTap()
                          ? AaeColors.blue
                          : AaeColors.gray,
                    ),
                    height: AaeDimens.sizeDynamic_48px(),
                    width: AaeDimens.sizeDynamic_48px(),
                  ),
                  onTap: formatMonthTap() ? backMonth : () {},
                ),
                Text(
                  stringMonthYear,
                  style: AaeTextStyles.title20,
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
                  onTap: forwardMonth,
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
