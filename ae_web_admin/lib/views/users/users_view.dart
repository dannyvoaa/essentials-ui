import 'package:american_essentials_web_admin/api/api_users_fetch.dart';
import 'package:american_essentials_web_admin/common/api_helper.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/models/users_model.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/views/users/users_add_view.dart';
import 'package:american_essentials_web_admin/views/users/users_filters_view.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/cells/basic_cell.dart';
import 'package:american_essentials_web_admin/widgets/cells/error_cell.dart';
import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:american_essentials_web_admin/widgets/processing.dart';
import 'package:flutter/material.dart';

class UsersView extends StatefulWidget {
  static String routeId = 'UsersView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  UsersView({this.payload});

  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  // Setup any required variables
  List<UsersModel> _listUsers = List<UsersModel>();
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
      stringHeaderTitle: 'Users',
      widgetBody: this._body(),
      widgetHeaderActions: Row(
        children: <Widget>[
          RoundedButton(
            child: Text('Filters'),
            onPressed: () {
              // Show the Calendar Filters view
              showDialog(
                context: context,
                child: UsersFiltersView(
                  onApplyAction: () {
                    // Reload the data source
                    this._reloadData();
                  },
                ),
              );
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
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
        // Reset the list of users
        _listUsers.clear();

        // Request data from the API
        ApiUsersFetchResult apiUsersFetchResult =
            await ApiUserFetch.sendRequest();

        // Execute the API Helper
        ApiHelper.execute(
          buildContext: context,
          boolDismissProcessingOnError: true,
          httpStatusCode: apiUsersFetchResult.statusCode,
          onSuccess: () {
            // Populate the list with user data from the API
            _listUsers = apiUsersFetchResult.data;

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

    // Check to see if _listUsers has data
    if (_listUsers.length > 0) {
      // Iterate through each UsersModel in the list
      for (UsersModel usersModel in _listUsers) {
        // Add an item to the list of widgets
        listWidgets.add(
          // Add a new basic cell
          BasicCell(
            stringId: usersModel.id,
            stringLabel: usersModel.aaId,
            stringEditButtonLabel: 'View',
            boolShowDelete: false,
            onEditAction: () {
              // Push to the add/edit view
              this._editAction(
                buildContext: context,
                usersModel: usersModel,
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
              'No users were found or the network connection is unavailable.',
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

  /// Action to be executed when the user taps the edit button
  void _editAction({
    @required BuildContext buildContext,
    @required UsersModel usersModel,
  }) async {
    // Push to a new view with the fade animation
    Transitions.pushReplacementWithFade(
      buildContext: context,
      stringRouteId: UsersAddView.routeId,
      payload: {'usersModel': usersModel},
    );
  }
}
