import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/controls/drop_down_menu.dart';
import 'package:american_essentials_web_admin/widgets/general/form_row.dart';
import 'package:flutter/material.dart';

enum _EventFilterMode {
  From,
  To,
}

class CalendarFiltersView extends StatefulWidget {
  @override
  _CalendarFiltersViewState createState() => _CalendarFiltersViewState();

  // Setup any required variables
  final Function() onApplyAction;

  // Initialize the widget
  CalendarFiltersView({@required this.onApplyAction});
}

class _CalendarFiltersViewState extends State<CalendarFiltersView> {
  // Setup any required variables
  DateTime _dateTimeFrom = DateTime.now();
  DateTime _dateTimeTo = DateTime.now();
  LocalStorage _localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();

    // Initialize local storage
    _localStorage.initialize().then((value) {
      // Retreive the selected filters from local storage
      _dateTimeFrom = DateTime.parse(_localStorage.sharedPreferences
          .getString('calendar.filters.dateFrom'));
      _dateTimeTo = DateTime.parse(
          _localStorage.sharedPreferences.getString('calendar.filters.dateTo'));

      // Update the application's state
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                'Filters',
                style: TextStyles.title1(),
              ),
              SizedBox(
                height: Dimensions.size16px,
              ),
              FormFieldRow(
                boolRightAlign: true,
                stringTitle: 'From',
                widget: Row(
                  children: <Widget>[
                    this._dropDownButtonMonth(
                      dateTimeSelected: this._dateTimeFrom,
                      eventFilterMode: _EventFilterMode.From,
                    ),
                    SizedBox(
                      width: Dimensions.size16px,
                    ),
                    this._dropDownButtonDay(
                      dateTimeSelected: this._dateTimeFrom,
                      eventFilterMode: _EventFilterMode.From,
                    ),
                    SizedBox(
                      width: Dimensions.size16px,
                    ),
                    this._dropDownButtonYear(
                      dateTimeSelected: this._dateTimeFrom,
                      eventFilterMode: _EventFilterMode.From,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
              FormFieldRow(
                boolRightAlign: true,
                doubleBottomHeight: Dimensions.size32px,
                stringTitle: 'To',
                widget: Row(
                  children: <Widget>[
                    this._dropDownButtonMonth(
                      dateTimeSelected: this._dateTimeTo,
                      eventFilterMode: _EventFilterMode.To,
                    ),
                    SizedBox(
                      width: Dimensions.size16px,
                    ),
                    this._dropDownButtonDay(
                      dateTimeSelected: this._dateTimeTo,
                      eventFilterMode: _EventFilterMode.To,
                    ),
                    SizedBox(
                      width: Dimensions.size16px,
                    ),
                    this._dropDownButtonYear(
                      dateTimeSelected: this._dateTimeTo,
                      eventFilterMode: _EventFilterMode.To,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
              Row(
                children: <Widget>[
                  RoundedButton(
                    child: Text('Reset'),
                    color: BrandColors.red,
                    onPressed: () {
                      // Reset the calendar filters to their defaults
                      // - A similar function exists in startup.dart:24
                      _dateTimeFrom = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                      ).toUtc();
                      _dateTimeTo = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                      ).toUtc().add(Duration(days: 7));

                      // Update the application's state
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  RoundedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      // Pop the view
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: Dimensions.size16px,
                  ),
                  RoundedButton(
                    child: Text('Apply'),
                    enabled: _dateTimeFrom.compareTo(_dateTimeTo) <= 0,
                    onPressed: () {
                      // Set the initial calendar filters
                      _localStorage.sharedPreferences.setString(
                          'calendar.filters.dateFrom',
                          _dateTimeFrom.toIso8601String());
                      _localStorage.sharedPreferences.setString(
                          'calendar.filters.dateTo',
                          _dateTimeTo.toIso8601String());

                      // Execute the apply action
                      widget.onApplyAction();

                      // Pop the view
                      Navigator.pop(context);
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          constraints: BoxConstraints(
            maxHeight: Dimensions.size512px,
            maxWidth: Dimensions.size512px,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.size8px,
            ),
            color: BrandColors.white,
          ),
          padding: EdgeInsets.all(
            Dimensions.size16px,
          ),
        ),
      ),
      color: CustomColors.transparent,
    );
  }

  /// A drop down button widget that handles day selection
  Widget _dropDownButtonDay({
    @required DateTime dateTimeSelected,
    @required _EventFilterMode eventFilterMode,
  }) {
    List<DropdownMenuItem> listDowndownMenuItems = List<DropdownMenuItem>();

    // Retreive the number of days in the selected month/year combination
    int _intNumberOfDaysInMonth = DateUtilities.daysInMonth(
      intYear: dateTimeSelected.year,
      intMonth: dateTimeSelected.month,
    );

    // Iterate through each day in the given month
    for (int i = 1; i <= _intNumberOfDaysInMonth; i++) {
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
        // Check to see if the user has updated the 'from' or 'to' date
        if (eventFilterMode == _EventFilterMode.From) {
          // Save the selected value to a local variable
          _dateTimeFrom = DateTime.utc(
            dateTimeSelected.year,
            dateTimeSelected.month,
            int.parse(stringSelected),
            00,
            00,
          ).toUtc();
        } else {
          _dateTimeTo = DateTime.utc(
            dateTimeSelected.year,
            dateTimeSelected.month,
            int.parse(stringSelected),
            23,
            50,
          ).toUtc();
        }

        // Update the application's state
        setState(() {});
      },
      selected: dateTimeSelected.day.toString(),
    );
  }

  /// A drop down button widget that handles month selection
  Widget _dropDownButtonMonth({
    @required DateTime dateTimeSelected,
    @required _EventFilterMode eventFilterMode,
  }) {
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
        // Check to see if the user has updated the 'from' or 'to' date
        if (eventFilterMode == _EventFilterMode.From) {
          // Save the selected value to a local variable
          _dateTimeFrom = DateTime(
            dateTimeSelected.year,
            int.parse(stringSelected),
            dateTimeSelected.day,
            00,
            00,
          ).toUtc();
        } else {
          _dateTimeTo = DateTime(
            dateTimeSelected.year,
            int.parse(stringSelected),
            dateTimeSelected.day,
            00,
            00,
          ).toUtc();
        }

        // Update the application's state
        setState(() {});
      },
      selected: dateTimeSelected.month.toString(),
    );
  }

  /// A drop down button widget that handles year selection
  Widget _dropDownButtonYear({
    @required DateTime dateTimeSelected,
    @required _EventFilterMode eventFilterMode,
  }) {
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
        // Check to see if the user has updated the 'from' or 'to' date
        if (eventFilterMode == _EventFilterMode.From) {
          // Save the selected value to a local variable
          _dateTimeFrom = DateTime(
            int.parse(stringSelected),
            dateTimeSelected.month,
            dateTimeSelected.day,
            00,
            00,
          ).toUtc();
        } else {
          _dateTimeTo = DateTime(
            int.parse(stringSelected),
            dateTimeSelected.month,
            dateTimeSelected.day,
            00,
            00,
          ).toUtc();
        }

        // Update the application's state
        setState(() {});
      },
      selected: dateTimeSelected.year.toString(),
    );
  }
}