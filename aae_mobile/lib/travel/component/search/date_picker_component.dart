import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DatePickerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Date Picker Timeline Demo');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: DatePicker(
              DateTime.now().add(Duration(days: -1)),
              width: 60,
              height: 80,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              daysCount: 3,
              onDateChange: (date) {
                setState(() {
                  _selectedValue = date;
                });
              },
            ),
          ),
          Text(_selectedValue.toString()),
        ],
      ),
    );
  }
}
