import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DatePickerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DatePickerPage();
  }
}
class _SearchFormData {
  String searchField1;
  String searchField2;
  DateTime searchDate;
}

class DatePickerPage extends StatefulWidget {
  DatePickerPage({Key key, this.searchFormData}) : super(key: key);
  final _SearchFormData searchFormData;

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Date",
              textAlign: TextAlign.left,
            ),
            Expanded(
                child: DatePicker(
                  DateTime.now().add(Duration(days: -1)),
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Color(0xffebeff0),
                  selectedTextColor: AaeColors.black,
                  monthTextStyle: TextStyle(
                    fontFamily: 'AmericanSans',
                    fontSize: 13,
                    color: AaeColors.lightGray,
                  ),
                  dateTextStyle: TextStyle(
                    fontFamily: 'AmericanSans Medium',
                    fontSize: 26,
                    color: AaeColors.black,
                  ),
                  dayTextStyle: TextStyle(
                    fontFamily: 'AmericanSans',
                    fontSize: 13,
                    color: AaeColors.lightGray,
                  ),
                  daysCount: 3,
                  onDateChange: (date) {
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                )),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
}
