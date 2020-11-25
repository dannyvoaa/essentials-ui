import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';

class DatePickerComponent extends StatelessWidget {
  DatePickerComponent({this.searchFormData, this.calendarLength});

  var searchFormData;
  var calendarLength;

  @override
  Widget build(BuildContext context) {
    return DatePickerPage(
        searchFormData: this.searchFormData, calendarLength: calendarLength);
  }
}

class DatePickerPage extends StatefulWidget {
  DatePickerPage({Key key, this.searchFormData, this.calendarLength})
      : super(key: key);
  var searchFormData;
  var calendarLength;

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DatePickerController _controller = DatePickerController();

  @override
  void initState() {
    super.initState();
    setSelectedDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 30, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Date",
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.left,
            ),
            Expanded(
                child: DatePicker(
              DateTime.now().add(Duration(
                  days: calculateCalendarCenter(widget.calendarLength))),
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Color(0xffebeff0),
              selectedTextColor: AaeColors.titleGray,
              monthTextStyle: AaeTextStyles.datePickerText,
              dateTextStyle: AaeTextStyles.datePickerDate,
              dayTextStyle: AaeTextStyles.datePickerText,
              daysCount: widget.calendarLength,
              onDateChange: (date) {
                setState(() {
                  setSelectedDate(date);
                });
              },
            )),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }

  void setSelectedDate(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    widget.searchFormData.searchDate = formattedDate;
  }

  int calculateCalendarCenter(int calendarLength) {
    if ((calendarLength / 2).round() == 1) {
      return 0;
    } else if ((calendarLength / 2).round() == 2) {
      return -1;
    } else {
      return -2;
    }
  }
}
