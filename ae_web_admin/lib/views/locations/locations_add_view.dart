import 'package:american_essentials_web_admin/api/api_locations_add.dart';
import 'package:american_essentials_web_admin/api/api_locations_update.dart';
import 'package:american_essentials_web_admin/common/api_helper.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/common/validation.dart';
import 'package:american_essentials_web_admin/models/locations_model.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/views/locations/locations_view.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/general/form_row.dart';
import 'package:american_essentials_web_admin/widgets/general/form_title.dart';
import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:american_essentials_web_admin/widgets/processing.dart';
import 'package:flutter/material.dart';

enum _Mode {
  Add,
  Update,
}

class LocationsAddView extends StatefulWidget {
  static String routeId = 'LocationsAddView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  LocationsAddView({this.payload});

  @override
  _LocationsAddViewState createState() => _LocationsAddViewState();
}

class _LocationsAddViewState extends State<LocationsAddView> {
  // Setup any required variables
  GlobalKey<FormState> _formKey;
  LocationsModel _locationsModel = LocationsModel();
  _Mode _mode = _Mode.Add;

  @override
  void initState() {
    super.initState();

    // Check to see if a payload was supplied
    if (widget.payload != null) {
      // Switch the view to update mode
      _mode = _Mode.Update;

      // Save the model payload to a local variable
      _locationsModel = widget.payload['locationsModel'];
    }

    // Initialize the form key
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      stringHeaderTitle: _mode == _Mode.Add ? 'Add Location' : 'Edit Location',
      widgetBody: Form(
        child: Column(
          children: <Widget>[
            FormFieldTitle(
              stringTitle: 'Site',
              titleStyle: TitleStyle.Title2,
            ),
            this._siteInformation(),
            FormFieldTitle(
              stringTitle: 'Location',
              titleStyle: TitleStyle.Title2,
            ),
            this._locationInformation(),
            FormFieldTitle(
              stringTitle: 'Airport',
              titleStyle: TitleStyle.Title2,
            ),
            this._airportInformation(),
            SizedBox(
              height: Dimensions.size16px,
            ),
            RoundedButton(
              child:
                  Text(_mode == _Mode.Add ? 'Add Location' : 'Edit Location'),
              onPressed: () async {
                // Check to see if the form is valid
                if (_formKey.currentState.validate()) {
                  // Check to see if the view is in add or update mode
                  if (_mode == _Mode.Add) {
                    // Show the Processing view
                    Processing.showProcessingView(buildContext: context);

                    // Attempt to insert the calendar event
                    ApiLocationsAddResult apiLocationsAddResult =
                        await ApiLocationsAdd.sendRequest(
                      locationsModel: _locationsModel,
                    );

                    // Execute the API Helper
                    ApiHelper.execute(
                      buildContext: context,
                      boolDismissProcessingOnError: true,
                      httpStatusCode: apiLocationsAddResult.statusCode,
                      onSuccess: () {
                        // Hide the processing view
                        Processing.dismiss(buildContext: context);

                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: context,
                          stringRouteId: LocationsView.routeId,
                        );
                      },
                    );
                  } else {
                    // Show the Processing view
                    Processing.showProcessingView(buildContext: context);

                    // Attempt to update the calendar event
                    ApiLocationsUpdateResult apiLocationsUpdateResult =
                        await ApiLocationsUpdate.sendRequest(
                      locationsModel: _locationsModel,
                    );

                    // Execute the API Helper
                    ApiHelper.execute(
                      buildContext: context,
                      boolDismissProcessingOnError: true,
                      httpStatusCode: apiLocationsUpdateResult.statusCode,
                      onSuccess: () {
                        // Hide the processing view
                        Processing.dismiss(buildContext: context);

                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: context,
                          stringRouteId: LocationsView.routeId,
                        );
                      },
                    );
                  }
                }
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        key: this._formKey,
      ),
    );
  }

  // MARK: - Widgets

  /// Information regarding the the airport (if applicable)
  Widget _airportInformation() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'FAA',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _locationsModel.faa,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _locationsModel.faa = stringValue;
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'ICAO',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _locationsModel.icao,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _locationsModel.icao = stringValue;
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
      ],
    );
  }

  /// Information regarding the location
  Widget _locationInformation() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Country',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _locationsModel.country,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _locationsModel.country = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _locationsModel.country,
                  stringError: "Please enter the location's country",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'State',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _locationsModel.state,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _locationsModel.state = stringValue;
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'City',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _locationsModel.city,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _locationsModel.city = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _locationsModel.city,
                  stringError: "Please enter the location's city",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        )
      ],
    );
  }

  /// Information regarding the location
  Widget _siteInformation() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Name',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _locationsModel.name,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _locationsModel.name = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _locationsModel.name,
                  stringError: "Please enter the location's name",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        )
      ],
    );
  }
}