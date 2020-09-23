import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import '../search/date_picker_component.dart';

class SearchForm<T> extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SearchForm({this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return _buildSearchBox(context);
  }

  _buildSearchBox(BuildContext context) {
    bool flightNumberEntered = false;
    bool fromEntered = false;

    return Form(
      key: _formKey,
      child: Wrap(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Flight number")),
                Expanded(
                  child: Text("From"),
                ),
              ],
            ),
          ),
          Expanded(
              child: Row(children: <Widget>[
            Expanded(
                child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            )),
            Expanded(
                child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'City/airport',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            )),
          ])),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(height: 200, child: DatePickerComponent()),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              disabledColor: AaeColors.gray,
              color: AaeColors.blue,
              textColor: AaeColors.white,
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  print(_formKey);
                }
              },
              child: Text('Search'),
            ),
          ),
        ],
      ),
    );
  }
}
