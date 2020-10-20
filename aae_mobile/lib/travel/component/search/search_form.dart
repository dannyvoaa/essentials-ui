import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/flight_status/flight_status_component.dart';
import 'package:aae/travel/component/flight_status/flight_status_details.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:aae/travel/page/travel_page.dart';
import 'package:flutter/material.dart';
import '../search/date_picker_component.dart';

class _SearchFormData {
  String searchField1;
  String searchField2;
}

class SearchForm<T> extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  _SearchFormData _data = new _SearchFormData();

  SearchForm(
      {this.context,
      this.searchField1,
      this.searchHint1,
      this.searchField2,
      this.searchHint2});

  final BuildContext context;
  final String searchField1;
  final String searchHint1;
  final String searchField2;
  final String searchHint2;

  @override
  Widget build(BuildContext context) {
    return _buildSearchBox(context);
  }

  void submit(BuildContext context) {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the search form data.');
      print('searchField1: ${_data.searchField1}');
      print('searchField2: ${_data.searchField2}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlightStatusComponent(
              searchField1: _data.searchField1,
              searchField2: _data.searchField2),
        ),
      );
    }
  }

  _buildSearchBox(BuildContext context) {
    bool flightNumberEntered = false;
    bool fromEntered = false;

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Wrap(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(searchField1),
                )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 20),
                    child: Text(searchField2),
                  ),
                )
              ],
            ),
            Row(children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: this.searchHint1,
                        ),
                        onSaved: (String value) {
                          this._data.searchField1 = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: this.searchHint2,
                        ),
                        onSaved: (String value) {
                          this._data.searchField2 = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ))),
            ]),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(height: 150, child: DatePickerComponent()),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: ButtonTheme(
                height: AaeDimens.regularButtonHeight,
                minWidth: double.infinity,
                child: RaisedButton(
                  disabledColor: AaeColors.gray,
                  color: AaeColors.blue,
                  textColor: AaeColors.white,
                  onPressed: () {
//                // Validate will return true if the form is valid, or false if
//                // the form is invalid.

//                    if (_formKey.currentState.validate()) {
//                      print(_formKey.currentState);
//                      Navigator.pushNamed(context, '/second');
//                    }

                    this.submit(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('Search'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
