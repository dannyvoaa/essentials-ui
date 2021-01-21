import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/airport_picker/airport_picker_form_field.dart';
import 'package:aae/travel/component/flight_status/details/flight_status_component.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:aae/travel/page/travel_page.dart';
import 'package:flutter/material.dart';
import 'date_picker_component.dart';

class SearchFormData {
  String searchField1;
  String searchField2;
  String searchDate;
}

enum SearchFormFieldType { text, number, airport }

class SearchForm extends StatefulWidget {
  SearchForm({
    this.searchField1,
    this.searchHint1,
    this.searchFieldType1,
    this.searchField1Validation,
    this.searchField1ValidationLength,
    this.searchField2,
    this.searchHint2,
    this.searchFieldType2,
    this.searchField2Validation,
    this.searchField2ValidationLength,
    this.searchDate,
    this.searchType,
    this.calendarLength,
  });

  final String searchField1;
  final String searchHint1;
  final SearchFormFieldType searchFieldType1;
  final String searchField1Validation;
  final int searchField1ValidationLength;
  final String searchField2;
  final String searchHint2;
  final SearchFormFieldType searchFieldType2;
  final String searchField2Validation;
  final int searchField2ValidationLength;
  final String searchDate;
  final int calendarLength;
  final Function(BuildContext, String, String, String) searchType;

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SearchFormData _data = new SearchFormData();
  bool isEnabled = false;

  final InputDecoration textFieldDecoration = InputDecoration(
    hintStyle: AaeTextStyles.subtitle15Gray,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AaeColors.blue),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(208, 218, 224, 1.0)),
    ),
  );

  enableButton(SearchFormData data) {
    if (data.searchField1 != null && data.searchField2 != null &&
        data.searchField1.isNotEmpty && data.searchField2.isNotEmpty) {

      setState(() {
        isEnabled = true;
      });
    } else {
      setState(() {
        isEnabled = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSearchForm(context);
  }

  void submit(
      BuildContext context,
      Function(BuildContext context, String searchField1, String searchField2,
              String searchDate)
          searchType) {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      searchType(context, this._data.searchField1, this._data.searchField2,
          this._data.searchDate);
    }
  }

  _buildSearchForm(BuildContext context) {
    bool flightNumberEntered = false;
    bool fromEntered = false;

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Wrap(
          children: <Widget>[
            _buildFormTitle(),
            _buildFormFields(),
            _buildFormDatePicker(),
            _buildLargeButton(),
          ],
        ),
      ),
    );
  }

  _buildFormTitle() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            widget.searchField1,
            style: TextStyle(fontSize: 15),
          ),
        )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Text(widget.searchField2, style: TextStyle(fontSize: 15)),
          ),
        )
      ],
    );
  }

  _buildFormFields() {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
          height: 35,
          padding: EdgeInsets.only(right: 20),
          child: _buildSingleFormField(
            type: widget.searchFieldType1,
            hint: widget.searchHint1,
            onChanged: (value) {
              this._data.searchField1 = value;
              enableButton(this._data);
            },
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 35,
          padding: EdgeInsets.only(left:20),
          child: _buildSingleFormField(
            type: widget.searchFieldType2,
            hint: widget.searchHint2,
            onChanged: (value) {
              this._data.searchField2 = value;
              enableButton(this._data);
            },
          ),
        ),
      ),
    ]);
  }

  Widget _buildSingleFormField({
    Function(String) onChanged,
    SearchFormFieldType type,
    String hint,
  }) {
    switch (type) {
      case SearchFormFieldType.airport:
        return AirportPickerFormField(
          onAirportSelected: (airport) {
            onChanged(airport?.code);
          },
        );

      case SearchFormFieldType.text:
        return TextFormField(
          style: AaeTextStyles.subtitle15Med,
          keyboardType: TextInputType.text,
          decoration: textFieldDecoration.copyWith(
            hintText: hint,
          ),
          onChanged: onChanged,
        );

      case SearchFormFieldType.number:
        return TextFormField(
          style: AaeTextStyles.subtitle15Med,
          keyboardType: TextInputType.number,
          decoration: textFieldDecoration.copyWith(
            hintText: hint,
          ),
          onChanged: onChanged,
        );
    }
  }

  _buildFormDatePicker() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              height: 150,
              child: DatePickerComponent(
                  searchFormData: this._data,
                  calendarLength: widget.calendarLength)),
        ),
      ],
    );
  }

  _buildLargeButton() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 55, right: 55),
      child: ButtonTheme(
        height: AaeDimens.regularButtonHeight,
        minWidth: double.infinity,
        child: RaisedButton(
          disabledColor: Color.fromRGBO(208, 218, 224, 1.0),
          disabledTextColor: AaeColors.white100,
          color: AaeColors.blue,
          textColor: AaeColors.white100,
          onPressed:
              isEnabled ? () => submit(context, widget.searchType) : null,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0)),
          child: Text('Search', style: AaeTextStyles.btn18),
        ),
      ),
    );
  }
}
