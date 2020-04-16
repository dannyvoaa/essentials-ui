import 'package:american_essentials_web_admin/api/api_locations_delete.dart';
import 'package:american_essentials_web_admin/api/api_locations_fetch.dart';
import 'package:american_essentials_web_admin/common/alerts.dart';
import 'package:american_essentials_web_admin/common/api_helper.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/models/locations_model.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/views/locations/locations_add_view.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/cells/error_cell.dart';
import 'package:american_essentials_web_admin/widgets/cells/location_cell.dart';
import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:american_essentials_web_admin/widgets/processing.dart';
import 'package:flutter/material.dart';

class LocationsView extends StatefulWidget {
  static String routeId = 'LocationsView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  LocationsView({this.payload});

  @override
  _LocationsViewState createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  // Setup any required variables
  List<LocationsModel> _listLocations = List<LocationsModel>();
  LocalStorage _localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();

    // Initialize local storage
    _localStorage.initialize().then((value) {
      // Reload the data source
      this._reloadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      boolBodyBottomPadding: false,
      boolBodyTopPadding: false,
      stringHeaderTitle: 'Locations',
      widgetBody: this._body(),
      widgetHeaderActions: RoundedButton(
        child: Text('Add Location'),
        onPressed: () {
          // Push to a new view with the fade animation
          Transitions.pushReplacementWithFade(
            buildContext: context,
            stringRouteId: LocationsAddView.routeId,
          );
        },
      ),
    );
  }

  // MARK: - Data

  /// Reload the data source
  Future<void> _reloadData() async {
    // Delay execution
    Future.microtask(() async {
      // Show the Processing view
      Processing.showProcessingView(buildContext: context, animated: false);

      // Delay execution to allow the Processing view to animate in
      Future.delayed(Duration(milliseconds: 250), () async {
        // Reset the list of locations
        _listLocations.clear();

        // Request data from the API
        ApiLocationsFetchResult apiLocationsFetchResult =
            await ApiLocationsFetch.sendRequest();

        // Execute the API Helper
        ApiHelper.execute(
          buildContext: context,
          boolDismissProcessingOnError: true,
          httpStatusCode: apiLocationsFetchResult.statusCode,
          onSuccess: () {
            // Populate the list with event data from the API
            _listLocations = apiLocationsFetchResult.data;

            // Update the application's state
            setState(() {});

            // Check to see if this view is currently at the top of the stack
            if (!ModalRoute.of(context).isCurrent) {
              // Hide the processing view
              Processing.dismiss(buildContext: context);
            }
          },
        );
      });
    });
  }

  /// Reload the list view
  List<Widget> _reloadListView() {
    // Setup any required variables
    List<Widget> listWidgets = List<Widget>();

    // Check to see if _listLocations has data
    if (_listLocations.length > 0) {
      // Iterate through each LocationsModel in the list
      for (LocationsModel locationModel in _listLocations) {
        // Add an item to the list of widgets
        listWidgets.add(
          // Add a new location cell
          LocationCell(
            stringId: locationModel.id,
            stringCity: locationModel.city,
            stringCountry: locationModel.country,
            stringFaa: locationModel.faa,
            stringIcao: locationModel.icao,
            stringName: locationModel.name,
            stringState: locationModel.state,
            onDeleteAction: () {
              // Confirm that the user would like to delete this event
              this._deleteAction(
                buildContext: context,
                locationsModel: locationModel,
              );
            },
            onEditAction: () {
              // Push to the add/edit view
              this._editAction(
                buildContext: context,
                locationsModel: locationModel,
              );
            },
          ),
        );
      }
    } else {
      // Add an item to the list of widgets
      listWidgets.add(
        ErrorCell(
          stringMessage:
              'No locations were found or the network connection is unavailable.',
        ),
      );
    }

    return listWidgets;
  }

  // MARK: - Widgets

  Widget _body() {
    return Column(
      children: <Widget>[
        Container(
          child: ListView(
            children: _reloadListView(),
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            primary: false,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: CustomColors.separator,
                width: Dimensions.sizeDivider,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Action to be executed when the user taps the delete button
  void _deleteAction({
    @required BuildContext buildContext,
    @required LocationsModel locationsModel,
  }) async {
    // Alert: Bad username or password
    var dialogResult = await Alerts.delete(
      buildContext: buildContext,
      stringObject: 'location',
    );

    // Check to see what action was selected
    if (dialogResult.toString().toLowerCase() == 'delete') {
      // Show the Processing view
      Processing.showProcessingView(buildContext: context);

      // Attempt to delete the calendar event
      ApiLocationsDeleteResult apiLocationsDeleteResult =
          await ApiLocationsDelete.sendRequest(
        locationsModel: locationsModel,
      );

      // Execute the API Helper
      ApiHelper.execute(
        buildContext: context,
        boolDismissProcessingOnError: true,
        httpStatusCode: apiLocationsDeleteResult.statusCode,
        onSuccess: () {
          // Hide the processing view
          Processing.dismiss(buildContext: context);

          // Reload the data source
          this._reloadData();
        },
      );
    }
  }

  /// Action to be executed when the user taps the edit button
  void _editAction({
    @required BuildContext buildContext,
    @required LocationsModel locationsModel,
  }) async {
    // Push to a new view with the fade animation
    Transitions.pushReplacementWithFade(
      buildContext: context,
      stringRouteId: LocationsAddView.routeId,
      payload: {'locationsModel': locationsModel},
    );
  }
}
